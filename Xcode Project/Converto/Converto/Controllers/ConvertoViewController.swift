//
//  ConvertoViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 15/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class ConvertoViewController: UIViewController, CurrencyChooseHandler {
    
    @IBOutlet weak var btnCurrencyLeft: UIButton!
    @IBOutlet weak var lblLeftCurrencyName: UILabel!
    
    @IBOutlet weak var btnCurrencyRight: UIButton!
    @IBOutlet weak var lblRightCurrencyName: UILabel!
    
    @IBOutlet weak var textFieldQuantity: UITextField!
    
    @IBOutlet weak var btnExchange: UIButton!
    @IBOutlet weak var historyView: UIView!
    
    @IBOutlet weak var lblResult: UILabel!
    
    var leftCurrency = Currencies.currencies.first(where: {$0.code == "EUR"}) ?? Currencies.currencies[0]
    var rightCurrency = Currencies.currencies.first(where: {$0.code == "USD"}) ?? Currencies.currencies[1]
    
    var modifying = false
    var modifyingLeft = false
    
    var canPutDot = true
    
    var exchangeValue : Double = 1.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CurrenciesTableViewController.chooseHandler = self
        btnExchange.imageView?.contentMode = .scaleAspectFit
        btnCurrencyLeft.imageView?.contentMode = .scaleAspectFit
        btnCurrencyRight.imageView?.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
        getExchangeValues()
    }
    
    func closeKeyboad() {
        view.endEditing(true)
    }
    
    @objc func handleTap() {
        closeKeyboad()
    }
    
    func getExchangeValues() {
        // get exchange from api
        // put loading screen
        
        loadCurrencies()
        textFieldQuantity.text = ""
        updateResults()
    }
    
    func loadCurrencies() {
        lblLeftCurrencyName.text = leftCurrency.name
        btnCurrencyLeft.setImage(leftCurrency.Image(), for: .normal)
        
        
        lblRightCurrencyName.text = rightCurrency.name
        btnCurrencyRight.setImage(rightCurrency.Image(), for: .normal)
    }
    
    func updateResults() {
        var res = 0 as Double
        if let value = Double(textFieldQuantity.text ?? "0") {
            res = value * exchangeValue
        }
        lblResult.text = String(format:"%.2f", res) + String(rightCurrency.symbol)
    }
    
    @IBAction func btnSwitch(_ sender: Any) {
        closeKeyboad()
        let temp = rightCurrency
        rightCurrency = leftCurrency
        leftCurrency = temp
        getExchangeValues()
    }
    
    @IBAction func btnCurrencyClick(_ sender: Any) {
        closeKeyboad()
        if let btn = sender as? UIButton {
            modifying = true
            if btn.tag == 1 {
                print("Choose LEFT")
            }
            else {
                print("Choose RIGHT")
            }
            modifyingLeft = btn.tag == 1
            
        }
    }
    @IBAction func textFieldTextChange(_ sender: Any) {
        var dotNum = 0
        var num = 0
        var dotfound = false
        for c in textFieldQuantity.text ?? "" {
            if c == Character(".") {
                dotNum += 1
                dotfound = true
            }
            else {
                if dotfound {
                    num += 1
                }
            }
        }
        if dotNum > 1  || num > 2 || textFieldQuantity.text == "00"{
            textFieldQuantity.text?.removeLast()
        }
        else {
            updateResults()
        }
    }
    
    func currencyChoosen(currency c: Currency?) {
        if let currency = c {
            if !modifyingLeft {
                rightCurrency = currency
            }
            else {
                leftCurrency = currency
                if leftCurrency.code == rightCurrency.code {
                    if leftCurrency.code == "EUR" {
                        rightCurrency = Currencies.currencies.first(where: {$0.code == "USD"}) ?? Currencies.currencies[1]
                    }
                    else {
                        rightCurrency = Currencies.currencies.first(where: {$0.code == "EUR"}) ?? Currencies.currencies[0]
                    }
                }
            }
            getExchangeValues()
        }
    }
    
    func currencyToRemove() -> Currency? {
        if modifying && !modifyingLeft {
            return leftCurrency
        }
        return nil
    }
    
    func selectedCurrency() -> Currency {
        if modifyingLeft {
            return leftCurrency
        }
        return rightCurrency
    }
}
