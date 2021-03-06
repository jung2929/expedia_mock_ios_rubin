//
//  LimitedDatePriceTableViewCell.swift
//  Expedia
//
//  Created by YooBin Jo on 02/04/2019.
//  Copyright © 2019 YooBin Jo. All rights reserved.
//

import UIKit

class LimitedDatePriceTableViewCell: UITableViewCell {

    @IBOutlet weak var limitedDatePriceButton: UIButton!
    @IBOutlet weak var limitedPriceIcon: UIImageView!
    
    func updateUI() {
        limitedDatePriceButton.layer.cornerRadius = 10
        limitedDatePriceButton.layer.masksToBounds = true
        limitedPriceIcon.layer.cornerRadius = limitedPriceIcon.frame.width / 2
    }
}
