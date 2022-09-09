//
//  LoginModuleConfigurator.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 20/08/22.
//

import Foundation


struct LoginModuleConfigurator {
    
    func configure() -> LoginViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter()
        
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
