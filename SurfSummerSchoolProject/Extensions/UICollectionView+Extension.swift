//
//  UICollectionView+Extension.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 07/08/22.
//

import Foundation
import UIKit


extension UICollectionView {
    func registerCell(_ someObject: AnyClass) {
        self.register(UINib(nibName: "\(someObject.self)", bundle: nil),
                      forCellWithReuseIdentifier: "\(someObject.self)")
    }
}
