//
//  NetworkManager.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

//MARK: - Netwworking Protocol
protocol NetworkManager {
    func reqeustJSONApi(endPoint: RequestConvertible, completion: @escaping ((NetworkResult<Data>) -> Void))

}

//MARK: - Netwworking Protocol Implementation
public class AppNetworkManager: NetworkManager {

    
    //MARK: - Properties
    private let session: URLSession
    
    //MARK: - Init
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    //MARK: - Methods
    func reqeustJSONApi(endPoint: RequestConvertible, completion: @escaping ((NetworkResult<Data>) -> Void)) {

        guard let endPointRequest =  endPoint.urlRequest(), let url = endPointRequest.url else {
            completion(.failure(.requestCreation))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.headers
        request.httpBody = endPointRequest.httpBody

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let err = error {
                completion(.failure(.server(err)))
            } else {
                if let dta = data {
                    completion(.success(dta))
                }
            }
        })
        
        dataTask.resume()
    }
}
