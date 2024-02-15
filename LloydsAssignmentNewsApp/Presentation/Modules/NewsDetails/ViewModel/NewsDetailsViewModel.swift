//
//  NewsDetailsViewModel.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit
import PromiseKit

final class NewsDetailsViewModel: ObservableObject, NewsDetailsViewModelProtocol {
    private var newsArticle: ArticleDomainModel
    @Published var downloadedImage: UIImage?
    private let imageUseCase: ImageUseCaseProtocol
    
    init(newsArticle: ArticleDomainModel, imageUseCase: ImageUseCaseProtocol = UseCaseFactory.createImageUseCase()) {
        self.newsArticle = newsArticle
        self.imageUseCase = imageUseCase
        loadImage()
    }
    
    func loadImage() {
        guard let url = newsArticle.imageUrl else {
            return
        }
        
        imageUseCase.loadImage(from: url)
        .done {[weak self] image in
            self?.downloadedImage = image
        }
        .catch { error in
            debugPrint(error)
        }
    }
    
    func newsImageUrl() -> URL? {
        return newsArticle.imageUrl
    }
    
    func newsTitle() -> String {
        return newsArticle.title
    }
    
    func newsPublishedAt() -> String? {
        return newsArticle.updatedAt
    }
    
    func newsAuthorAndSource() -> String {
        return newsArticle.newsSource
    }
    
    func newsDescription() -> String? {
        return newsArticle.description
    }
    
    func newsUrl() -> URL? {
        if let url = URL(string: newsArticle.url) {
            return url
        }
        return nil
    }
}
