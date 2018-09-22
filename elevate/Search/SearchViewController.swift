//
//  SearchViewController.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-22.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!

    private var allItems = [Item]()
    var visibleItems = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        visibleItems = allItems.filter { $0.name.hasPrefix(string)}
        tableView.reloadData()
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
