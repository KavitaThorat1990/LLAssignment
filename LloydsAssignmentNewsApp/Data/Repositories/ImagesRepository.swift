//
//  ImagesRepository.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 02/02/24.
//

import UIKit
import PromiseKit

class ImagesRepository: ImagesRepositoryProtocol {
    /// The service responsible for providing data fetching functionalities.
    private let apiService: APIServiceProtocol
    /// An object conforming to `ImageDataMapperProtocol` responsible for mapping data
    private let mapper: ImageDataMapperProtocol
    
    init(apiService: APIServiceProtocol, mapper: ImageDataMapperProtocol) {
        self.apiService = apiService
        self.mapper = mapper
    }
    
    /// Responsible for fetching features news from api and mapping it to domain data
    ///  - Parameter url: Image url
    ///  - Returns:  Promise<UIImage> Downloaded  image
    func loadImage(from url: URL) -> Promise<UIImage> {
        return Promise { seal in
            // Check if the image is available in the cache
            if let cachedImage = ImageCache.shared.getImage(for: url.absoluteString) {
                seal.fulfill(cachedImage)
                return
            }

            apiService.downloadImage(from: url)
                .done { [weak self] imageData in
                    guard let image = self?.mapper.mapDataToImage(imageData: imageData) else {
                        seal.reject(APIError.invalidResponse)
                        return
                    }
                    // Cache the downloaded image
                    ImageCache.shared.setImage(image, for: url.absoluteString)
                    seal.fulfill(image)
                }
                .catch { error in
                    seal.reject(error)
                }
        }
    }
}
