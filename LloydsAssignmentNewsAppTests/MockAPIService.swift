//
//  MockAPIService.swift
//  LloydsAssignmentNewsAppTests
//
//  Created by Kavita Thorat on 04/02/24.
//

import Foundation
import PromiseKit

class MockAPIService: APIServiceProtocol {
    let dataProvider: DataProvider

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }

    func fetchData<T: Codable>(from endpoint: String) -> Promise<T> {
        return fetchDataWithParameters(from: endpoint, parameters: [:])
    }

    func fetchDataWithParameters<T: Codable>(from endpoint: String, parameters: [String: Any]) -> Promise<T> {
        return Promise { seal in
            do {
                let result: T = try dataProvider.fetchData(from: endpoint)
                seal.fulfill(result)
            } catch {
                seal.reject(error)
            }
        }
    }

    func downloadImage(from url: URL) -> Promise<Data> {
        return Promise { seal in
            do {
                let imageData: Data = try dataProvider.loadImage(named: "TestImage")
                seal.fulfill(imageData)
            } catch {
                seal.reject(error)
            }
        }
    }
}
