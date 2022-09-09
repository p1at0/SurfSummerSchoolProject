//
//  FavoriteService.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 13/08/22.
//

import Foundation


final class FavoriteService {

    //MARK: - properties
    
    private var keyFavoriteItem: String {
        return "favorite"
    }
    private let storage = UserDefaults.standard
    static let shared = FavoriteService()
    private var savedItems: [String] = []
    
    //MARK: - Initialization
    
    private init() {
        getDataFromUserDefaults()
    }
    
    //MARK: - Internal methods
    
    func changeStatus(id: String, isFavorite: Bool) {
        if isFavorite {
            saveFavoriteItem(id)
        } else {
            removeFavoriteItem(id)
        }
    }
    
    func isFavoriteItem(id: String) -> Bool {
        guard let items = getFavoriteItems() else {
            return false
        }
        return items.contains(id) ? true : false
    }
    
    func removeFavoriteItems() {
        storage.removeObject(forKey: keyFavoriteItem)
    }
    
}

//MARK: - Private methods

private extension FavoriteService {
    
    func saveFavoriteItem(_ id: String) {
        savedItems.insert(id, at: 0)
        saveToUserDefaults()
    }
    
    func removeFavoriteItem(_ id: String) {
        savedItems = savedItems.filter({ !($0 == id)})
        saveToUserDefaults()
    }

    func saveToUserDefaults() {
        let dataForUserDefaults = try? JSONEncoder().encode(savedItems)
        storage.set(dataForUserDefaults, forKey: keyFavoriteItem)
    }
    
    func getDataFromUserDefaults() {
        guard let dataFromUserDefaults = storage.value(forKey: keyFavoriteItem) as? Data,
              let items = try? JSONDecoder().decode([String].self, from: dataFromUserDefaults) else {
            return
        }
        savedItems = items
    }
    
    func getFavoriteItems() -> [String]? {
        guard let dataFromUserDefaults = storage.value(forKey: keyFavoriteItem) as? Data,
              let items = try? JSONDecoder().decode([String].self, from: dataFromUserDefaults) else {
            return nil
        }
        return items
    }
}
