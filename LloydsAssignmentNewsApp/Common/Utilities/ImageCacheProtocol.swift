//
//  ImageCacheProtocol.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 15/02/24.
//

import UIKit

protocol ImageCacheProtocol {
    func getImage(for key: String) -> UIImage?
    func setImage(_ image: UIImage, for key: String)
    func clearCache()
}
