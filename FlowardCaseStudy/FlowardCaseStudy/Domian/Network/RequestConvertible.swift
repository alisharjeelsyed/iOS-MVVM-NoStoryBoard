//
//  RequestConvertible.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation


//MARK: - HTTPMethod

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

//MARK: - EndPoint
public struct RequestConvertible {
    
    //MARK: - Properties
    private(set) var method: HTTPMethod
    private let route: String
    private let baseURL: String
    private let queryParams: [String: String]?
    let headers: [String: String]
    private let body: Data?
    let bodyParameter: [String: Any]
    
    private var url: URL? {
        
        guard var components = URLComponents(string: "\(baseURL)\(route)") else { return nil }
        components.queryItems = queryParams?
            .map {
                URLQueryItem(name: $0, value: $1)
        }
        return components.url!
    }
    
    //MARK: - Init
    public init(
        method: HTTPMethod = .get,
        baseURl: String? = nil,
        route: String = "",
        queryParams: [String: String]? = nil,
        headers: [String: String] = [:],
        body: Data? = nil,
        bodyParameter: [String: Any] = [:]) {
        
        self.method = method
        self.route = route
        self.baseURL = ""
        self.queryParams = queryParams
        self.headers = headers
        self.body = body
        self.bodyParameter = bodyParameter
    }
    
    //TODO: - Need to add paramter encoding on Body for POST Request
    
    //MARK: - Method
    func urlRequest() -> URLRequest? {
        
        guard let url = url else { return nil }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.set(headers: headers)
        request.httpBody = body
        
        return request
    }
    
    func getPostString(params:[String: Any]) -> Data?
    {
        return params.percentEncoded()?.data(using: .utf8)
    }
    
}

extension Dictionary {
    func percentEncoded() -> String? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
