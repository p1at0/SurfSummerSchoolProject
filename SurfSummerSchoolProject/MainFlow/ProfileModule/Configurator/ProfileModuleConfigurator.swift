//
//  ProfileModuleConfigurator.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import Foundation

struct ProfileModuleConfigurator {
    
    func configure() -> ProfileViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.view = view
        
        return view
    }
}
