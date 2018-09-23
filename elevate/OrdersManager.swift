//
//  OrdersManager.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-22.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import UIKit

class OrdersManager {

    static let shared = OrdersManager()
    var shop: Shop?
    var items = [Item]()
    var quantities = [Int]()

    func add(shop: Shop, item: Item, quantity: Int) {
        if self.shop?.shopId != shop.shopId {
            self.shop = shop
            items = [Item]()
            quantities = [Int]()
        }
        if let index = items.index(where: {$0.itemId == item.itemId}) {
            quantities[index] = quantities[index] + quantity
        } else {
            items.append(item)
            quantities.append(quantity)
        }
    }

    func update(item: Item, quantity: Int) {
        if let index = items.index(where: {$0.itemId == item.itemId}) {
            quantities[index] = quantity
        }
    }

    func remove(shop: Shop, item: Item) {
        if let shopId = self.shop?.shopId,
            shopId == shop.shopId,
            let index = items.index(where: {$0.itemId == item.itemId}) {
            items.remove(at: index)
            quantities.remove(at: index)
        }
    }

    func reset() {
        shop = nil
        items = [Item]()
        quantities = [Int]()
    }

    func total() -> Double {
        var total = 0.0
        for i in 0..<items.count {
            let item = items[i]
            let quantity = quantities[i]
            total += item.price * Double(quantity)
        }
        return total
    }
}
