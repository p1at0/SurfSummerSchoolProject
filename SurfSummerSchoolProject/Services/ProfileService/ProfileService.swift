//
//  ProfileService.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 20/08/22.
//

import Foundation


struct ProfileService {
    
    //MARK: - Properties
    
    private let storage = UserDefaults.standard
    
    //MARK: - Internal methods
    
    func getIDProfile() -> String? {
        guard let profile = getProfile() else {
            return nil
        }
        return profile.userInfo.id
    }
    
    func saveProfile(_ profile: AuthResponseModel) {
        saveToUserDefaults(profile: profile)
    }
    
    func getProfile() -> AuthResponseModel? {
        getDataFromUserDefaults()
    }
    
    func remove() {
        removeDataInUserDefaults()
    }
}

//MARK: - Private methods

private extension ProfileService {
    
    func saveToUserDefaults(profile: AuthResponseModel) {
        let data = try? JSONEncoder().encode(profile)
        storage.set(data, forKey: KeyForUserDefaults.profile)
    }
    
    func getDataFromUserDefaults() -> AuthResponseModel? {
        guard let dataFromUserDefaults = storage.object(forKey: KeyForUserDefaults.profile) as? Data,
              let profile = try? JSONDecoder().decode(AuthResponseModel.self, from: dataFromUserDefaults) else {
            return nil
        }
        return profile
    }
    
    func removeDataInUserDefaults() {
        storage.removeObject(forKey: KeyForUserDefaults.profile)
    }
}

//MARK: - Private enum

private extension ProfileService {
    enum KeyForUserDefaults {
        static let profile = "profile"
    }
}
