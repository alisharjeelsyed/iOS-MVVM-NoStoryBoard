//
//  AppConstants.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 25/08/2021.
//

import Foundation

public struct APIConstants {

    static var baseURL: String {
        return "https://imdb-api.com/en/API/"
    }

    static var topMoviesURL: String {
        return baseURL + "Top250Movies/" + AppConstants.imdbAPIkey
    }

}

public struct AppConstants {
    static let imdbAPIkey   = "k_o28u685t"
}
