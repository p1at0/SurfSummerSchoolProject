//
//  LoginPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 20/08/22.
//

import Foundation


final class LoginPresenter: LoginViewOutput {
    
    //MARK: - Properties
    
    weak var view: LoginViewInput?
    
    
    //MARK: - LoginViewOutput
    
    func performLogin(phone: String, password: String) {
        let credentials = AuthRequestModel(phone: phone, password: password)
        view?.startLoading()
        AuthService().performLoginRequestAndSaveToken(credentials: credentials) { [weak self] result in
            switch result {
            case .success(let response):
                ProfileService().saveProfile(response)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.stopLoading()
                    self?.view?.hideWarning()
                    self?.view?.showMainFlow()
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.showWarning(errorDescription: error.errorDescription)
                    self?.view?.stopLoading()
                }
            }
        }
    }
}
