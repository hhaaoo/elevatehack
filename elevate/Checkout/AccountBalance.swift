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

struct TransferRequest: Codable {
    var receipt: Receipt

    enum CodingKeys: String, CodingKey {
        case receipt = "result"
    }
}

struct Receipt: Codable {
    var amount: Double
    var creditTransactionID: String
    var currency: String
    var debitTransactionID: String
    var fromAccountId: String
    var receiptId: String
    var receipt: String
    var toAccountId: String
    var transactionTime: String
    var transactionType: String
}
