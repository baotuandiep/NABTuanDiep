//
//  SettingPickerTableViewCell.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import UIKit

class SettingPickerTableViewCell: UITableViewCell {
    
    var didChangeIndex: ((Int) -> Void)?

    @IBOutlet private weak var pickerView: UIPickerView!
    private var viewModel = SettingPickerViewModel(values: [])

    func configure(values: [String], selectedIndex: Int) {
        viewModel.update(values: values, selectedIndex: selectedIndex)
        pickerView.reloadAllComponents()
    }
}

extension SettingPickerTableViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.values.count
    }
}

extension SettingPickerTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.setIndex(selectedIndex: row)
        didChangeIndex?(row)
    }
}
