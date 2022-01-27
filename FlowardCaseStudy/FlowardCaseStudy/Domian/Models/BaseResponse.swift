//
//  BaseResponse.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

struct BaseResponseEntity<T: Codable>: Codable {
    var success: Bool?
    var message: String?
    var errorMessage: String?
    var items: T?
    var token: String?
}
