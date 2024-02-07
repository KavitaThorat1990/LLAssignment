//
//  FeaturedNewsItemCell.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import SwiftUI

struct FeaturedNewsItemCell: View {
    @ObservedObject var cellViewModel: NewsCellViewModel
    @State private var titleHeight: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Image(uiImage: cellViewModel.downloadedImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 200)
                .cornerRadius(8)
            
            NewsTitleView(title: cellViewModel.newsTitle())
                .background(
                    GeometryReader { geometry in
                        Color.clear.onAppear {
                            titleHeight = geometry.size.height
                        }
                    }
                )
                .offset(y: -titleHeight)
                .padding(.bottom, -80)
                .padding(.horizontal, 5)
        }
    }
}

#Preview {
    FeaturedNewsItemCell(cellViewModel:  NewsCellViewModel(news: ArticleDomainModel(id: nil, source: "The Washington Post", title: "13-year-old becomes first known person to ‘beat’ Tetris - The Washington Post", description: "Willis Gibson, 13, became the first person known to have beat “Tetris” by getting so far into the game he made it freeze.", url: "https://www.washingtonpost.com/nation/2024/01/04/13-year-old-beats-tetris/", urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440", urlToThumbnail: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440", publishedAt: "2024-01-05T05:44:15Z")))
}
