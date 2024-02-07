//
//  Navigator.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit
/// To manage navigation within app 
protocol Navigator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start(with mockFlow: Bool)
    func navigateToNewsDetails(_ news: ArticleDomainModel)
    func openUrl(_ url: URL)
}

enum PresentationStyle {
    case push
    case present
}
