//
//  CheckoutViewController.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-22.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit
import SVProgressHUD

class CheckoutViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var cardLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var payButton: UIButton!
    @IBOutlet var creditCardImageView: UIImageView!

    private var accounts: Accounts?
    private var currentAccountId: String?
    private var balance: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0)
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: CheckoutTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CheckoutTableViewCell.identifier)
        tableView.reloadData()
        payButton.layer.cornerRadius = 5
        totalLabel.text = "\(OrdersManager.shared.total())"
        NetworkManager.shared.getBalance { [weak self] (accounts, error) in
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self?.accounts = accounts
                if let bankAccount = accounts?.bankAccounts?.first {
                    self?.cardLabel.text = "Debit"
                    self?.balanceLabel.text = "$\(bankAccount.balance)"
                    self?.balance = bankAccount.balance
                    self?.currentAccountId = bankAccount.bankAccountId
                } else if let creditCardAccount = accounts?.creditCardAccount {
                    self?.cardLabel.text = "Credit"
                    self?.balanceLabel.text = "$\(creditCardAccount.balance)"
                    self?.balance = creditCardAccount.balance
                    self?.currentAccountId = creditCardAccount.creditCardId
                } else {
                    self?.cardLabel.text = "Unknown"
                    self?.balanceLabel.text = "$0.00"
                    self?.balance = 0
                }
            }
        }
    }

    @IBAction func payPressed() {
        guard let currentAccountId = currentAccountId, balance > OrdersManager.shared.total() else {
            let alertView = UIAlertController(title: "Uh-Oh!!", message: "Something went wrong.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alertView, animated: true, completion: nil)
            return
        }
        SVProgressHUD.show()
        NetworkManager.shared.makeTransfer(amount: OrdersManager.shared.total(), fromAccountId: currentAccountId) { [weak self] (receipt, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
                let alertView = UIAlertController(title: "Uh-Oh!!", message: "Something went wrong.", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
                self?.present(alertView, animated: true, completion: nil)
                return
            }
            let alertView = UIAlertController(title: "Success!", message: "Please allow up to 15 minutes for vendor to respond.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK!", style: .default, handler: { [weak self] (_) in
                self?.dismiss(animated: true, completion: {
                    OrdersManager.shared.reset()
                })
            }))
            self?.present(alertView, animated: true, completion: nil)
        }
    }

    @IBAction func changeCardPressed() {
        let accountChanger = UIAlertController(title: "Accounts", message: nil, preferredStyle: .actionSheet)
        if let bankAccounts = accounts?.bankAccounts {
            for bankAccount in bankAccounts {
                accountChanger.addAction(UIAlertAction(title: "Debit: $\(bankAccount.balance)", style: .default, handler: { (_) in
                    self.cardLabel.text = "Debit"
                    self.balanceLabel.text = "$\(bankAccount.balance)"
                    self.currentAccountId = bankAccount.bankAccountId
                }))
            }
        }
        if let creditCardAccount = accounts?.creditCardAccount {
            accountChanger.addAction(UIAlertAction(title: "Credit: $\(creditCardAccount.balance)", style: .default, handler: { (_) in
                self.cardLabel.text = "Credit"
                self.balanceLabel.text = "$\(creditCardAccount.balance)"
                self.currentAccountId = creditCardAccount.creditCardId
            }))
        }
        accountChanger.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(accountChanger, animated: true, completion: nil)
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
