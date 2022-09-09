//
//  LogoutError.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 20/08/22.
//

import Foundation


enum LogoutError: Error {
    case notLogout
    case serverError(error: Error)
}

extension LogoutError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .notLogout:
            return "Не удалось выйти, попробуйте еще раз"
        case .serverError(let error):
            return "\(error.localizedDescription)"
        }
    }
}
