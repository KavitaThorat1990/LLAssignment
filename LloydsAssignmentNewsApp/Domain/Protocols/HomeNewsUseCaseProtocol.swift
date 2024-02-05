//
//  HomeNewsUseCaseProtocol.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import PromiseKit

protocol HomeNewsUseCaseProtocol {
    func fetchFeaturedNews(parameters: [String: Any]?) -> Promise<[ArticleDomainModel]>
    func fetchTrendingNews(for category: String) -> Promise<[ArticleDomainModel]>
}
