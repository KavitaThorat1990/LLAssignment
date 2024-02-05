//
//  ImagesRepositoryProtocol.swift
//  LloydsAssignmentNewsApp
//
//  Created by Kavita Thorat on 02/02/24.
//

import UIKit
import PromiseKit

protocol ImagesRepositoryProtocol {
    func loadImage(from url: URL) -> Promise<UIImage>
}
