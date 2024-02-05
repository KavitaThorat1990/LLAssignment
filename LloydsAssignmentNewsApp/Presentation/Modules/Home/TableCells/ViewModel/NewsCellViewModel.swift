//
//  NewsCellViewModel.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit
import PromiseKit

final class NewsCellViewModel: ObservableObject {
    private let news: ArticleDomainModel
    @Published var downloadedImage: UIImage = UIImage(systemName: Constants.ImageNames.placeholder) ?? UIImage()
    private let imageUseCase: ImageUseCaseProtocol
    private let loadThumbnail: Bool
    
    init(news: ArticleDomainModel, imageUseCase: ImageUseCaseProtocol = UseCaseFactory.createImageUseCase(), loadThumbnail: Bool = true) {
        self.news = news
        self.imageUseCase = imageUseCase
        self.loadThumbnail = loadThumbnail
        loadImage()
    }

    private func loadImage() {
        var imageUrl: URL?
        if loadThumbnail {
            imageUrl = news.thumbnailUrl
        } else {
            imageUrl = news.imageUrl
        }
        guard let url = imageUrl else {
            return
        }
        
        imageUseCase.loadImage(from: url)
        .done {[weak self] image in
            self?.downloadedImage = image
        }
        .catch { error in
            print(error)
        }
    }
    
    func getNews() -> ArticleDomainModel {
        return news
    }
    
    func newsTitle() -> String {
        return news.title
    }
    
    func newsAuthorAndSource() -> String {
        return news.newsSource
    }
    
}
