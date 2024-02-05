//
//  NewsCell.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import SwiftUI

struct NewsCell: View {
    @ObservedObject var cellViewModel: NewsCellViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            // Image View
            Image(uiImage: cellViewModel.downloadedImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 5) {
                Text(cellViewModel.newsTitle())
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(3)
                Text(cellViewModel.newsAuthorAndSource())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
        }
        .padding(0)
    }
}

#Preview {
    NewsCell(cellViewModel: NewsCellViewModel(news: ArticleDomainModel(id: nil, source: "The Washington Post", title: "13-year-old becomes first known person to ‘beat’ Tetris - The Washington Post", description: "Willis Gibson, 13, became the first person known to have beat “Tetris” by getting so far into the game he made it freeze.", url: "https://www.washingtonpost.com/nation/2024/01/04/13-year-old-beats-tetris/", urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440", urlToThumbnail: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440",  publishedAt: "2024-01-05T05:44:15Z")))
}
