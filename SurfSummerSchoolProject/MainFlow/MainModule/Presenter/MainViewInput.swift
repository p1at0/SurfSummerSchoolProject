//
//  MainViewInput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 07/08/22.
//

import Foundation


protocol MainViewInput: AnyObject {
    func reload()
    func showWarning(error: String)
    func showHelperView()
    func hideHelperView()
    func startLoadAnimating()
    func stopLoadAnimating()
}
