//
//  CreditsViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 29/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    @IBOutlet var labels: [UILabel]!
    
    let links = ["https://www.flaticon.com/", "http://www.freepik.com/", "https://www.flaticon.com/authors/dmitri13", "https://www.flaticon.com/authors/vaadin", "https://github.com/gpbl/SwiftChart", "https://exchangeratesapi.io"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func linkClick(_ sender: Any) {
        if let button = sender as? UIButton {
            print(button.tag)
            guard let url = URL(string: links[button.tag]) else { return }
            UIApplication.shared.open(url)
        }
    }
}
