//
//  LoginViewOutput.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 20/08/22.
//

import Foundation


protocol LoginViewOutput: AnyObject {
    func performLogin(phone: String, password: String)
}
