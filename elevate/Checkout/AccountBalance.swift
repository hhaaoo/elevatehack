struct AccountRequest: Codable {
    var accounts: Accounts

    enum CodingKeys: String, CodingKey {
        case accounts = "result"
    }
}

struct Accounts: Codable {
    var bankAccounts: [BankAccount]?
    var creditCardAccount: CreditCardAccount?
}

struct BankAccount: Codable {
    var bankAccountId: String
    var branchNumber: String
    var balance: Double
    var currency: String

    enum CodingKeys: String, CodingKey {
        case bankAccountId = "id"
        case branchNumber
        case balance
        case currency
    }
}

struct CreditCardAccount: Codable {
    var creditCardId: String
    var balance: Double
    var currency: String

    enum CodingKeys: String, CodingKey {
        case creditCardId = "id"
        case balance
        case currency
    }
}
