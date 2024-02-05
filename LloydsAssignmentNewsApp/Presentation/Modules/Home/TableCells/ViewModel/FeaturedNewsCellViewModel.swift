//
//  FeaturedNewsCellModel.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation

final class FeaturedNewsCellViewModel {
    private var newsArticles: [ArticleDomainModel] = []
    
    init(newsArticles: [ArticleDomainModel] = []) {
        self.newsArticles = newsArticles
    }

    func configure(payload: [String: Any]) {
        if let newsArticle = payload[Constants.PayloadKeys.newsList] as? [ArticleDomainModel]{
            self.newsArticles = newsArticle
        }
    }
    
    func getNumberOfRows() -> Int {
        return newsArticles.count
    }
    
    func getNewsForRow(index: Int) -> ArticleDomainModel? {
        guard index < newsArticles.count else {
            return nil
        }
        return newsArticles[index]
    }
}
