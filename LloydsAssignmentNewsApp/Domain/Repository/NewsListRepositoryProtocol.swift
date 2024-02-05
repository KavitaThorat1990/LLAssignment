//
//  NewsListRepositoryProtocol.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 02/02/24.
//

import Foundation
import PromiseKit

protocol NewsListRepositoryProtocol {
    func fetchFeaturedNews(parameters: [String: Any]?) -> Promise<[ArticleDomainModel]>
    func fetchTrendingNews(for category: String) -> Promise<[ArticleDomainModel]>
}
