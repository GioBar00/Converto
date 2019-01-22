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
        var url = apiUrl + "latest/?"
        url += "base=" + base.code + "&"
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
    
    func GetHistory(base: Currency, symbol symb: Currency, from: Date, to: Date, completion: @escaping ([Date : Double])->()) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var url = apiUrl + "history/?"
        url += "base=" + base.code + "&"
        url += "symbols=" + symb.code + "&"
        url += "start_at=" + dateFormatter.string(from: from) + "&"
        url += "end_at=" + dateFormatter.string(from: to)
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(ResponseHistory.self, from: data)
                var values : [Date : Double] = [:]
                for dateString in response.rates.keys {
                    if let date = dateFormatter.date(from: dateString) {
                        values[date] = response.rates[dateString]![symb.code] ?? 0
                    }
                    
                }
                
                DispatchQueue.main.async {
                    completion(values)
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

class ResponseHistory: Codable {
    let endAt: String
    let rates: [String: [String : Double]]
    let startAt, base: String
    
    enum CodingKeys: String, CodingKey {
        case endAt = "end_at"
        case rates
        case startAt = "start_at"
        case base
    }
    
    init(endAt: String, rates: [String: [String : Double]], startAt: String, base: String) {
        self.endAt = endAt
        self.rates = rates
        self.startAt = startAt
        self.base = base
    }
}
