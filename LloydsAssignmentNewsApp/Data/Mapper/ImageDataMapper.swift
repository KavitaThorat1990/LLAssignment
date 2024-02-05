//
//  ImageDataMapper.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit

class ImageDataMapper: ImageDataMapperProtocol {
    /// Maps API response to domain model
    /// - Parameter imageData: The `Data` object to be mapped.
    /// - Returns: `UIImage` 
    func mapDataToImage(imageData: Data) -> UIImage? {
        guard let image = UIImage(data: imageData) else {
            return nil
        }
        
        return image
    }
}
