//
//  ForecastDetailTableViewCell.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/30/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import UIKit

class ForecastDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var averageTempLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(data: ForecastData, unit: String) {
        dateLabel.text = data.dateString
        averageTempLabel.text = data.averageTempString + unit
        pressureLabel.text = data.pressureString
        humidityLabel.text = data.humidityString
        descriptionLabel.text = data.description
    }
    
}
