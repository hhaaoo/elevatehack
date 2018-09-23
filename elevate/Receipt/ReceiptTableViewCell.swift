//
//  ReceiptTableViewCell.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-22.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit

protocol ReceiptTableViewCellDelegate: class {
    func didDelete()
    func didUpdate()
}

class ReceiptTableViewCell: UITableViewCell {

    static let identifier = "ReceiptTableViewCell"

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var deleteButton: UIButton!

    private var item: Item!
    weak var delegate: ReceiptTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        quantityTextField.delegate = self
        deleteButton.layer.cornerRadius = 5.0
        productImageView.layer.cornerRadius = 5.0
        productImageView.contentMode = .scaleAspectFit
        productImageView.layer.shadowColor = UIColor.black.cgColor
        productImageView.layer.shadowRadius = 5.0
        productImageView.layer.masksToBounds = false
        productImageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        productImageView.layer.shadowOpacity = 0.5
    }

    func configure(for item: Item, quantity: Int) {
        self.item = item
        productImageView.image = UIImage.init(named: item.imageName)
        productImageView.contentMode = .scaleAspectFit
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        updateTotalPrice(Double(quantity))
        quantityTextField.text = "\(quantity)"
    }

    @IBAction func deletePressed() {
        OrdersManager.shared.remove(shop: item.shop, item: item)
        delegate?.didDelete()
    }

    func updateTotalPrice(_ quantity: Double?) {
        if let quantity = quantity {
            priceLabel.text = "$\(item.price * quantity)"
            OrdersManager.shared.update(item: item, quantity: Int(quantity))
        } else {
            priceLabel.text = "N/A"
        }
    }
}

extension ReceiptTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate: NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        updateTotalPrice(Double(String(txtAfterUpdate)))
        delegate?.didUpdate()
        return true
    }
}
