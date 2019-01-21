//
//  Currency.swift
//  Converto
//
//  Created by Giovanni Barbiero on 18/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class Currencies {
    static let currencies : [Currency] = [
        Currency(name: "Euro", code: "EUR", symbol: Character("€"), country: "Unione Europea"),
        Currency(name: "Dollaro statunitense", code: "USD", symbol: Character("€"), country: "Stati Uniti d'America"),
        Currency(name: "Sterlina britannica", code: "GBP", symbol: Character("€"), country: "Inghilterra"),
        Currency(name: "Dollaro canadese", code: "CAD", symbol: Character("€"), country: "Canada"),
        Currency(name: "Dollaro australiano", code: "AUD", symbol: Character("€"), country: "Australia"),
        Currency(name: "Peso filippino", code: "PHP", symbol: Character("€"), country: "Filippine"),
        Currency(name: "Fiorino ungherese", code: "HUF", symbol: Character("€"), country: "Ungheria"),
        Currency(name: "Rupia indonesiana", code: "IDR", symbol: Character("€"), country: "Indonesia"),
        Currency(name: "Lira turca", code: "TRY", symbol: Character("€"), country: "Turchia"),
        Currency(name: "Leu romeno", code: "RON", symbol: Character("€"), country: "Romania"),
        Currency(name: "Corona islandese", code: "ISK", symbol: Character("€"), country: "Islanda"),
        Currency(name: "Nuovo shekel israeliano", code: "ILS", symbol: Character("€"), country: "Israele"),
        Currency(name: "Renminbi cinese", code: "CNY", symbol: Character("€"), country: "Cina"),
        Currency(name: "Złoty polacco", code: "PLN", symbol: Character("€"), country: "Polonia"),
        Currency(name: "Ringgit malaysiano", code: "MYR", symbol: Character("€"), country: "Malesia"),
        Currency(name: "Dollaro neozelandese", code: "NZD", symbol: Character("€"), country: "Nuova Zelanda"),
        Currency(name: "Franco svizzero", code: "CHF", symbol: Character("€"), country: "Svizzera"),
        Currency(name: "Kuna croata", code: "HRK", symbol: Character("€"), country: "Croazia"),
        Currency(name: "Dollaro di Singapore", code: "SGD", symbol: Character("€"), country: "Singapore"),
        Currency(name: "Corona danese", code: "DKK", symbol: Character("€"), country: "Danimarca"),
        Currency(name: "Lev bulgaro", code: "BGN", symbol: Character("€"), country: "Bulgaria"),
        Currency(name: "Corona ceca", code: "CZK", symbol: Character("€"), country: "Repubblica Ceca"),
        Currency(name: "Real brasiliano", code: "BRL", symbol: Character("€"), country: "Brasile"),
        Currency(name: "Yen", code: "JPY", symbol: Character("€"), country: "Giappone"),
        Currency(name: "Won sudcoreano", code: "KRW", symbol: Character("€"), country: "Sud Korea"),
        Currency(name: "Rupia indiana", code: "INR", symbol: Character("€"), country: "India"),
        Currency(name: "Corona svedese", code: "SEK", symbol: Character("€"), country: "Svezia"),
        Currency(name: "Peso messicano", code: "MXN", symbol: Character("€"), country: "Messico"),
        Currency(name: "Rublo russo", code: "RUB", symbol: Character("€"), country: "Russia"),
        Currency(name: "Dollaro di Hong Kong", code: "HKD", symbol: Character("€"), country: "Hong Kong"),
        Currency(name: "Rand sudafricano", code: "ZAR", symbol: Character("€"), country: "Sudafrica"),
        Currency(name: "Baht thailandese", code: "THB", symbol: Character("€"), country: "Thailandia"),
        Currency(name: "Corona norvegese", code: "NOK", symbol: Character("€"), country: "Norvegia")]
}

class Currency {
    let code : String
    let country : String
    let name : String
    
    let symbol : Character
    
    init(name n: String, code c: String, symbol s: Character, country co : String) {
        name = n
        code = c
        symbol = s
        country = co
    }
    convenience init() {
        self.init(name: "Unknown", code: "unknown", symbol: Character(" "), country: "Unknown")
    }
    
    func Image() -> UIImage {
        return UIImage(named: code) ?? UIImage(named: "unknown") ?? UIImage()
    }
    
    func Description() -> String {
        return code + " - " + country
    }
}
