//
//  FavoritePresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


final class FavoritePresenter: FavoriteViewOutput {
    
    //MARK: - Properties
    
    weak var view: FavoriteViewInput?
    var router: FavoriteRouterInput?
    let favoriteService = FavoriteService.shared
    var itemStorage = ItemStorage.shared
    var favoriteItems: [ItemModel] = [] {
        didSet {
            if favoriteItems.isEmpty {
                view?.showHelperView()
            } else {
                view?.hideHelperView()
            }
        }
    }
    
    //MARK: - FavoriteViewOutput
    
    func fetchFavoritePictures() {
        favoriteItems = itemStorage.items.filter{ favoriteService.isFavoriteItem(id: $0.id) }
        view?.reload()
    }
    
    func showAlertController(for indexPath: IndexPath) {
        router?.showAlerModule(output: self, item: favoriteItems[indexPath.item])
    }
    
    func showSearchViewController() {
        router?.showSearchModule()
    }
}

//MARK: - ActionWithPictureModuleOutput

extension FavoritePresenter: ActionWithPictureModuleOutput {
    func remove(item: ItemModel) {
        favoriteItems = favoriteItems.filter{ !($0.id == item.id) }
        favoriteService.changeStatus(id: item.id, isFavorite: false)
        view?.reload()
    }
}
