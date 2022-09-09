//
//  FavoriteRouterInput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 15/08/22.
//

import Foundation


protocol FavoriteRouterInput {
    func showAlerModule(output: ActionWithPictureModuleOutput, item: ItemModel)
    func showSearchModule()
}
