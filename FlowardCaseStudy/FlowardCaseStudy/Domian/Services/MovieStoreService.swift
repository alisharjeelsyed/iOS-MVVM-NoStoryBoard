//
//  HomeStoreService.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

typealias MovieStoreResponseAlias = (NetworkResult<BaseResponseEntity<MovieListResponse>>) -> Void

//MARK: - Home Service  Protocol
protocol MovieStroeService {

    func getProductList(completion: @escaping (MovieStoreResponseAlias) )
}


struct MovieStroeServiceImpl: MovieStroeService {

    //MARK: - Properties
    let jsonTranslator: JsonTranslatable = JsonTranslator()
    let networkManager: NetworkManager

    //MARK: - Init
    init(networkManager: NetworkManager = AppNetworkManager()) {

        self.networkManager = networkManager
    }

    //MARK: - Method
    func getProductList(completion: @escaping (MovieStoreResponseAlias)) {


        let endPoint = RequestConvertible(method: .get,
                                          route: APIConstants.topMoviesURL,
                                                headers: [:] ,
                                                body: nil)
        

        networkManager.reqeustJSONApi(endPoint: endPoint, completion: { (result) in
            let mappedResponse: NetworkResult<BaseResponseEntity<MovieListResponse>> = self.jsonTranslator.convertDataResponseModel(with: result)

            DispatchQueue.main.async {
                completion(mappedResponse)
            }
        })
    }
}
