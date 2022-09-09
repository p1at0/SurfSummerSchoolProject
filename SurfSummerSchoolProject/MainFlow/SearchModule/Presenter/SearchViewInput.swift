//
//  SearchViewInput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 11/08/22.
//

import Foundation


protocol SearchViewInput: AnyObject {
    func reload()
    func showHelper(_ status: HelperStatus)
    func showCollection()
}
