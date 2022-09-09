//
//  TokenContainer.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


struct TokenContainer {
    
    let token: String
    let receivingDate: Date
    
    var tokenExpiringTime: TimeInterval {
        return 39600
    }
    
    var isExpired: Bool {
        let now = Date()
        if receivingDate.addingTimeInterval(tokenExpiringTime) > now {
            return false
        } else {
            return true
        }
    }
    
}
