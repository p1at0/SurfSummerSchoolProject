//
//  ProfileRouter.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import Foundation


final class ProfileRouter: ProfileRouterInput {
    
    //MARK: - Properties
    
    weak var view: ModuleTransitionable?
    
    //MARK: - ProfileRouterInput
    
    func showAlertModule(output: ActionLogoutAcceptModuleOutput) {
        let alertController = ActionLogoutAcceptAlertController(title: "Внимание", message: "Вы точно хотите\nвыйти из приложения?", preferredStyle: .alert)
        alertController.configure(output: output)
        view?.presentModule(alertController, animated: true, completion: nil)
    }
}
