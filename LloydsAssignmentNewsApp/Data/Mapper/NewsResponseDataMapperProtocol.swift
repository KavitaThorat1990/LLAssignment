//
//  NewsResponseDataMapperProtocol.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 02/02/24.
//

import Foundation

/// Protocol defining a mapper responsible for mapping `NewsResponse` to `NewsDomainModel`.
protocol NewsResponseDataMapperProtocol {
    /// Maps API response to domain model
    /// - Parameter response: The `NewsResponse` object to be mapped.
    /// - Returns: A `NewsDomainModel` object containing mapped domain data.
    func mapToNewsDomainModel(response: NewsResponse) -> NewsDomainModel
}
