//
//  FavoriteRouter.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 15/08/22.
//

import Foundation


final class FavoriteRouter: FavoriteRouterInput {
    
    //MARK: - Properties
    
    weak var view: ModuleTransitionable?
    
    //MARK: - FavoriteRouterInput
    
    func showAlerModule(output: ActionWithPictureModuleOutput, item: ItemModel) {
        let alertController = ActionWithPictureAlertController(title: "Внимание",
                                                               message: "Вы точно хотите удалить\nиз избранного?",
                                                               preferredStyle: .alert)
        alertController.configure(output: output, item: item)
        view?.presentModule(alertController, animated: true, completion: nil)
    }
    
    func showSearchModule() {
        view?.push(module: SearchModuleConfigurator().configure(), animated: true)
    }
}
