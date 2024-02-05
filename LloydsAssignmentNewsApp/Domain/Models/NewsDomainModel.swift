//
//  NewsDomainModel.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation

///  NewsDomainModel model
struct NewsDomainModel {
    let newsList: [ArticleDomainModel]

}
/// ArticleDomainModel model
struct ArticleDomainModel {
    let id: Int?
    let source: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let urlToThumbnail: String?
    let publishedAt: String
    
    // computed property
    var newsSource: String {
        guard let newsSource = source else {
            return "by " + "New York Times"
        }
        return "by " + newsSource
    }
    
    // computed property
    var updatedAt: String? {
        let dateFormats: [DateFormat] = [.iso8601, .customFormat(Constants.DateFormats.dateTimeFormat), .customFormat(Constants.DateFormats.dateFormat)]
        if let date = publishedAt.parseDateString(formats: dateFormats), let dateString = date.formattedDate(using: DateFormatterProvider(), formatString: Constants.DateFormats.newsDateFormat) {
            return "updated at " + dateString
        }
        return nil
    }
    
    // computed property
    var imageUrl: URL? {
        if let imageURL = urlToImage, let url = URL(string: imageURL) {
            return url
        }
        return nil
    }
    
    // computed property
    var thumbnailUrl: URL? {
        if let imageURL = urlToThumbnail, let url = URL(string: imageURL) {
            return url
        }
        return nil
    }
}
