//
//  BaseTokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


struct BaseTokenStorage: TokenStorage {
    
    //MARK: - Nested Types
    
    private enum Constants {
        static let applicationNameInKeyChain = "com.example.SurfSummerSchoolProject"
        static let tokenKey = "token"
        static let tokenDateKey = "tokenDate"
    }
    
    //MARK: - Private Properties
    
    private var unprotectedStorage: UserDefaults {
        return UserDefaults.standard
    }
    
    //MARK: - TokenStorage
    
    func getToken() throws -> TokenContainer {
        
        
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(queryDictionaryForSavingToken as CFDictionary, &result)
        
        try throwErrorFromStatusIfNeeded(status)
        
        guard let data = result as? Data else {
            throw Error.tokenWasNotFoundInKeyChainOrCantRepresentAsData
        }
        
        let retrivingToken = try JSONDecoder().decode(String.self, from: data)
        let tokenSavingDate = try getSavingTokenDate()
        
        return TokenContainer(token: retrivingToken, receivingDate: tokenSavingDate)
    }
    
    func set(newToken: TokenContainer) throws {
        
        try removeTokenFromContainer()
        
        
        let tokenInData = try JSONEncoder().encode(newToken.token)
        
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecValueData: tokenInData as AnyObject
        ]
        
        
        let status = SecItemAdd(queryDictionaryForSavingToken as CFDictionary, nil)
        
        try throwErrorFromStatusIfNeeded(status)
        saveTokenSavingDate(.now)
        
    }
    
    func removeTokenFromContainer() throws {
        
        let queryDictionaryForDeleteToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(queryDictionaryForDeleteToken as CFDictionary)
        
        try throwErrorFromStatusIfNeeded(status)
        
        removeTokenSavingDate()
    }
}

private extension BaseTokenStorage {
    
    enum Error: Swift.Error {
        case unkownError(status: OSStatus)
        case keyIsAlreadyInKeyChain
        case tokenWasNotFoundInKeyChainOrCantRepresentAsData
        case tokenDateWasNotFound
    }
    
    func getSavingTokenDate() throws -> Date {
        guard let savingDate = unprotectedStorage.value(forKey: Constants.tokenDateKey) as? Date else {
            throw Error.tokenDateWasNotFound
        }
        return savingDate
    }
    
    func saveTokenSavingDate(_ newDate: Date) {
        unprotectedStorage.set(newDate, forKey: Constants.tokenDateKey)
    }
    
    func removeTokenSavingDate() {
        unprotectedStorage.set(nil, forKey: Constants.tokenKey)
    }
    
    func throwErrorFromStatusIfNeeded(_ status: OSStatus) throws {
        guard status == errSecSuccess || status == -25300 else {
            throw Error.unkownError(status: status)
        }
        
        guard status != -25299 else {
            throw Error.keyIsAlreadyInKeyChain
        }
    }
}
