//
//  ImageCache.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 01/02/24.
//

import UIKit
/// To maintain cache of images
final class ImageCache {
    static let shared = ImageCache()
    /// maximum count for images to store in cache
    private let maxItemsCount = 200
    private init() {
        // Private initializer to ensure singleton
    }
    
    private var cache = NSCache<NSString, UIImage>()
    /// to maintain access order for images to purge less accessed images when cache reaches threshold
    private var accessOrder: [NSString] = []
    
    /// get image from cache by key
    func getImage(for key: String) -> UIImage? {
        if let image = cache.object(forKey: key as NSString) {
            updateAccessOrder(key as NSString)
            return image
        }
        return nil
    }
    
    /// set image in cache against key
    func setImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
        updateAccessOrder(key as NSString)
        removeExcessItems()
    }
    
    /// to update access order for images
    private func updateAccessOrder(_ key: NSString) {
        if let index = accessOrder.firstIndex(of: key) {
           accessOrder.remove(at: index)
        }
        accessOrder.append(key)
    }
    /// remove excess images when cache reaches defined threshold 
    private func removeExcessItems() {
        let itemsToRemove = max(0, cache.totalCostLimit - maxItemsCount)
        for _ in 0..<itemsToRemove {
            if let key = accessOrder.first {
               cache.removeObject(forKey: key)
               accessOrder.removeFirst()
            }
        }
    }
    /// to clear  cache 
    func clearCache() {
        cache.removeAllObjects()
    }
}
