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
        textField.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0)

        if let filepath = Bundle.main.path(forResource: "Items", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
                let jsonData = contents.data(using: .utf8)!
                let decoder = JSONDecoder()
                let items = try! decoder.decode(Items.self, from: jsonData)
                allItems = items.items
            } catch {
                // contents could not be loaded
            }
        } else {
            // Items.txt not found!
        }

        tableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: SearchTableViewCell.identifier)
    }

}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        visibleItems = allItems.filter { $0.name.lowercased().hasPrefix(string.lowercased())}
        tableView.reloadData()
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = visibleItems[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier)
            as? SearchTableViewCell {
            cell.configure(for: item)
            return cell
        }
        return UITableViewCell()
    }
}
