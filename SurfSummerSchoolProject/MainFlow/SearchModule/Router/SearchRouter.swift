//
//  SearchRouter.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 14/08/22.
//

import Foundation


final class SearchRouter: SearchRouterInput {
    
    //MARK: - Properties
    
    weak var view: ModuleTransitionable?
    
    //MARK: - SearchRouterInput
    
    func showDetailModule(item: ItemModel) {
        view?.push(module: DetailModuleConfigurator().configure(item: item), animated: true)
    }
}
