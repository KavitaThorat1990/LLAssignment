//
//  ImageDataMapperProtocol.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit

/// Protocol defining a mapper responsible for mapping `Data` to `UIImage`.
protocol ImageDataMapperProtocol {
    /// Maps API response to domain model
    /// - Parameter imageData: The `Data` object to be mapped.
    /// - Returns: `UIImage` 
    func mapDataToImage(imageData: Data) -> UIImage?
}
