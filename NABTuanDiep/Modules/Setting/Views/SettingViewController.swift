//
//  SettingViewController.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import UIKit

enum SettingRow: String, CaseIterable {
    case tempUnit = "Tempurature"
    case cnt = "Number Of Forecast Days"
}

class SettingViewController: UIViewController {
    
    var viewModel = SettingViewModel()
    var updateSetting: (() -> Void)?

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        tableView.registerFromNib(forCellClass: SettingTableViewCell.self)
        tableView.registerFromNib(forCellClass: SettingPickerTableViewCell.self)
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        SettingRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.showSettingIndices.contains(section) ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(type: SettingTableViewCell.self, for: indexPath)
            cell.configure(title: SettingRow.allCases[indexPath.section].rawValue, value: viewModel.value(index: indexPath.section))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(type: SettingPickerTableViewCell.self, for: indexPath)
            cell.configure(values: viewModel.array(index: indexPath.section), selectedIndex: viewModel.selectedIndex(index: indexPath.section))
            cell.didChangeIndex = { [weak self] in
                self?.viewModel.updateIndex(index: indexPath.section, value: $0)
                self?.updateSetting?()
                tableView.reloadData()
            }
            return cell
        }
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 0 else { return }
        if viewModel.showSettingIndices.contains(indexPath.section) {
            viewModel.showSettingIndices.remove(indexPath.section)
            tableView.deleteRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .automatic)
        } else {
            viewModel.showSettingIndices.insert(indexPath.section)
            tableView.insertRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .automatic)
        }
    }
}
