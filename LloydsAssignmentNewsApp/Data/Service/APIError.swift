//
//  APIError.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import Foundation
/// To handle all APi related errors
enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case invalidResource
    case apiFailed(APIErrorResponse)
}

/// APIErrorResponse
struct APIErrorResponse: Codable {
    let status: String
    let message: String
    let code: String
}

