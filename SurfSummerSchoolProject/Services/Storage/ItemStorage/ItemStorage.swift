//
//  ItemStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 12/08/22.
//

import Foundation


final class ItemStorage {
    
    //MARK: - Properties
    
    var items: [ItemModel] = []
    static let shared = ItemStorage()
    
    //MARK: - Initialization
    
    private init() {}
}
