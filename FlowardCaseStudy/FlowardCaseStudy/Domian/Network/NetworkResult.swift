//
//  NetworkResult.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

/// Enum returned as result for API Network call Response in completionHandler
///
/// - success: Return generic type value If Success.
/// - failure: Return APIResponseNetworkError If Failture.
public enum NetworkResult<V> {
    case success(V)
    case failure(APINetworkError)
}
