//
//  AuthError.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 20/08/22.
//

import Foundation


enum AuthError: Error {
    case incorrectDataError
    case noConnectionError
    case serverError(error: Error)
}

extension AuthError {
    var errorDescription: String {
        switch self {
        case .incorrectDataError:
            return "Логин или пароль введен неправильно"
        case .noConnectionError:
            return "Нет подключения к сети"
        case .serverError(error: let error):
            return "Server error \(error.localizedDescription)"
        }
    }
}
