//
//  NewsResponseDataMapper.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation


class NewsResponseDataMapper: NewsResponseDataMapperProtocol {
    
    /// Maps API response to domain model
    /// - Parameter response: The `NewsResponse` object to be mapped.
    /// - Returns: A `NewsDomainModel` object containing mapped domain data.
    func mapToNewsDomainModel(response: NewsResponse) -> NewsDomainModel {
        let domainNewsList = NewsDomainModel(newsList: response.results.map { news in
            return ArticleDomainModel(id: news.id, source: news.source, title: news.title, description: news.abstract, url: news.url, urlToImage: news.imageUrl, urlToThumbnail: news.thumbnailUrl, publishedAt: news.publishedDate)
        })
        return domainNewsList
    }
}
