//
//  NetworkError.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

enum NetworkError: Error {
    case sslPinningFailed
    case internetOffline
    case requestCreation
    case decoding(Data, Error)
    case server(Error)
    case unknown
    
    var message: String {
        switch self {
        case .sslPinningFailed:
            return "SSL Failed"
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
    
    var errorCode: Int {
        switch self {
        case .internetOffline:
            return -1009
        default:
            return 500
        }
    }
}
