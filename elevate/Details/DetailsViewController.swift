//
//  DetailsViewController.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-22.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var storeLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var addButton: UIButton!

    var item: Item!

    override func viewDidLoad() {
        super.viewDidLoad()

        quantityTextField.delegate = self

        var mutableString: NSMutableAttributedString = NSMutableAttributedString(attributedString:
            NSAttributedString(string: "Store: "))
        mutableString.append(NSAttributedString(string: "\(item.shop.name)",
            attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: priceLabel.font.pointSize)]))
        storeLabel.attributedText = mutableString

        mutableString = NSMutableAttributedString(attributedString:
        NSAttributedString(string: "Distance: "))
        mutableString.append(NSAttributedString(string: "\(item.shop.distance)km",
        attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: distanceLabel.font.pointSize)]))
        distanceLabel.attributedText = mutableString

        if let image = UIImage(named: item.imageName) {
            productImageView.image = image
        } else if let image = UIImage(named: "no-image") {
            productImageView.image = image
        }

        productImageView.setupDefault()

        priceLabel.text = "$\(item.price)"

        nameLabel.text = item.name
        descriptionLabel.text = item.description
        quantityTextField.text = "1"
        updateTotalPrice(Double(quantityTextField.text!))

        addButton.layer.cornerRadius = 5
    }

    @IBAction func didPressAddButton() {
        let quantity = Int(quantityTextField.text!) ?? 1
        OrdersManager.shared.add(shop: item.shop, item: item, quantity: quantity)
        let receiptController = ReceiptViewController(nibName: String(describing: ReceiptViewController.self), bundle: nil)
        navigationController?.pushViewController(receiptController, animated: true)
    }

    func updateTotalPrice(_ quantity: Double?) {
        let mutableString: NSMutableAttributedString = NSMutableAttributedString(attributedString:
            NSAttributedString(string: "Total Price: "))
        if let quantity = quantity {
            let totalPrice = item.price * quantity
            mutableString.append(NSAttributedString(string: "$\(totalPrice)",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightBlue,
                             NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: totalPriceLabel.font.pointSize)]))
        } else {
            mutableString.append(NSAttributedString(string: "N/A",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightBlue,
                             NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: totalPriceLabel.font.pointSize)]))
        }
        totalPriceLabel.attributedText = mutableString
    }
}

extension DetailsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate: NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        updateTotalPrice(Double(String(txtAfterUpdate)))
        return true
    }
}
