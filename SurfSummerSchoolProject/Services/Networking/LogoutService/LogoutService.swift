//
//  LogoutService.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 20/08/22.
//

import Foundation


struct LogoutService {
    
    let dataTask = BaseNetworkTask<EmptyModel, EmptyModel>(isNeedInjectToken: false, method: .post, path: "/auth/logout")
    
    func performLogoutRequestAndRemoveToken(_ onResponseWasReceived: @escaping (_ result: Result<EmptyModel, LogoutError>) -> Void) {
        dataTask.performLogout { result in
            switch result {
            case .success(let emptyModel):
                try? dataTask.tokenStorage.removeTokenFromContainer()
                ProfileService().remove()
                URLCache.shared.removeAllCachedResponses()
                FavoriteService.shared.removeFavoriteItems()
                ItemStorage.shared.items = []
                onResponseWasReceived(.success(emptyModel))
            case .failure(let error):
                onResponseWasReceived(.failure(error))
            }
        }
    }
}
