//
//  ConvertoViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 15/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class ConvertoViewController: UIViewController {

    @IBOutlet weak var btnCurrencyLeft: UIButton!
    @IBOutlet weak var btnCurrencyRight: UIButton!
    @IBOutlet weak var btnExchange: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnExchange.imageView?.contentMode = .scaleAspectFit
        btnCurrencyLeft.imageView?.contentMode = .scaleAspectFit
        btnCurrencyRight.imageView?.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
    }    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
