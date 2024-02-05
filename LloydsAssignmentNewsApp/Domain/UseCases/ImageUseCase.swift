//
//  ImageUseCase.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 01/02/24.
//

import UIKit
import PromiseKit

class ImageUseCase: ImageUseCaseProtocol {
    private let repository: ImagesRepositoryProtocol
    
    init(repository: ImagesRepositoryProtocol) {
        self.repository = repository
    }
    
    /// Responsible for fetching images from repository
    ///  - Parameter url: Image url
    ///  - Returns Promise<UIImage>
    func loadImage(from url: URL) -> Promise<UIImage> {
            return Promise { seal in
                // Check if the image is available in the cache
                if let cachedImage = ImageCache.shared.getImage(for: url.absoluteString) {
                    seal.fulfill(cachedImage)
                    return
                }
                    
                self.repository.loadImage(from: url)
                    .done { image in
                        seal.fulfill(image)
                    }
                    .catch { error in
                        seal.reject(error)
                    }
            }
        }
}
