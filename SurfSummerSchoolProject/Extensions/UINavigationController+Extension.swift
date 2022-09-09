//
//  UINavigationController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 07/08/22.
//

import Foundation
import UIKit


extension UINavigationController {
    func configureBackBarItem(image: UIImage?, title: String = "") {
        self.navigationBar.backIndicatorImage = image
        self.navigationBar.backIndicatorTransitionMaskImage = image
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        self.navigationBar.tintColor = .black
    }
}
