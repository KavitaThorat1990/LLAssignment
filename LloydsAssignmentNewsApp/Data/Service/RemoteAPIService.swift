//
//  RemoteAPIService.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation
import PromiseKit

/// Responsible for fetching remote data using URLSession 
class RemoteAPIService: APIServiceProtocol {
  /// to fetch data from remote API
    func fetchData<T: Codable>(from endpoint: String) -> Promise<T> {
        return fetchDataWithParameters(from: endpoint, parameters: [:])
    }
    /// to fetch data from remote API
    func fetchDataWithParameters<T: Codable>(from endpoint: String, parameters: [String: Any]) -> Promise<T> {
        return Promise { seal in
            var urlString = AppConfiguration.baseURL + endpoint
            
            var paramWithAPIKey = parameters
            paramWithAPIKey[APIConstants.RequestParameters.apiKey] = AppConfiguration.apiKey

            if !paramWithAPIKey.isEmpty {
                urlString += "?" + paramWithAPIKey.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            }

            guard let url = URL(string: urlString) else {
                seal.reject(APIError.invalidURL)
                return
            }

            let request = URLRequest(url: url)

            SecureURLSession.shared.urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    seal.reject(APIError.requestFailed(error))
                    return
                }

                guard let data = data else {
                    seal.reject(APIError.invalidResponse)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Convert snake_case to camelCase

                    #if DEBUG
                    let backToString = String(data: data, encoding: String.Encoding.utf8)
                    print(backToString ?? "")
                    #endif
                    let result = try decoder.decode(T.self, from: data)
                    seal.fulfill(result)
                } catch {
                    print(error)
                    // Return APIError for decoding errors
                    do {
                        let decoder = JSONDecoder()
                        let apiError = try decoder.decode(APIErrorResponse.self, from: data)
                        seal.reject(APIError.apiFailed(apiError))
                    } catch {
                        seal.reject(APIError.decodingFailed(error))
                    }
                }
            }.resume()
        }
    }
    
    /// to download image from url
    func downloadImage(from url: URL) -> Promise<Data> {
        return Promise { seal in
            
            let task = SecureURLSession.shared.urlSession.dataTask(with: url) { data, _, error in
                if let error = error {
                    seal.reject(error)
                    return
                }

                guard let imageData = data else {
                    seal.reject(APIError.invalidResponse)
                    return
                }

                seal.fulfill(imageData)
            }

            task.resume()
        }
    }
}
