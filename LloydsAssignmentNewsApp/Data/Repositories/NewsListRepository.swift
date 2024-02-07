//
//  NewsListRepository.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 02/02/24.
//

import Foundation
import PromiseKit

final class NewsListRepository: NewsListRepositoryProtocol {
    /// The service responsible for providing data fetching functionalities.
    private let apiService: APIServiceProtocol
    /// An object conforming to `NewsResponseDataMapperProtocol` responsible for mapping data
    private let mapper: NewsResponseDataMapperProtocol
    
    /// - Parameter service: An object conforming to `APIServiceProtocol` , providing data fetching functionalities.
    /// - Parameter mapper:  to Map data to DomainData
    init(apiService: APIServiceProtocol, mapper: NewsResponseDataMapperProtocol) {
        self.apiService = apiService
        self.mapper = mapper
    }
    /// Responsible for fetching featured news from api and mapping it to domain data
    ///  - Parameter Parameters: Request parameters
    ///  - Returns:  Promise<[ArticleDomainModel]> Fetched and mapped response
    func fetchFeaturedNews(parameters: [String: Any]?) -> Promise<[ArticleDomainModel]> {
        let promise: Promise<NewsResponse> = {
            apiService.fetchDataWithParameters(from: APIConstants.EndPoints.mostPopular, parameters: parameters ?? [:])
        }()
        
        return firstly {
            promise
        }.map {[mapper] response in
            return mapper.mapToNewsDomainModel(response: response).newsList
        }

    }
    
    /// Responsible for fetching trending news for categories from api and mapping it to domain data
    ///  - Parameter category: News Category
    ///  - Returns:  Promise<[ArticleDomainModel]> Fetched and mapped response
    func fetchTrendingNews(for category: String) -> Promise<[ArticleDomainModel]> {
        let promise: Promise<NewsResponse> = {
            apiService.fetchData(from: APIConstants.EndPoints.topStories.appending("\(category).json"))
        }()
        
        return firstly {
            promise
        }.map {[mapper] response in
            return mapper.mapToNewsDomainModel(response: response).newsList
        }
    }
}
