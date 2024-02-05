//
//  HomeViewModel.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation
import PromiseKit

final class HomeViewModel {
    /// contains featured news displayed at top section in home screen
    private var featuredNews: [ArticleDomainModel] = []
    private var categories: [String] = Constants.defaultCategories
    /// dictionary to maintain news category wise
    private var categorisedNews: [String: [ArticleDomainModel]] = [:]

    private let homeNewsUseCase: HomeNewsUseCaseProtocol

    init(homeNewsUseCase: HomeNewsUseCaseProtocol = UseCaseFactory.createHomeNewsUseCase()) {
        self.homeNewsUseCase = homeNewsUseCase
    }
    
    // Fetch trending news for each category and collect responses in a dictionary
    func fetchTrendingNewsForCategories() -> Promise<[String: [ArticleDomainModel]]> {
        let promises = categories.map { category in
            return homeNewsUseCase.fetchTrendingNews(for: category)
                .map { articles in
                    return (category, articles)
                }
        }

        return when(fulfilled: promises)
            .map {[weak self] categoryNewsArray in
                var categoryNewsDict: [String: [ArticleDomainModel]] = [:]
                for (category, news) in categoryNewsArray {
                    categoryNewsDict[category] = news
                }
                self?.categorisedNews = categoryNewsDict
                return categoryNewsDict
            }
    }
    /// fetch featured news
    func fetchFeaturedNews(parameters: [String: Any]?) -> Promise<Void> {
        return firstly {
            homeNewsUseCase.fetchFeaturedNews(parameters: parameters)
        } .map { [weak self] articles in
            self?.featuredNews = articles
            return
        }
    }
    
    func numberOfRowsForSection(section: Int) -> Int {
        return getNewsForSection(section: section).count
    }
    
    func getNewsForSection(section: Int) -> [ArticleDomainModel] {
        guard section > 0, section - 1 < categories.count else {
            return []
        }
        let category = categories[section - 1]
        
        if let news = categorisedNews[category] {
            return news
        }
        return []
    }
    
    func getFeaturedNews() -> [ArticleDomainModel] {
        return featuredNews
    }
    
    func numberOfSections() -> Int {
        return categorisedNews.count + (featuredNews.isEmpty ? 0 : 1) //categories.count + 1
    }
    
    func getHeaderTitle(for section: Int) -> String {
        let index =  section - 1
        guard index >= 0, index < categories.count else {
            return ""
        }
        
        return categories[index]
    }
    
    func heightForHeaderInSection(_ section: Int) -> CGFloat {
        return section != 0 ?  Constants.CellHeights.categoryHeader : 0.0
    }
}
