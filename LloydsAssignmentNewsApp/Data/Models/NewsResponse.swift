//
//  NewsResponse.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation

// Define an enum for MediaFormat
enum MediaFormat: String, Codable {
    case standardThumbnail = "Standard Thumbnail"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case threeByTwoSmallAt2X = "threeByTwoSmallAt2X"
    case superJumbo = "Super Jumbo"
    case largeThumbnail = "Large Thumbnail"
}
/// MediaMetadata model
struct MediaMetadata: Codable {
    let url: String
    let format: MediaFormat
    let caption: String?
}

/// Media model
struct Media: Codable {
    let type: String
    let caption: String
    let mediaMetadata: [MediaMetadata] 
    
    private enum CodingKeys: String, CodingKey {
        case type
        case caption
        case mediaMetadata = "media-metadata"
    }

    // Computed property to map the desired url string
    var imageUrl: String? {
        if type == "image" {
            if let mediaMetadata = mediaMetadata.first(where: { $0.format == .mediumThreeByTwo210 }) {
                return mediaMetadata.url
            }
        }
        return nil
    }
    
    // Computed property to map the desired url string
    var thumbnailUrl: String? {
        if type == "image" {
            if let mediaMetadata = mediaMetadata.first(where: { $0.format == .largeThumbnail ||  $0.format == .standardThumbnail}) {
                return mediaMetadata.url
            }
        }
        return nil
    }
}

/// Articles model
struct Articles: Codable {
    let url: String
    let id: Int?
    let source: String?
    let publishedDate: String
    let section: String
    let title: String
    let abstract: String
    let media: [Media]?
    let multiMedia: [MediaMetadata]?

    // CodingKeys to handle small to camel case
    private enum CodingKeys: String, CodingKey {
        case url
        case id
        case source
        case publishedDate
        case section
        case title
        case abstract
        case media
        case multiMedia = "multimedia"
    }
    
    // Computed property to map the desired url string
    var imageUrl: String? {
        if let metadata = media?.first(where: { $0.imageUrl != nil }) {
            return metadata.imageUrl
        } else if let metadata = multiMedia?.first {
            return metadata.url
        }
        return nil
    }
    
    // Computed property to map the desired url string
    var thumbnailUrl: String? {
        if let metadata = media?.first(where: { $0.thumbnailUrl != nil }) {
            return metadata.thumbnailUrl
        } else if let mediaMetadata = multiMedia?.first(where: { $0.format == .largeThumbnail ||  $0.format == .standardThumbnail}) {
            return mediaMetadata.url
        }
        return nil
    }
}


/// NewsResponse model
struct NewsResponse: Codable {
    let status: String
    let numResults: Int
    let results: [Articles]
}
