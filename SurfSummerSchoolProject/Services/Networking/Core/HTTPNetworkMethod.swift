//
//  HTTPNetworkMethod.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


enum HTTPNetworkMethod: String {
     case get
     case post
 }

extension HTTPNetworkMethod: NetworkMethod {
    
    var method: String {
        return rawValue.uppercased()
    }
    
    var isMutating: Bool {
        switch self {
        case .get:
            return false
        case .post:
            return true
        }
    }
}
