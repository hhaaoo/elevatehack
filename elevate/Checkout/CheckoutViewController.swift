//
//  CheckoutViewController.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-22.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cardLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var payButton: UIButton!
    @IBOutlet var creditCardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0)
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: CheckoutTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CheckoutTableViewCell.identifier)
        tableView.reloadData()
        payButton.layer.cornerRadius = 5
        totalLabel.text = "\(OrdersManager.shared.total())"
    }

    @IBAction func payPressed() {
        
    }

    @IBAction func changeCardPressed() {

    }

    @IBAction func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrdersManager.shared.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutTableViewCell.identifier)
            as? CheckoutTableViewCell {
            let item = OrdersManager.shared.items[indexPath.row]
            let quantity = OrdersManager.shared.quantities[indexPath.row]
            cell.configure(for: item, quantity: quantity)
            return cell
        }
        return UITableViewCell()
    }

}
