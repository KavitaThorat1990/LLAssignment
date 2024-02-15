//
//  UseCaseFactory.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation

///Factory pattern to create use cases objects
struct UseCaseFactory {
    /// To create HomeNewsUseCaseProtocol
    /// - Parameter isMock: To decide if we need to use mock API service or remote api service
    /// - Returns: HomeNewsUseCaseProtocol
    static func createHomeNewsUseCase(isMock: Bool = false) -> HomeNewsUseCaseProtocol {
        let apiService: APIServiceProtocol = isMock ? MockAPIService(dataProvider: LocalDataProvider()) : RemoteAPIService()
        let mapper: NewsResponseDataMapperProtocol = NewsResponseDataMapper()
        let repository: NewsListRepositoryProtocol = NewsListRepository(apiService: apiService, mapper: mapper)
        return HomeNewsUseCase(repository: repository)
    }
    /// To create ImageUseCase
    ///  - Parameter isMock: To decide if we need to use mock API service or remote api service
    ///  - Returns: ImageUseCase
    static func createImageUseCase(isMock: Bool = false) -> ImageUseCaseProtocol {
        let apiService: APIServiceProtocol = isMock ? MockAPIService(dataProvider: LocalDataProvider()) : RemoteAPIService()
        let mapper: ImageDataMapperProtocol = ImageDataMapper()
        let imageCache = ImageCache.shared
        let repository: ImagesRepositoryProtocol = ImagesRepository(apiService: apiService, mapper: mapper, imageCache: imageCache)
        return ImageUseCase(repository: repository)
    }
}
