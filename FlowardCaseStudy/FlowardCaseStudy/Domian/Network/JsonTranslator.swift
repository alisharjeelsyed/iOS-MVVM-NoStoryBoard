//
//  JsonTranslator.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation


public protocol JsonTranslatable {
    func convertDataResponseModel<T>(with response: NetworkResult<Data>) -> NetworkResult<T> where T: Decodable
    func converDataModelToParam<T:Encodable>(withModel model:T) -> [String:Any]?
}

/// Used to convert data Received from server in JSON format to `Generic Response type` provided in request.
/// Provided Response DataType must confirm Codable.
final class JsonTranslator: JsonTranslatable {
    
    public func convertDataResponseModel<T>(with response: NetworkResult<Data>) -> NetworkResult<T> where T: Decodable {
        switch response {
        case .success(let data):
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                return .success(response)
            }
            catch {
                return  .failure(APINetworkError.decoding(data, error))
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }

    func converDataModelToParam<T:Encodable>(withModel model:T) -> [String:Any]? {

           do {
               let encodedData = try JSONEncoder().encode(model)
               return try JSONSerialization.jsonObject(with: encodedData, options:.allowFragments) as? [String: Any]
           } catch {
               return nil
           }
       }
}
