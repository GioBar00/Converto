//
//  ConvertoViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 15/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class ConvertoViewController: UIViewController, CurrencyChooseHandler {
    
    static var leftCurrency = Currencies.getCurrencies().first(where: {$0.code == "EUR"}) ?? Currencies.getCurrencies()[0]
    static var rightCurrency = Currencies.getCurrencies().first(where: {$0.code == "USD"}) ?? Currencies.getCurrencies()[1]
    
    static var exchangeValue : Double = 1.2
    
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
    
    let maxLenght : Int = 13
    
    var modifying = false
    var modifyingLeft = false
    
    var timeoutTimer : Timeout? = nil
    var loading = false
    
    var sv : UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 2
        if UIDevice.current.userInterfaceIdiom == .pad {
            shadow.shadowOffset = CGSize(width: 5, height: 0)
            navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: "GillSans-SemiBoldItalic", size: 60)!, .foregroundColor: UIColor.white, .shadow: shadow]
        }
        else {
            shadow.shadowOffset = CGSize(width: 3, height: 0)
            navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: "GillSans-SemiBoldItalic", size: 45)!, .foregroundColor: UIColor.white, .shadow: shadow]
        }
        navigationController?.view.backgroundColor = UIColor(red: 37/255, green: 65/255, blue: 178/255, alpha: 1)
        
        CurrenciesTableViewController.chooseHandler = self
        btnExchange.imageView?.contentMode = .scaleAspectFit
        btnCurrencyLeft.imageView?.contentMode = .scaleAspectFill
        btnCurrencyRight.imageView?.contentMode = .scaleAspectFill
        lblExchangeRate.text = ""
        lblResult.text = 0.0.toString(minimumFractionDigits: 2, maximumFractionDigits: 2)
        textFieldQuantity.text = 1.0.toString(minimumFractionDigits: 2, maximumFractionDigits: 2)
        
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
        loading = true
        timeoutTimer = Timeout(30) {
            self.showError()
        }
        if let s = sv {
            UIViewController.removeSpinner(spinner: s)
        }
        sv = UIViewController.displaySpinner(onView: self.view)
        ApiManager.Instance.GetExchange(base: ConvertoViewController.leftCurrency, to: ConvertoViewController.rightCurrency, completion: { val in
            self.updateExchangeValue(val: val)
            StaticClass.exchangeRateReload?.reloadData()
        }, onError: {
            self.showError()
        })
        loadCurrencies()
    }
    
    func getNumLabel() -> String {
        var s = ""
        var numAfterDot = 0
        
        for x in lblResult.text ?? "0.00" {
            if numAfterDot > 3 {
                return s
            }
            s += String(x)
            if x == Character(".") || x == Character(","){
                numAfterDot += 1
            }
            if numAfterDot != 0 {
                numAfterDot += 1
            }
        }
        return "1"
    }
    
    func updateExchangeValue(val : Double) {
        if let s = sv {
            UIViewController.removeSpinner(spinner: s)
            sv = nil
        }
        loading = false
        clearTimeout()
        ConvertoViewController.exchangeValue = val
        let s = ConvertoViewController.exchangeValue.toString(minimumFractionDigits: 2, maximumFractionDigits: 5)
        lblExchangeRate.text = NSLocalizedString("Exchange:\n", comment: "titolo exchange") + s
        updateResults()
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
        if let value = textFieldQuantity.text?.toDouble() {
            res = value * ConvertoViewController.exchangeValue
        }
        lblResult.text = res.toString(minimumFractionDigits: 2, maximumFractionDigits: 2) + " " + String(ConvertoViewController.rightCurrency.symbol)
    }
    
    @IBAction func btnSwitch(_ sender: Any) {
        closeKeyboad()
        let temp = ConvertoViewController.rightCurrency
        ConvertoViewController.rightCurrency = ConvertoViewController.leftCurrency
        ConvertoViewController.leftCurrency = temp
        if textFieldQuantity.text?.toDouble() ?? 1 != 1 {
            textFieldQuantity.text = getNumLabel()
        }
        else {
            textFieldQuantity.text = 1.0.toString(minimumFractionDigits: 2, maximumFractionDigits: 2)
        }
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
            if c == Character(".") || c == Character(",") {
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
                if text[1] != Character(".") && text[1] != Character(",") {
                    textFieldQuantity.text?.removeFirst()
                    return
                }
            }
        }
        if dotNum > 1  || num > 2 || textFieldQuantity.text?.count ?? 0 > maxLenght{
            textFieldQuantity.text?.removeLast()
        }
        else {
            updateResults()
        }
        //lblResult.isHidden = textFieldQuantity.text == ""
    }
    
    @IBAction func textFieldBegin(_ sender: Any) {
        buttomView.isHidden = true
        //lblResult.isHidden = textFieldQuantity.text == ""
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
                        ConvertoViewController.rightCurrency = Currencies.getCurrencies().first(where: {$0.code == "USD"}) ?? Currencies.getCurrencies()[1]
                    }
                    else {
                        ConvertoViewController.rightCurrency = Currencies.getCurrencies().first(where: {$0.code == "EUR"}) ?? Currencies.getCurrencies()[0]
                    }
                }
            }
            if textFieldQuantity.text ?? "" == "" {
                textFieldQuantity.text = 1.0.toString(minimumFractionDigits: 2, maximumFractionDigits: 2)
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
    
    func showError() {
        if loading {
            clearTimeout()
        }
        loading = false
        let alert = UIAlertController(title: NSLocalizedString("Warning", comment: "titolo"), message: NSLocalizedString("It wasn't possible to load the exchange value.\nCheck if there is connection and try again.", comment: "messaggio"), preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: NSLocalizedString("Try again", comment: "button"), style: .default) { (nil) in
            self.getExchangeValues()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func clearTimeout() {
        timeoutTimer?.cancel()
        timeoutTimer = nil
    }
}
