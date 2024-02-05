//
//  DataProvider.swift
//  LloydsAssignmentNewsAppTests
//
//  Created by Kavita Thorat on 04/02/24.
//

import Foundation

protocol DataProvider {
    func fetchData<T: Decodable>(from endpoint: String) throws -> T
    func loadImage(named imageName: String) throws -> Data
}

// Implement the LocalDataProvider

class LocalDataProvider: DataProvider {
    func fetchData<T: Decodable>(from endpoint: String) throws -> T {
        var jsonFile = ""
        switch endpoint {
        case APIConstants.EndPoints.mostPopular:
            jsonFile = "PopularNews"
        case let endpointString where endpointString.contains(APIConstants.EndPoints.topStories):
            jsonFile = "TopStories"
        default:
            throw DataProviderError.endPointNotHandled
        }
        
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json") else {
            throw DataProviderError.fileNotFound
        }

        let data = try Data(contentsOf: url)
        

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // Convert snake_case to camelCase
            #if DEBUG
            let backToString = String(data: data, encoding: String.Encoding.utf8)
            print(backToString ?? "")
            #endif
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw DataProviderError.decodingFailed(error)
        }
    }

    func loadImage(named imageName: String) throws -> Data {
        guard let imagePath = Bundle.main.path(forResource: imageName, ofType: "png") else {
            throw DataProviderError.fileNotFound
        }

        let imageData = try Data(contentsOf: URL(fileURLWithPath: imagePath))
        return imageData
    }
}

// Define DataProviderError

enum DataProviderError: Error {
    case fileNotFound
    case endPointNotHandled
    case decodingFailed(Error)
}
