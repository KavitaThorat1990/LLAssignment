//
//  NewsDetailsViewController.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit
import SwiftUI

final class NewsDetailsViewController: UIViewController {
    var viewModel: NewsDetailsViewModelProtocol?
    weak var Navigator: NewsAppNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUIView()
    }
    
    private func setupSwiftUIView() {
        
        guard let model = self.viewModel as? NewsDetailsViewModel else {
            return
        }
        let detailsView =  NewsDetailView(viewModel: model, openNewsURL: { [weak self] in
            if let url = model.newsUrl() {
                self?.Navigator?.openUrl(url)
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
