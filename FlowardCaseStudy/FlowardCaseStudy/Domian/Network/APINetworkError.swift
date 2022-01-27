//
//  APINetworkError.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

/// Network Error Enum, Which is returned as Failture in Result enum if Network call fails.
///
/// - internetOffline: Return if internet is offline.
/// - requestCreation: If there is some issue with URL, or network request object.
/// - decoding: Issue while decoding data reterived from server.
/// - server: Call failed due to server error.
/// - error: Call successfully ended but received error.
/// - unknown: Unknown error - No description received from network call.
public enum APINetworkError: Error {
    case internetOffline
    case requestCreation
    case decoding(Data, Error)
    case server(Error)
    case unknown
    
    /// Error message.
    var message: String {
        switch self {
        case .internetOffline:
            return "The Internet connection appears to be offline."
        case .requestCreation:
            return "Request could not be created."
        case .decoding(_, let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .server(let error):
            return error.localizedDescription
        case .unknown:
            return "Unknown, known error."
        }
    }
    
    var title: String {
        switch self {
        case .internetOffline:
            return "No Internet Connection"
        case .requestCreation:
            return "Request Creation Failed"
        case .decoding(_, _):
            return "Data Decoding Failed"
        case .server(let error):
            return error.localizedDescription
        case .unknown:
            return "Something UnExpected Happened."
        }
    }
}
