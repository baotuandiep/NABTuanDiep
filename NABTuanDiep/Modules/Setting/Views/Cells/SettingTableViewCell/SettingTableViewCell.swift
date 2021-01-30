//
//  SettingTableViewCell.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var settingTitleLabel: UILabel!
    
    func configure(title: String, value: String) {
        valueLabel.text = value
        settingTitleLabel.text = title
    }
}
