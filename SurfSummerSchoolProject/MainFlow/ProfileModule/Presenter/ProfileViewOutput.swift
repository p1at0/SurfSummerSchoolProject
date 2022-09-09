//
//  ProfileViewOutput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import Foundation


protocol ProfileViewOutput: AnyObject {
    func showAlertController()
    func getProfile() -> AuthResponseModel?
}
