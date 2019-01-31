//
//  Currency.swift
//  Converto
//
//  Created by Giovanni Barbiero on 18/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class Currencies {
    static private var currencies : [Currency] = [
        Currency(name: NSLocalizedString("Euro", comment: "name"), code: "EUR", symbol: "€", country: NSLocalizedString("European Union", comment: "paese")),
        Currency(name: NSLocalizedString("US Dollar", comment: "name"), code: "USD", symbol: "$", country: NSLocalizedString("United States of America", comment: "paese")),
        Currency(name: NSLocalizedString("British Pound", comment: "name"), code: "GBP", symbol: "£", country: NSLocalizedString("England", comment: "paese"))
    ]
    static func getCurrencies() -> [Currency] {
        if currencies.count < 4 {
            let cur = [
                Currency(name: NSLocalizedString("Australian Dollar", comment: "name"), code: "AUD", symbol: "A$", country: NSLocalizedString("Australia", comment: "paese")),
                Currency(name: NSLocalizedString("Brazilian Real", comment: "name"), code: "BRL", symbol: "R$", country: NSLocalizedString("Brazil", comment: "paese")),
                Currency(name: NSLocalizedString("Bulgarian Lev", comment: "name"), code: "BGN", symbol: "lv", country: NSLocalizedString("Bulgaria", comment: "paese")),
                Currency(name: NSLocalizedString("Canadian Dollar", comment: "name"), code: "CAD", symbol: "C$", country: NSLocalizedString("Canada", comment: "paese")),
                Currency(name: NSLocalizedString("Chinese Renminbi", comment: "name"), code: "CNY", symbol: "¥", country: NSLocalizedString("China", comment: "paese")),
                Currency(name: NSLocalizedString("Croatian Kuna", comment: "name"), code: "HRK", symbol: "kn", country: NSLocalizedString("Croatia", comment: "paese")),
                Currency(name: NSLocalizedString("Czech Crown", comment: "name"), code: "CZK", symbol: "Kč", country: NSLocalizedString("Czech Republic", comment: "paese")),
                Currency(name: NSLocalizedString("Danish Krone", comment: "name"), code: "DKK", symbol: "kr", country: NSLocalizedString("Denmark", comment: "paese")),
                Currency(name: NSLocalizedString("Hong Kong Dollar", comment: "name"), code: "HKD", symbol: "HK$", country: NSLocalizedString("Hong Kong", comment: "paese")),
                Currency(name: NSLocalizedString("Hungarian Forint", comment: "name"), code: "HUF", symbol: "Ft", country: NSLocalizedString("Hungary", comment: "paese")),
                Currency(name: NSLocalizedString("Icelandic Krona", comment: "name"), code: "ISK", symbol: "kr", country: NSLocalizedString("Iceland", comment: "paese")),
                Currency(name: NSLocalizedString("Indian Rupee", comment: "name"), code: "INR", symbol: "Rs", country: NSLocalizedString("India", comment: "paese")),
                Currency(name: NSLocalizedString("Indonesian Rupee", comment: "name"), code: "IDR", symbol: "Rp", country: NSLocalizedString("Indonesia", comment: "paese")),
                Currency(name: NSLocalizedString("Malaysian Ringgit", comment: "name"), code: "MYR", symbol: "M$", country: NSLocalizedString("Malaysia", comment: "paese")),
                Currency(name: NSLocalizedString("Mexican Peso", comment: "name"), code: "MXN", symbol: "Mex$", country: NSLocalizedString("Mexico", comment: "paese")),
                Currency(name: NSLocalizedString("New Israeli Shekel", comment: "name"), code: "ILS", symbol: "₪", country: NSLocalizedString("Israel", comment: "paese")),
                Currency(name: NSLocalizedString("New Zealand Dollar", comment: "name"), code: "NZD", symbol: "$", country: NSLocalizedString("New Zealand", comment: "paese")),
                Currency(name: NSLocalizedString("Norwegian Krone", comment: "name"), code: "NOK", symbol: "kr", country: NSLocalizedString("Norway", comment: "paese")),
                Currency(name: NSLocalizedString("Philippine Weight", comment: "name"), code: "PHP", symbol: "₱", country: NSLocalizedString("Philippines", comment: "paese")),
                Currency(name: NSLocalizedString("Polish Zloty", comment: "name"), code: "PLN", symbol: "zł", country: NSLocalizedString("Poland", comment: "paese")),
                Currency(name: NSLocalizedString("Romanian Leu", comment: "name"), code: "RON", symbol: "L", country: NSLocalizedString("Romania", comment: "paese")),
                Currency(name: NSLocalizedString("Russian Ruble", comment: "name"), code: "RUB", symbol: "₽", country: NSLocalizedString("Russia", comment: "paese")),
                Currency(name: NSLocalizedString("Singapore Dollar", comment: "name"), code: "SGD", symbol: "S$", country: NSLocalizedString("Singapore", comment: "paese")),
                Currency(name: NSLocalizedString("South African Rand", comment: "name"), code: "ZAR", symbol: "R", country: NSLocalizedString("South Africa", comment: "paese")),
                Currency(name: NSLocalizedString("South Korean Won", comment: "name"), code: "KRW", symbol: "₩", country: NSLocalizedString("South Korea", comment: "paese")),
                Currency(name: NSLocalizedString("Swedish Krona", comment: "name"), code: "SEK", symbol: "kr", country: NSLocalizedString("Sweden", comment: "paese")),
                Currency(name: NSLocalizedString("Swiss Franc", comment: "name"), code: "CHF", symbol: "Fr.", country: NSLocalizedString("Switzerland", comment: "paese")),
                Currency(name: NSLocalizedString("Thai Baht", comment: "name"), code: "THB", symbol: "฿", country: NSLocalizedString("Thailand", comment: "paese")),
                Currency(name: NSLocalizedString("Turkish Lira", comment: "name"), code: "TRY", symbol: "₺", country: NSLocalizedString("Turkey", comment: "paese")),
                Currency(name: NSLocalizedString("Yen", comment: "name"), code: "JPY", symbol: "¥", country: NSLocalizedString("Japan", comment: "paese"))
            ].sorted { (a, b) -> Bool in
                return a.name < b.name
            }
            for c in cur {
                currencies.append(c)
            }
        }
        return currencies
    }
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
