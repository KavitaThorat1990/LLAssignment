//
//  NewsDetailsCell.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import SwiftUI

struct NewsDetailView: View {
   @ObservedObject var viewModel: NewsDetailsViewModel
    var openNewsURL: (()->())

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.newsTitle())
                    .font(.headline)
                    .lineLimit(nil)
                    .accessibilityIdentifier("title")
                
                Text(viewModel.newsAuthorAndSource())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                if let publishedAt = viewModel.newsPublishedAt() {
                    Text(publishedAt)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                if let image = viewModel.downloadedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                        .cornerRadius(8)
                        .padding(.vertical, 8)
                }

                if let description = viewModel.newsDescription() {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineLimit(nil)
                }
                
                HStack {
                    Spacer()
                    Button(Constants.ButtonTitles.seeMore) {
                        openNewsURL()
                    }.accessibilityIdentifier(Constants.AccessibilityIds.seeMoreButton)
                    .foregroundColor(.blue)
                    .padding(.top, 8)
                }
            }
        }
        .padding(.horizontal, 16)
        .background(Color.white)
        .padding(.top, 15)
    }
        
}

#Preview {
    NewsDetailView(viewModel: NewsDetailsViewModel(newsArticle: ArticleDomainModel(id: nil, source: "The Washington Post", title: "13-year-old becomes first known person to ‘beat’ Tetris - The Washington Post", description: "Willis Gibson, 13, became the first person known to have beat “Tetris” by getting so far into the game he made it freeze.", url: "https://www.washingtonpost.com/nation/2024/01/04/13-year-old-beats-tetris/", urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440", urlToThumbnail: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440",  publishedAt: "2024-01-05T05:44:15Z")), openNewsURL: {})
}
