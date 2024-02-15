//
//  HomeViewModelProtocol.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 15/02/24.
//

import Foundation
import PromiseKit

protocol HomeViewModelProtocol {
    func fetchTrendingNewsForCategories() -> Promise<[String: [ArticleDomainModel]]>
    func fetchFeaturedNews(parameters: [String: Any]?) -> Promise<Void>
    func numberOfRowsForSection(section: Int) -> Int
    func getNewsForSection(section: Int) -> [ArticleDomainModel]
    func getFeaturedNews() -> [ArticleDomainModel]
    func numberOfSections() -> Int
    func getHeaderTitle(for section: Int) -> String
    func heightForHeaderInSection(_ section: Int) -> CGFloat
}
