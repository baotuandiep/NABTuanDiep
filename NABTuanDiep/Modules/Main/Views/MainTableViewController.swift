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
        
        APIManager.shared.loadData(type: ForecastModel.self,
                                   path: "/data/2.5/forecast/daily",
                                   queryParams: [
            "q": "saigon",
            "cnt": 10,
            "appid": "60c6fbeb4b93ac653c492ba806fc346d",
            "units": "imperial"
        ]) {
            switch $0 {
            case .success(let model):
                print(model)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: ForecastDetailTableViewCell.self, for: indexPath)
        return cell
    }
}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension MainTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
}
