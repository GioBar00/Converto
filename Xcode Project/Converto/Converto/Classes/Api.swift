//
//  Api.swift
//  Converto
//
//  Created by Giovanni Barbiero on 18/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class ApiManager {
    static let Instance = ApiManager()
    private init() {}
    
    let apiUrl = "https://api.exchangeratesapi.io/"
    
    func GetExchange(base : Currency, to : Currency, completion: @escaping (Double)->()) {
        var url = apiUrl + "latest/"
        url += "?base=" + base.code + "&"
        url += "symbols=" + to.code
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                
                print(response.rates[to.code] ?? 0)
                
                DispatchQueue.main.async {
                    completion(response.rates[to.code] ?? 0)
                }
            } catch let error as NSError {
                print("---ERRORE get Json---")
                print(error)
            }
            
        }).resume()
    }
}


class Response: Codable {
    let rates : [String: Double]
    let base, date: String
    
    init(rates: [String: Double], base: String, date: String) {
        self.rates = rates
        self.base = base
        self.date = date
    }
}

