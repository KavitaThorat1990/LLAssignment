//
//  HomeNewsUseCase.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import PromiseKit

final class HomeNewsUseCase: HomeNewsUseCaseProtocol {
    /// repository to fetch data from api service
    private let repository: NewsListRepositoryProtocol
    init(repository: NewsListRepositoryProtocol) {
        self.repository = repository
    }

    /// Responsible for fetching featured news from repository
    ///  - Parameter Parameters: Request parameters
    ///  - Returns:  Promise<[ArticleDomainModel]> Mapped response
    func fetchFeaturedNews(parameters: [String: Any]?) -> Promise<[ArticleDomainModel]> {
        return repository.fetchFeaturedNews(parameters: parameters)
    }

    /// Responsible for fetching trending news for categories fromrepository
    ///  - Parameter category: News Category
    ///  - Returns:  Promise<[ArticleDomainModel]> Mapped response
    func fetchTrendingNews(for category: String) -> Promise<[ArticleDomainModel]> {
        return repository.fetchTrendingNews(for: category)
    }
}
