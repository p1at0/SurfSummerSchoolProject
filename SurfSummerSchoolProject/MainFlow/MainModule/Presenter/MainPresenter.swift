//
//  MainPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 07/08/22.
//

import Foundation


final class MainPresenter: MainViewOutput {
    
    //MARK: - Properties
    
    weak var view: MainViewInput?
    var router: MainRouterInput?
    let pictureService: PicturesService = .init()
    let favoriteService = FavoriteService.shared
    var itemStorage = ItemStorage.shared
    
    //MARK: - MainViewOutput
    
    func reloadCollectionView() {
        view?.reload()
    }
    
    func showDetailViewController(for indexPath: IndexPath) {
        router?.showDetailModule(item: itemStorage.items[indexPath.item])
    }
    
    func loadPosts() {
        getPictures()
    }
    
    func refreshPosts(_ completion: @escaping () -> Void) {
        pullToRefresh(completion)
    }
    
    func showSearchViewController() {
        router?.showSearchModule()
    }
    
    func changeFavoriteStatus(for indexPath: IndexPath, isFavorite: Bool) {
        let currentItem = itemStorage.items[indexPath.item]
        itemStorage.items[indexPath.item].isFavorite = isFavorite
        favoriteService.changeStatus(id: currentItem.id, isFavorite: isFavorite)
    }
    
    func getItem(for indexPath: IndexPath) -> ItemModel {
        return itemStorage.items[indexPath.item]
    }
}

//MARK: - Private methods

private extension MainPresenter {
    
    func getPictures() {
        view?.startLoadAnimating()
        pictureService.loadPictures { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let pictures):
                DispatchQueue.main.async {
                    self.itemStorage.items = pictures.map({ picture in
                        return ItemModel(pictureResponse: picture, isFavorite: self.favoriteService.isFavoriteItem(id: picture.id))
                    })
                    if self.itemStorage.items.isEmpty {
                        self.view?.showHelperView()
                        self.view?.stopLoadAnimating()
                        self.view?.reload()
                    } else {
                        self.view?.hideHelperView()
                        self.reloadCollectionView()
                        self.view?.stopLoadAnimating()
                    }
                }
            case .failure(let error):
                self.view?.showWarning(error: error.localizedDescription)
                self.view?.stopLoadAnimating()
            }
        }
    }
    
    func pullToRefresh(_ completionHandler: @escaping () -> Void) {
        pictureService.pullToRefresh { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let pictures):
                    self.itemStorage.items = pictures.map({ picture in
                        return ItemModel(pictureResponse: picture, isFavorite: self.favoriteService.isFavoriteItem(id: picture.id))
                    })
                    completionHandler()
                case .failure(let error):
                    self.view?.showWarning(error: error.errorDescription)
                }
            }
        }
    }
}
