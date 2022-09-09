//
//  BaseNetworkTask.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 08/08/22.
//

import Foundation


struct BaseNetworkTask<AbstractInput: Encodable, AbstractOutput: Decodable>: NetworkTask {
    
    //MARK: - NetworkTask
    
    typealias Input = AbstractInput
    typealias Output = AbstractOutput
    
    //MARK: - Properties
    
    var baseURL: URL? {
        return URL(string: "https://pictures.chronicker.fun/api")
    }
    let path: String
    let method: NetworkMethod
    let session = URLSession(configuration: .default)
    let isNeedInjectToken: Bool
    var urlCache: URLCache {
        return URLCache.shared
    }
    var tokenStorage: TokenStorage {
        return BaseTokenStorage()
    }
    
    //MARK: - Initialization
    
    init(isNeedInjectToken: Bool, method: HTTPNetworkMethod, path: String) {
        self.isNeedInjectToken = isNeedInjectToken
        self.path = path
        self.method = method
    }
    
    //MARK: - Internal methods

    func performRequest(input: AbstractInput, _ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, Error>) -> Void) {
        do {
            let request = try getRequest(with: input)
            if let cachedResponse = getCachedResponseFromCache(by: request) {
                let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: cachedResponse.data)
                onResponseWasReceived(.success(mappedModel))
                return
            }
            session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    if let error = error {
                        onResponseWasReceived(.failure(NetworkError.serverError(error: error)))
                        return
                    }
                    onResponseWasReceived(.failure(NetworkError.noConnectionError))
                    return
                }
                do {
                    let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: data)
                    onResponseWasReceived(.success(mappedModel))
                } catch {
                    onResponseWasReceived(.failure(NetworkError.incorrectDataError))
                }
            }.resume()
        } catch {
            onResponseWasReceived(.failure(error))
        }
    }
        
    func performAuth(input: AbstractInput, _ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, AuthError>) -> Void) {
        do {
            let request = try getRequest(with: input)
            session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    if error != nil {
                        onResponseWasReceived(.failure(.noConnectionError))
                        return
                    }
                    return
                }
                do {
                    let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: data)
                    onResponseWasReceived(.success(mappedModel))
                } catch {
                    onResponseWasReceived(.failure(.incorrectDataError))
                }
  
            }.resume()
        } catch {
            onResponseWasReceived(.failure(.serverError(error: error)))
        }
    }
    
    func performLogoutRequest(input: AbstractInput, _ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, LogoutError>) -> Void) {
        do {
            let request = try getRequest(with: input)
            session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    if error != nil {
                        onResponseWasReceived(.failure(.notLogout))
                        return
                    }
                    return
                }
                do {
                    let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: data)
                    onResponseWasReceived(.success(mappedModel))
                } catch {
                    onResponseWasReceived(.failure(.serverError(error: error)))
                }
            }.resume()
        } catch {
            onResponseWasReceived(.failure(.serverError(error: error)))
        }
    }
    
    func performPullToRefreshRequest(input: AbstractInput, _ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, RefreshError>) -> Void) {
        do {
            let request = try getRequest(with: input)
            session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    if error != nil {
                        onResponseWasReceived(.failure(.noInternetConnection))
                        return
                    }
                    return
                }
                do {
                    let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: data)
                    onResponseWasReceived(.success(mappedModel))
                } catch {
                    onResponseWasReceived(.failure(.serverError(error: error)))
                }
            }.resume()
        } catch {
            onResponseWasReceived(.failure(.serverError(error: error)))
        }
    }
}

extension BaseNetworkTask where Input == EmptyModel {
    func performRequest(_ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, Error>) -> Void) {
        performRequest(input: EmptyModel(), onResponseWasReceived)
    }
    
    func performLogout(_ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, LogoutError>) -> Void) {
        performLogoutRequest(input: EmptyModel(), onResponseWasReceived)
    }
    
    func performRefresh(_ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, RefreshError>) -> Void) {
        performPullToRefreshRequest(input: EmptyModel(), onResponseWasReceived)
    }
}

//MARK: - Cache logic

private extension BaseNetworkTask {
    func getCachedResponseFromCache(by request: URLRequest) -> CachedURLResponse? {
        return urlCache.cachedResponse(for: request)
    }
    
    func saveResponseToCache(_ response: URLResponse?, cachedData: Data?, by request: URLRequest) {
        guard let response = response, let cachedData = cachedData else {
            return
        }
        
        let cachedUrlResponse = CachedURLResponse(response: response, data: cachedData)
        urlCache.storeCachedResponse(cachedUrlResponse, for: request)
    }
}

//MARK: - Private methods

private extension BaseNetworkTask {
    
    enum NetworkTaskError: Error {
        case unknownError
        case urlWasNotFound
        case urlComponentsWasNotCreated
        case parametersIsNotValidJsonObject
    }
    
    func getRequest(with parameters: AbstractInput) throws -> URLRequest {
        guard let url = completedURL else {
            throw NetworkTaskError.urlWasNotFound
        }
        
        var request: URLRequest
        if method.isMutating {
            request = URLRequest(url: url)
            request.httpBody = try getParametersForBody(from: parameters)
        } else {
            let newUrl = try getUrlWithQueryParameters(for: url, parameters: parameters)
            request = URLRequest(url: newUrl)
        }
        
        
        //TODO: - Rename method
        request.httpMethod = method.method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        if isNeedInjectToken {
            request.addValue("Token \(try tokenStorage.getToken().token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    func getParametersForBody(from encodableParameters: AbstractInput) throws -> Data {
        return try JSONEncoder().encode(encodableParameters)
    }
    
    func getUrlWithQueryParameters(for url: URL, parameters: AbstractInput) throws -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkTaskError.urlComponentsWasNotCreated
        }
        let parametersInDataRepresentation = try JSONEncoder().encode(parameters)
        let parametersInDictionaryRepresentation = try JSONSerialization.jsonObject(with: parametersInDataRepresentation)
        
        guard let parametersInDictionaryRepresentation = parametersInDictionaryRepresentation as? [String: Any] else {
            throw NetworkTaskError.parametersIsNotValidJsonObject
        }
        
        let queryItems = parametersInDictionaryRepresentation.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        
        urlComponents.queryItems = queryItems
        
        guard let newUrlWithQuery = urlComponents.url else {
            throw NetworkTaskError.urlWasNotFound
        }
        
        return newUrlWithQuery
    }
}
