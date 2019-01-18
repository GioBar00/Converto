//
//  Currency.swift
//  Converto
//
//  Created by Giovanni Barbiero on 18/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

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
    
    func Image() -> UIImage {
        return UIImage(named: code) ?? UIImage()
    }
}
