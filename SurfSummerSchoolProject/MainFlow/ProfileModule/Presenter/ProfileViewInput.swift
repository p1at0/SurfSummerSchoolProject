//
//  ProfileViewInput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import Foundation


protocol ProfileViewInput: AnyObject {
    var isWarningViewHidden: Bool { get }
    func startLoading()
    func stopLoading()
    func showWarningView(errorDescription: String)
    func hideWarningView()
    func showLoginFlow()
}
