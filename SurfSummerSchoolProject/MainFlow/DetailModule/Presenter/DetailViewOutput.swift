//
//  DetailViewOutput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 08/08/22.
//

import Foundation


protocol DetailViewOutput: AnyObject {
    var item: ItemModel { get }
    init(item: ItemModel)
}
