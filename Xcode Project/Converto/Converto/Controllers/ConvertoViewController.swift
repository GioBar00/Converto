//
//  ConvertoViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 15/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class ConvertoViewController: UIViewController, CurrencyChooseHandler {
    
    static var leftCurrency = Currencies.currencies.first(where: {$0.code == "EUR"}) ?? Currencies.currencies[0]
    static var rightCurrency = Currencies.currencies.first(where: {$0.code == "USD"}) ?? Currencies.currencies[1]
    
    @IBOutlet weak var btnCurrencyLeft: UIButton!
    @IBOutlet weak var lblLeftCurrencyName: UILabel!
    @IBOutlet weak var lblLeftCode: UILabel!
    
    @IBOutlet weak var btnCurrencyRight: UIButton!
    @IBOutlet weak var lblRightCurrencyName: UILabel!
    @IBOutlet weak var lblRightCode: UILabel!
    
    @IBOutlet weak var textFieldQuantity: UITextField!
    
    @IBOutlet weak var btnExchange: UIButton!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var buttomView: UIView!
    
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblExchangeRate: UILabel!
    
    
    var modifying = false
    var modifyingLeft = false
    
    var exchangeValue : Double = 1.2
    
    var sv : UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CurrenciesTableViewController.chooseHandler = self
        btnExchange.imageView?.contentMode = .scaleAspectFit
        btnCurrencyLeft.imageView?.contentMode = .scaleAspectFit
        btnCurrencyRight.imageView?.contentMode = .scaleAspectFit
        lblExchangeRate.text = ""
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
        getExchangeValues()
    }
    
    func closeKeyboad() {
        view.endEditing(true)
        buttomView.isHidden = false
    }
    
    @objc func handleTap() {
        closeKeyboad()
    }
    
    func getExchangeValues() {
        sv = UIViewController.displaySpinner(onView: self.view)
        ApiManager.Instance.GetExchange(base: ConvertoViewController.leftCurrency, to: ConvertoViewController.rightCurrency, completion: { val in
            self.updateExchangeValue(val: val)
        })
        loadCurrencies()
        textFieldQuantity.text = ""
        updateResults()
    }
    
    func updateExchangeValue(val : Double) {
        if let s = sv {
            UIViewController.removeSpinner(spinner: s)
        }
        exchangeValue = val
        lblExchangeRate.text = "Exchange rate:\n" + String(format:"%.5f", exchangeValue)
    }
    
    func loadCurrencies() {
        lblLeftCurrencyName.text = ConvertoViewController.leftCurrency.name
        btnCurrencyLeft.setImage(ConvertoViewController.leftCurrency.Image(), for: .normal)
        lblLeftCode.text = ConvertoViewController.leftCurrency.code
        
        
        lblRightCurrencyName.text = ConvertoViewController.rightCurrency.name
        btnCurrencyRight.setImage(ConvertoViewController.rightCurrency.Image(), for: .normal)
        lblRightCode.text = ConvertoViewController.rightCurrency.code
    }
    
    func updateResults() {
        var res = 0 as Double
        if let value = Double(textFieldQuantity.text ?? "0") {
            res = value * exchangeValue
        }
        lblResult.text = String(format:"%.2f", res) + " " + String(ConvertoViewController.rightCurrency.symbol)
    }
    
    @IBAction func btnSwitch(_ sender: Any) {
        closeKeyboad()
        let temp = ConvertoViewController.rightCurrency
        ConvertoViewController.rightCurrency = ConvertoViewController.leftCurrency
        ConvertoViewController.leftCurrency = temp
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
        let text = textFieldQuantity.text ?? ""
        if text.count > 1 {
            if text[0] == Character("0") {
                if text[1] != Character(".") {
                    textFieldQuantity.text?.removeFirst()
                    return
                }
            }
        }
        if dotNum > 1  || num > 2 {
            textFieldQuantity.text?.removeLast()
        }
        else {
            updateResults()
        }
    }
    
    @IBAction func textFieldBegin(_ sender: Any) {
        buttomView.isHidden = true
    }
    
    func currencyChoosen(currency c: Currency?) {
        if let currency = c {
            if !modifyingLeft {
                ConvertoViewController.rightCurrency = currency
            }
            else {
                ConvertoViewController.leftCurrency = currency
                if ConvertoViewController.leftCurrency.code == ConvertoViewController.rightCurrency.code {
                    if ConvertoViewController.leftCurrency.code == "EUR" {
                        ConvertoViewController.rightCurrency = Currencies.currencies.first(where: {$0.code == "USD"}) ?? Currencies.currencies[1]
                    }
                    else {
                        ConvertoViewController.rightCurrency = Currencies.currencies.first(where: {$0.code == "EUR"}) ?? Currencies.currencies[0]
                    }
                }
            }
            getExchangeValues()
        }
    }
    
    func currencyToRemove() -> Currency? {
        if modifying && !modifyingLeft {
            return ConvertoViewController.leftCurrency
        }
        return nil
    }
    
    func selectedCurrency() -> Currency {
        if modifyingLeft {
            return ConvertoViewController.leftCurrency
        }
        return ConvertoViewController.rightCurrency
    }
}
