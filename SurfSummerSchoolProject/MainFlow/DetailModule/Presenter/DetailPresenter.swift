//
//  DetailPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 08/08/22.
//

import Foundation


final class DetailPresenter: DetailViewOutput {
    
    //MARK: - Properties
    
    weak var view: DetailViewInput?
    var item: ItemModel
    
    //MARK: - Initialization
    
    required init(item: ItemModel) {
        self.item = item
    }
}
