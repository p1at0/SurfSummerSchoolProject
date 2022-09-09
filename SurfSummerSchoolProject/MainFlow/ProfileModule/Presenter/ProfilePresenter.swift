//
//  ProfilePresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import Foundation


final class ProfilePresenter: ProfileViewOutput {
    
    //MARK: - Properties
    
    weak var view: ProfileViewInput?
    var router: ProfileRouterInput?
    var logoutService: LogoutService = .init()
    
    //MARK: - ProfileViewOutput
    
    func showAlertController() {
        router?.showAlertModule(output: self)
    }
    
    func getProfile() -> AuthResponseModel? {
        return ProfileService().getProfile()
    }
}

//MARK: - ActionLogoutAcceptModuleOutput

extension ProfilePresenter: ActionLogoutAcceptModuleOutput {
    func logout() {
        view?.startLoading()
        logoutService.performLogoutRequestAndRemoveToken({ result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(_):
                    self?.view?.hideWarningView()
                    self?.view?.stopLoading()
                    self?.view?.showLoginFlow()
                    
                case .failure(let error):
                    self?.view?.showWarningView(errorDescription: error.localizedDescription)
                    self?.view?.stopLoading()
                }
            }
        })
    }
}
