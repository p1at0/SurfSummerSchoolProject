//
//  AuthRequestModel.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


struct AuthRequestModel: Encodable {
    let phone: String
    let password: String
}
