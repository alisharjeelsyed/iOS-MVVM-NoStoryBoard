//
//  MovieListResponse.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

struct MovieListResponse: Codable {

    var items: [Item]
}

struct Item: Codable {

    let id :String
    let rank: String?
    let title: String?
    let fullTitle: String?
    let year: String?
    let image: String?
    let crew: String?
    let imdbRating: String?
    let imdbbRatingCount: String?
    
    enum CodingKeys:String,CodingKey {
        case id, rank, title, fullTitle, year, image, crew
        case imdbRating = "imDbRating"
        case imdbbRatingCount = "imDbRatingCount"
    }
}
