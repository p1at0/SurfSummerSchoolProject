//
//  HelperStatus.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 14/08/22.
//

import Foundation
import UIKit


enum HelperStatus {
    case noResult
    case writeRequest
    case noFavorites
    case failedLoadPosts
    
    var title: String {
        switch self {
        case .noResult:
            return "По этому запросу нет результатов,\nпопробуйте другой запрос"
        case .writeRequest:
            return "Введите ваш запрос"
        case .noFavorites:
            return "Нет избранных"
        case .failedLoadPosts:
            return "Не удалось загрузить ленту\nОбновите экран или попробуйте позже"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .noResult:
            return Icon.noResult
        case .writeRequest:
            return Icon.searchHelper
        case .noFavorites:
            return Icon.noResult
        case .failedLoadPosts:
            return Icon.noResult
        }
    }
}
