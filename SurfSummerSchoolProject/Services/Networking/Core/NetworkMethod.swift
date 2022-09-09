//
//  NetworkMethod.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


protocol NetworkMethod {
    var method: String { get }
    var isMutating: Bool { get }
}
