//
//  Protocols.swift
//  Converto
//
//  Created by Giovanni Barbiero on 21/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

protocol CurrencySelectHandler {
    func chooseCurrency(currency c : Currency)
}

protocol CurrencyChooseHandler {
    func currencyChoosen(currency c : Currency?)
    func currencyToRemove() -> Currency?
    func selectedCurrency() -> Currency
}
