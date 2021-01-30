//
//  MainTableViewController.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/30/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    let viewModel = MailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Forecast"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        tableView.registerFromNib(forCellClass: ForecastDetailTableViewCell.self)
        
//        viewModel.loadData(city: )
        
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
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberItems()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: ForecastDetailTableViewCell.self, for: indexPath)
        if let value = viewModel.data(at: indexPath.row) {
            cell.configure(data: value)
        }
        return cell
    }
}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension MainTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            viewModel.loadData(city: searchText)
        }
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
}
