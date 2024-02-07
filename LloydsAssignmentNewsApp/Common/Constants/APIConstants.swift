//
//  APIConstants.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation

struct APIConstants {
    
    struct EndPoints {
        static let mostPopular = "/mostpopular/v2/viewed/7.json"
        static let topStories = "/topstories/v2/"
    }
    
    struct LocalJson {
        static let popular = "PopularNews"
        static let topStories = "TopStories"
    }
    
    struct RequestParameters {
        static let apiKey = "api-key"
    }
}

