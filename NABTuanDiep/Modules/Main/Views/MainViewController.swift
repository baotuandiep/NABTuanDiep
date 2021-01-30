//
//  MainViewController.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/30/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    let viewModel = MailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Forecast"
        
        tableView.registerFromNib(forCellClass: ForecastDetailTableViewCell.self)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        

        listen()
    }
    
    func listen() {
        viewModel.error.bind { [weak self] in
            self?.handleError(error: $0)
        }
        
        viewModel.model.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    func handleError(error: ErrorType?) {
        guard let error = error else { return }
        
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: ForecastDetailTableViewCell.self, for: indexPath)
        if let value = viewModel.data(at: indexPath.row) {
            cell.configure(data: value)
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            viewModel.loadData(city: searchText)
        }
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
}
