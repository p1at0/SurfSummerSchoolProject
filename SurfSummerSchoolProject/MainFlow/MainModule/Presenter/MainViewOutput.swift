//
//  MainViewOutput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 07/08/22.
//

import Foundation


protocol MainViewOutput: AnyObject {
    var router: MainRouterInput? { get }
    var itemStorage: ItemStorage { get set }
    var favoriteService: FavoriteService { get }
    func showDetailViewController(for indexPath: IndexPath)
    func showSearchViewController()
    func loadPosts()
    func refreshPosts(_ completion: @escaping () -> Void)
    func changeFavoriteStatus(for indexPath: IndexPath, isFavorite: Bool)
    func reloadCollectionView()
    func getItem(for indexPath: IndexPath) -> ItemModel
}
