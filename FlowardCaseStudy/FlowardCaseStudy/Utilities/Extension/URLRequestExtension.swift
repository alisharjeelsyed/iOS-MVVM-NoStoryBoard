//
//  URLRequestExtension.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

extension URLRequest {
    
    mutating func set(headers: [String: String]) {
        for (key,value) in headers {
            addValue(key, forHTTPHeaderField: value)
        }
    }
}
