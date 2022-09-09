//
//  Icon.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 12/08/22.
//

import Foundation
import UIKit


enum Icon {
    static let searchHelper = UIImage(named: "SearchIcon2")?.withRenderingMode(.alwaysTemplate)
    static let noResult = UIImage(named: "noResult")?.withRenderingMode(.alwaysTemplate)
    static let backArrow = UIImage(named: "BackImage")
    static let loader = UIImage(named: "loader")
    static let securityMode = UIImage(named: "eye-off-line")?.withRenderingMode(.alwaysTemplate)
    static let noSecurityMode = UIImage(named: "eye-line")?.withRenderingMode(.alwaysTemplate)
    static let backgroundLogo = UIImage(named: "backgroundLogo")?.withRenderingMode(.alwaysTemplate)
    static let search = UIImage(named: "SearchIcon")
    static let main = UIImage(named: "MainTab")
    static let favorite = UIImage(named: "FavoriteTab")
    static let profile = UIImage(named: "ProfileTab")
}
