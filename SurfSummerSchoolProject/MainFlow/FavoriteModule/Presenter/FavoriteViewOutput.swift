//
//  FavoriteViewOutput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


protocol FavoriteViewOutput: AnyObject {
    var favoriteItems: [ItemModel] { get set }
    func fetchFavoritePictures()
    func showAlertController(for indexPath: IndexPath)
    func showSearchViewController()
}
