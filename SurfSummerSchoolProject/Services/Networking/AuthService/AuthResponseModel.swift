//
//  AuthResponseModel.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


struct AuthResponseModel: Codable {
    let token: String
    let userInfo: UserInfo
    
    enum CodingKeys: String, CodingKey {
            case token
            case userInfo = "user_info"
        }
}

struct UserInfo: Codable {
    let id, phone, email, firstName: String
    let lastName: String
    let avatar: String
    let city, about: String
}
