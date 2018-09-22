struct Receipt: Codable {
    var receiptId: Int
    var orders: [Order]
    var total: Double
}
