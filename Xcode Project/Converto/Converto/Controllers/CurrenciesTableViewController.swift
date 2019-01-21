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
    
    var currencies = Currencies.currencies
    
    var selecterCurrency = Currencies.currencies[0]
    
    var alreadyCalled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alreadyCalled = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let curr = CurrenciesTableViewController.chooseHandler?.currencyToRemove() {
            if let index = currencies.firstIndex(where: {$0.code == curr.code}) {
                currencies.remove(at: index)
            }
        }
        selecterCurrency = CurrenciesTableViewController.chooseHandler?.selectedCurrency() ?? Currencies.currencies[0]
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
        return 80
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
