//
//  CheckoutTableViewCell.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-23.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {

    static let identifier = "CheckoutTableViewCell"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!

    func configure(for item: Item, quantity: Int) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = "$\(Double(quantity) * item.price)"
        quantityLabel.text = "\(quantity)"
    }
    
}
