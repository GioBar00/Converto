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
        Currency(name: "Euro", code: "EUR", symbol: "€", country: "Unione Europea"),
        Currency(name: "Dollaro Statunitense", code: "USD", symbol: "$", country: "Stati Uniti d'America"),
        Currency(name: "Sterlina Britannica", code: "GBP", symbol: "£", country: "Inghilterra"),
        Currency(name: "Dollaro Canadese", code: "CAD", symbol: "C$", country: "Canada"),
        Currency(name: "Dollaro Australiano", code: "AUD", symbol: "A$", country: "Australia"),
        Currency(name: "Peso Filippino", code: "PHP", symbol: "₱", country: "Filippine"),
        Currency(name: "Fiorino Ungherese", code: "HUF", symbol: "Ft", country: "Ungheria"),
        Currency(name: "Rupia Indonesiana", code: "IDR", symbol: "Rp", country: "Indonesia"),
        Currency(name: "Lira Turca", code: "TRY", symbol: "₺", country: "Turchia"),
        Currency(name: "Leu Romeno", code: "RON", symbol: "L", country: "Romania"),
        Currency(name: "Corona Islandese", code: "ISK", symbol: "kr", country: "Islanda"),
        Currency(name: "Nuovo Shekel Israeliano", code: "ILS", symbol: "₪", country: "Israele"),
        Currency(name: "Renminbi Cinese", code: "CNY", symbol: "¥", country: "Cina"),
        Currency(name: "Złoty Polacco", code: "PLN", symbol: "zł", country: "Polonia"),
        Currency(name: "Ringgit Malesiano", code: "MYR", symbol: "M$", country: "Malesia"),
        Currency(name: "Dollaro Neozelandese", code: "NZD", symbol: "$", country: "Nuova Zelanda"),
        Currency(name: "Franco Svizzero", code: "CHF", symbol: "Fr.", country: "Svizzera"),
        Currency(name: "Kuna Croata", code: "HRK", symbol: "kn", country: "Croazia"),
        Currency(name: "Dollaro di Singapore", code: "SGD", symbol: "S$", country: "Singapore"),
        Currency(name: "Corona Danese", code: "DKK", symbol: "kr", country: "Danimarca"),
        Currency(name: "Lev Bulgaro", code: "BGN", symbol: "lv", country: "Bulgaria"),
        Currency(name: "Corona Ceca", code: "CZK", symbol: "Kč", country: "Repubblica Ceca"),
        Currency(name: "Real Brasiliano", code: "BRL", symbol: "R$", country: "Brasile"),
        Currency(name: "Yen", code: "JPY", symbol: "¥", country: "Giappone"),
        Currency(name: "Won Sudcoreano", code: "KRW", symbol: "₩", country: "Sud Korea"),
        Currency(name: "Rupia Indiana", code: "INR", symbol: "Rs", country: "India"),
        Currency(name: "Corona Svedese", code: "SEK", symbol: "kr", country: "Svezia"),
        Currency(name: "Peso Messicano", code: "MXN", symbol: "Mex$", country: "Messico"),
        Currency(name: "Rublo Russo", code: "RUB", symbol: "₽", country: "Russia"),
        Currency(name: "Dollaro di Hong Kong", code: "HKD", symbol: "HK$", country: "Hong Kong"),
        Currency(name: "Rand Sudafricano", code: "ZAR", symbol: "R", country: "Sudafrica"),
        Currency(name: "Baht Thailandese", code: "THB", symbol: "฿", country: "Thailandia"),
        Currency(name: "Corona Norvegese", code: "NOK", symbol: "kr", country: "Norvegia")]
}

class Currency {
    let code : String
    let country : String
    let name : String
    
    let symbol : String
    
    init(name n: String, code c: String, symbol s: String, country co : String) {
        name = n
        code = c
        symbol = s
        country = co
    }
    convenience init() {
        self.init(name: "Unknown", code: "unknown", symbol: "?", country: "Unknown")
    }
    
    func Image() -> UIImage {
        return UIImage(named: code) ?? UIImage(named: "unknown") ?? UIImage()
    }
    
    func Description() -> String {
        return code + " - " + country
    }
}
