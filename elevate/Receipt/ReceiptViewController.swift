//
//  ReceiptViewController.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-22.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var checkoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0)
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: ReceiptTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ReceiptTableViewCell.identifier)
        tableView.reloadData()
        checkoutButton.layer.cornerRadius = 5
    }

    @IBAction func checkout() {
        let checkoutController = CheckoutViewController(nibName: String(describing: CheckoutViewController.self), bundle: nil)
        let navController = UINavigationController(rootViewController: checkoutController)
        navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.backgroundColor = UIColor.clear
        navigationController?.present(navController, animated: true, completion: { [weak self] in
            if let firstController = self?.navigationController?.viewControllers.first {
                self?.navigationController?.viewControllers = [firstController]
            }
        })
    }
}

extension ReceiptViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrdersManager.shared.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ReceiptTableViewCell.identifier)
            as? ReceiptTableViewCell {
            let item = OrdersManager.shared.items[indexPath.row]
            let quantity = OrdersManager.shared.quantities[indexPath.row]
            cell.configure(for: item, quantity: quantity)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}

extension ReceiptViewController: ReceiptTableViewCellDelegate {
    func didUpdate() {

    }

    func didDelete() {
        tableView.reloadData()
    }
}
