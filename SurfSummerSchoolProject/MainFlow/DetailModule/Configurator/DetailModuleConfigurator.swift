//
//  DetailModuleConfigurator.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 08/08/22.
//

import Foundation


struct DetailModuleConfigurator {
    
    func configure(item: ItemModel) -> DetailViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(item: item)
        
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
