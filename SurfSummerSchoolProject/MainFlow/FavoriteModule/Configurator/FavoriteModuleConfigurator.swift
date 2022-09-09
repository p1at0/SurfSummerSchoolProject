//
//  FavoriteModuleConfigurator.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


struct FavoriteModuleConfigurator {
    
    func configure() -> FavoriteViewController {
        let view = FavoriteViewController()
        let presenter = FavoritePresenter()
        let router = FavoriteRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.view = view
        return view
    }
}
