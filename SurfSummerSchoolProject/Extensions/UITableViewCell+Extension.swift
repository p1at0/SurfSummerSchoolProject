//
//  UITableViewCell+Extension.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 17/08/22.
//

import Foundation
import UIKit


extension UITableViewCell {
    func configure(title: String, data: String) {
        selectionStyle = .none
        var config = defaultContentConfiguration()
        config.textProperties.font = .systemFont(ofSize: 12)
        config.textProperties.color = .gray
        config.text = title
        config.secondaryTextProperties.font = .systemFont(ofSize: 18)
        config.secondaryText = data
        contentConfiguration = config
    }
}
