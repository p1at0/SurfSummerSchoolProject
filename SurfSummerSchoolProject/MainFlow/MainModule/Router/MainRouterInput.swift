//
//  RouterInput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 07/08/22.
//

import Foundation


protocol MainRouterInput: AnyObject {
    func showDetailModule(item: ItemModel)
    func showSearchModule()
}
