struct Item: Codable {
    var itemId: String
    var name: String
    var description: String?
    var imageName: String
    var price: Double
    var shop: Shop

    enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case imageName = "image"
        case name
        case description
        case price
        case shop
    }
}

struct Items: Codable {
    var items: [Item]
}

struct Shop: Codable {
    var shopId: String
    var name: String
    var distance: String
}
