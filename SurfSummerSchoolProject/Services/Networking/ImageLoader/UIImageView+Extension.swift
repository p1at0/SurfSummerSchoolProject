//
//  UIImageView+Extension.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation
import UIKit


extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                self?.image = image
                
            }
        }
    }
}
