//
//  ErrorViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 23/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(reload))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func reload() {
        StaticClass.exchangeRateReload?.reloadData()
    }

}
