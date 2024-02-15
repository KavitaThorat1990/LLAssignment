//
//  NewsDetailsViewModelProtocol.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 15/02/24.
//

import UIKit

protocol NewsDetailsViewModelProtocol {
    var downloadedImage: UIImage? { get }
    
    func loadImage()
    func newsImageUrl() -> URL?
    func newsTitle() -> String
    func newsPublishedAt() -> String?
    func newsAuthorAndSource() -> String
    func newsDescription() -> String?
    func newsUrl() -> URL?
}
