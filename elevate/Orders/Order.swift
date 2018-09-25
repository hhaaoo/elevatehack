struct Order: Codable {
    var orderId: Int
    var totalPrice: Double
    var shop: Shop
    var orderDate: String
    var completeDate: String?
    var status: String
}
