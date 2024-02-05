//
//  Constants.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation

struct Constants {
    static let defaultCategories = ["Arts", "Science", "World"]
    static let timeInterval = 5.0
    
    struct CellHeights {
        static let featuredCell = 200.0
        static let newsCell = 120.0
        static let categoryHeader = 44.0
    }
    
    struct CellIds {
        static let newsCell = "NewsCell"
        static let featuredNewsItemCell = "FeaturedNewsItemCell"
        static let newsCategoryHeader = "NewsCategoryHeader"
        static let featuredNewsCell = "FeaturedNewsCell"
        static let newsDetailsCell = "NewsDetailsCell"        
    }
    
    struct ScreenTitles {
        static let home = "Home"
    }
    
    struct ButtonTitles {
        static let seeMore = "See More"
    }
    
    struct AccessibilityIds {
        static let newsListTable = "newsListTable"
        static let seeMoreButton = "SeeMore"

    }
    
    struct ImageNames {
        static let placeholder = "photo.fill"
    }
    
    struct PayloadKeys {
        static let category = "category"
        static let newsArticle = "newsArticle"
        static let newsList = "newsArticles"
    }
    
    struct DateFormats {
        static let newsDateFormat = "h.mm a z, EEEE, MMM d, yyyy"
        static let dateTimeFormat = "yyyy-MM-dd HH:mm:ss"
        static let dateFormat = "yyyy-MM-dd HH:mm:ss"
        static let iso8601DateFormat = "yyyy-MM-dd"
    }
}








