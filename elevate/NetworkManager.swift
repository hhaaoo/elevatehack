//
//  NetworkManager.swift
//  elevate
//
//  Created by Richard Yu on 2018-09-23.
//  Copyright © 2018 elevatehack. All rights reserved.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    private struct Consts {
        static let baseUrl = "https://api.td-davinci.com/api/"
        static let getAccountsUrl = "accounts/"
        static let apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDQlAiLCJ0ZWFtX2lkIjoiYmQyM2RlMTItZmQ0YS0zOTJmLTkzMDEtMDVhZGFjOGQwOWViIiwiZXhwIjo5MjIzMzcyMDM2ODU0Nzc1LCJhcHBfaWQiOiIzMGY4NjJkMi03NWMxLTQ2NjAtYWY0Yy0yZTliM2NmNzIzNWIifQ.SzDZU2TPzNfpxQ6iqVJNe-SRVz_4u3mQTn32CVP8EFE"
    }

    func getBalance(accountId: String = "30f862d2-75c1-4660-af4c-2e9b3cf7235b_1e3a6b98-02b7-42da-99dc-1f8fa58bb012",
                    completion: ((_ accounts: Accounts?, _ error: Error?) -> Void)?) {
        let url = URL(string: Consts.baseUrl + "customers/" + accountId + "/accounts")

        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(Consts.apiKey, forHTTPHeaderField: "Authorization")

        let session = URLSession.shared

        session.dataTask(with: request) { data, response, err in
            if let accountRequest = try? JSONDecoder().decode(AccountRequest.self, from: data!) {
                completion?(accountRequest.accounts, nil)
            } else {
                completion?(nil, err)
            }
            }.resume()
    }

    func makeTransfer(amount: Double, fromAccountId: String = "30f862d2-75c1-4660-af4c-2e9b3cf7235b_1e3a6b98-02b7-42da-99dc-1f8fa58bb012", toAccountId: String = "30f862d2-75c1-4660-af4c-2e9b3cf7235b_6e611340-7143-48a7-9115-b97d62a52d60", completion: ((_ accounts: Receipt?, _ error: Error?) -> Void)?) {

        let url = URL(string: Consts.baseUrl + "transfers")
        var request = URLRequest(url: url!)

        let parameters: [String: Any] = ["amount": amount,
                                         "currency": "CAD",
                                         "fromAccountID": fromAccountId,
                                         "receipt": "{}",
                                         "toAccountID": toAccountId]

        request.httpMethod = "POST"
        request.setValue(Consts.apiKey, forHTTPHeaderField: "Authorization")

        let session = URLSession.shared

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])

            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            session.dataTask(with: request) { data, response, err in

                do {
                    let results: NSDictionary = try JSONSerialization.jsonObject(with: data!) as! NSDictionary
                    print(results)
                } catch {}
                let transferRequest = try? JSONDecoder().decode(TransferRequest.self, from: data!)
                completion?(transferRequest?.receipt, nil)
//                if let transferRequest = try? JSONDecoder().decode(TransferRequest.self, from: data!) {
//                    completion?(transferRequest.receipt, nil)
//                } else {
//                    completion?(nil, err)
//                }
                }.resume()
        } catch {
        }
    }

}
