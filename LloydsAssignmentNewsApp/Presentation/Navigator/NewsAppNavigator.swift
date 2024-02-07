//
//  NewsAppNavigator.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit

final class NewsAppNavigator: Navigator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(with mockFlow: Bool = false) {
        navigateToHome(with: mockFlow)
    }
    
    func navigateToHome(with mockFlow: Bool = false) {
        let homeViewController = HomeViewController()
        homeViewController.navigator = self
        homeViewController.viewModel = HomeViewModel(homeNewsUseCase: UseCaseFactory.createHomeNewsUseCase(isMock: mockFlow))
        navigateTo(presentationStyle: .push, toViewController: homeViewController)
    }

    func navigateTo(presentationStyle: PresentationStyle, toViewController: UIViewController) {
        switch presentationStyle {
        case .push:
            navigationController.pushViewController(toViewController, animated: true)
        case .present:
            navigationController.present(toViewController, animated: true, completion: nil)
        }
    }
    
    func navigateToNewsDetails(_ news: ArticleDomainModel) {
        let newsDetailsViewController = NewsDetailsViewController()
        newsDetailsViewController.Navigator = self
        newsDetailsViewController.viewModel = NewsDetailsViewModel(newsArticle: news, imageUseCase: UseCaseFactory.createImageUseCase())
        navigateTo(presentationStyle: .push, toViewController: newsDetailsViewController)
    }
    
    func openUrl(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
