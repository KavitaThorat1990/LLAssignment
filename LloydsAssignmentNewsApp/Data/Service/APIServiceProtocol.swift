//
//  APIServiceProtocol.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation
import PromiseKit

protocol APIServiceProtocol {
    func fetchData<T: Codable>(from endpoint: String) -> Promise<T>
    func fetchDataWithParameters<T: Codable>(from endpoint: String, parameters: [String: Any]) -> Promise<T>
    func downloadImage(from url: URL) -> Promise<Data>
}
