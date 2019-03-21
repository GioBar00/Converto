//
//  CurrenciesTableViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 21/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class CurrenciesTableViewController: UITableViewController, CurrencySelectHandler {

    static var chooseHandler : CurrencyChooseHandler? = nil
    
    var currencies = Currencies.getCurrencies()
    
    var selecterCurrency = Currencies.getCurrencies()[0]
    
    var alreadyCalled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alreadyCalled = false
        
        if let curr = CurrenciesTableViewController.chooseHandler?.currencyToRemove() {
            if let index = currencies.firstIndex(where: {$0.code == curr.code}) {
                currencies.remove(at: index)
            }
        }
        selecterCurrency = CurrenciesTableViewController.chooseHandler?.selectedCurrency() ?? Currencies.getCurrencies()[0]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.isMovingToParent && !alreadyCalled {
            CurrenciesTableViewController.chooseHandler?.currencyChoosen(currency:  nil)
        }
    }
    
    func chooseCurrency(currency c : Currency) {
        CurrenciesTableViewController.chooseHandler?.currencyChoosen(currency:  c)
        alreadyCalled = true
        _ = navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currencies.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 120
        }
        else {
            return 80
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        
        // Configure the cell...
        cell.clear()
        cell.chooseHandler = self
        cell.setCurrency(currency: currencies[indexPath.row])
        if currencies[indexPath.row].code == selecterCurrency.code {
            cell.initialSelect()
        }
        
        return cell
    }

}
