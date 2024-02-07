//
//  HomeViewController.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import UIKit
import PromiseKit
import SwiftUI

final class HomeViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.accessibilityIdentifier = Constants.AccessibilityIds.newsListTable
        return tableView
    }()

    var viewModel: HomeViewModel?
    private var featuredNewsCell: FeaturedNewsCell?
    weak var coordinator: NewsAppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        featuredNewsCell?.startAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        featuredNewsCell?.stopAutoScroll()
    }
    
    private func setupUI() {
        navigationItem.title = Constants.ScreenTitles.home
        
        // Set up the table view
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        // Configure cell registration for collection views and table views
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIds.newsCell)
        tableView.register(FeaturedNewsCell.self, forCellReuseIdentifier: Constants.CellIds.featuredNewsCell)

        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: Constants.CellIds.newsCategoryHeader)
        featuredNewsCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.featuredNewsCell) as? FeaturedNewsCell
        featuredNewsCell?.didSelectNews = {[weak self] news in
            self?.coordinator?.navigateToNewsDetails(news)
        }
    }

    private func loadData() {
        // Fetch data using promises
        guard let fetchFeatured = viewModel?.fetchFeaturedNews(parameters: [:]),  let fetchTrending = viewModel?.fetchTrendingNewsForCategories() else {
            return
        }
        showActivityIndicator()

        when(fulfilled: fetchFeatured, fetchTrending)
            .ensure { [weak self] in
                self?.hideActivityIndicator()
            }
            .done { [weak self] (_, _) in
                self?.updateUI()
            }
            .catch {[weak self]  error in
                self?.handleAPIError(error)
            }
    }
    
    private func updateUI() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel?.numberOfRowsForSection(section: section) ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let payload = [Constants.PayloadKeys.newsList: viewModel?.getFeaturedNews() ?? []]
            featuredNewsCell?.configure(with: payload)
            return featuredNewsCell ?? UITableViewCell()
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.newsCell), let news = viewModel?.getNewsForSection(section: indexPath.section)[indexPath.row] else {
                return UITableViewCell()
            }
            
            let newsCell = NewsCell(cellViewModel: NewsCellViewModel(news: news))
            if #available(iOS 16.0, *) {
                cell.contentConfiguration = UIHostingConfiguration(content: {
                    newsCell
                })
               } else {
                   cell.contentConfiguration = HostingContentConfiguration {
                       newsCell
                   }
               }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return Constants.CellHeights.featuredCell
        } else {
            return Constants.CellHeights.newsCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       if section != 0 {
           guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.CellIds.newsCategoryHeader), let category = viewModel?.getHeaderTitle(for: section) else {
               return nil
           }
           
           let newsHeader = NewsCategoryHeader(title: category)
           
           if #available(iOS 16.0, *) {
               headerView.contentConfiguration = UIHostingConfiguration(content: {
                   newsHeader
               })
           } else {
               headerView.contentConfiguration = HostingContentConfiguration {
                   newsHeader
               }
           }
           return headerView
       }
       return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel?.heightForHeaderInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let news = viewModel?.getNewsForSection(section: indexPath.section)[indexPath.row] {
            coordinator?.navigateToNewsDetails(news)
        }
    }
    
    private func navigateToNewsDetails(_ news: ArticleDomainModel) {
        let newsDetailsViewController = NewsDetailsViewController()
        newsDetailsViewController.viewModel = NewsDetailsViewModel(newsArticle: news)
        self.navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
}
