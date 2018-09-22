//
//  SearchTableViewCell.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-22.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!

    func configure(for item: Item) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        var mutableString: NSMutableAttributedString = NSMutableAttributedString(attributedString:
            NSAttributedString(string: "Price: "))
        mutableString.append(NSAttributedString(string: "\(item.price)",
            attributes: [NSAttributedStringKey.foregroundColor: UIColor.blue,
                         NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: priceLabel.font.pointSize)]))
        priceLabel.attributedText = mutableString

        mutableString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Distance: "))
        mutableString.append(NSAttributedString(string: "\(item.shop.distance)",
            attributes: [NSAttributedStringKey.foregroundColor: UIColor.blue,
                         NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: priceLabel.font.pointSize)]))
        distanceLabel.attributedText = mutableString
    }
    
}
