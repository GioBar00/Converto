//
//  CurrencyTableViewCell.swift
//  Converto
//
//  Created by Giovanni Barbiero on 21/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCurrencyName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var currency : Currency? = nil
    var chooseHandler : CurrencySelectHandler? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected {
            chooseHandler?.chooseCurrency(currency: currency ?? Currency())
        }
    }
    
    func initialSelect() {
        super.setSelected(true, animated: true)
        accessoryType = .checkmark
        selectionStyle = .none
    }

    func setCurrency(currency c: Currency) {
        currency = c
        loadData()
    }
    
    func loadData() {
        imgFlag.image = currency?.Image() ?? UIImage(named: "unknown") ?? UIImage()
        lblCurrencyName.text = currency?.name ?? "Unknown"
        lblDescription.text = currency?.Description() ?? "Unknown"
    }
    
    func clear() {
        accessoryType = .none
        selectionStyle = .default
    }
}
