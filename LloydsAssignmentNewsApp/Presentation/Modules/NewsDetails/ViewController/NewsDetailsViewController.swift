//
//  NewsDetailsViewController.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit
import SwiftUI

class NewsDetailsViewController: UIViewController {
    var viewModel: NewsDetailsViewModel?
    weak var coordinator: NewsAppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUIView()
    }
    
    private func setupSwiftUIView() {
        
        guard let model = self.viewModel else {
            return
        }
        let detailsView =  NewsDetailView(viewModel: model, openNewsURL: { [weak self] in
            if let url = model.newsUrl() {
                self?.coordinator?.openUrl(url)
            }
        })
        
        let vc = UIHostingController(rootView: detailsView)

        guard let newsDetailsView = vc.view else {
            return
        }
        newsDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(vc)
        view.addSubview(newsDetailsView)
        
        NSLayoutConstraint.activate([
            newsDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            newsDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        vc.didMove(toParent: self)
    }
}