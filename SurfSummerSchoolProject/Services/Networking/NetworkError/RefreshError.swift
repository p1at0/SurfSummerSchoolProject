//
//  RefreshError.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 21/08/22.
//

import Foundation


enum RefreshError: Error {
    case noInternetConnection
    case serverError(error: Error)
}

extension RefreshError {
    var errorDescription: String {
        switch self {
        case .noInternetConnection:
            return "Отсутствует интернет-соединение\nПопробуйте позже"
        case .serverError(error: let error):
            return "\(error.localizedDescription)"
        }
    }
}
