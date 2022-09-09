//
//  UITableView+Extension.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 08/08/22.
//

import Foundation
import UIKit


extension UITableView {
    func registerCell(_ someObject: AnyClass) {
        self.register(UINib(nibName: "\(someObject.self)", bundle: nil), forCellReuseIdentifier: "\(someObject.self)")
    }
}
