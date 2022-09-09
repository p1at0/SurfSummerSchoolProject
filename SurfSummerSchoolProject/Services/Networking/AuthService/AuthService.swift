//
//  AuthService.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


struct AuthService {
    let dataTask = BaseNetworkTask<AuthRequestModel, AuthResponseModel>(isNeedInjectToken: false, method: .post, path: "/auth/login")
    
    func performLoginRequestAndSaveToken(
        credentials: AuthRequestModel,
        _ onResponseWasReceived: @escaping (_ result: Result<AuthResponseModel, AuthError>) -> Void) {
            dataTask.performAuth(input: credentials) { result in
                if case let .success(responseModel) = result {
                    try? dataTask.tokenStorage.set(newToken: TokenContainer(token: responseModel.token, receivingDate: .now))
                }
                onResponseWasReceived(result)
            }
        }
}
