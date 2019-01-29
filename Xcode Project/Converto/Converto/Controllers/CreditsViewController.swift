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
    
    let authors = ["Freepik", "Dmitri13", "Freepik", "Vaadin", "SwiftChart", "ExchangeRatesAPI"]
    let links = ["http://www.freepik.com/", "https://www.flaticon.com/authors/dmitri13", "http://www.freepik.com/", "https://www.flaticon.com/authors/vaadin", "https://github.com/gpbl/SwiftChart", "https://exchangeratesapi.io"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstPartIcon = "Icon made by "
        let secondPartIcon = " from www.flaticon.com"
        var attributedString : NSMutableAttributedString
        var tap : UITapGestureRecognizer
        for i in 0...5 {
            tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
            labels[i].addGestureRecognizer(tap)
            
            switch labels[i].tag {
            case 5:
                attributedString = NSMutableAttributedString(string:"Chart powered by " + authors[4])
                break
            case 6:
                attributedString = NSMutableAttributedString(string:"Api powered by " + authors[5])
                break
            default:
                attributedString = NSMutableAttributedString(string:firstPartIcon + authors[i] + secondPartIcon)
                _ = attributedString.setAsLink(textToFind: "www.flaticon.com", linkURL: "http://www.flaticon.com/")
            }
            _ = attributedString.setAsLink(textToFind: authors[i], linkURL: links[i])
            labels[i].attributedText = attributedString
        }
    }

    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let label = gesture.view as! UILabel
        print(label.tag)
        let authorLinkRange = (label.text! as NSString).range(of: authors[label.tag - 1])
        if gesture.didTapAttributedTextInLabel(label: labels[label.tag - 1], inRange: authorLinkRange) {
            print("AUTORE")
            UIApplication.shared.open(URL(string: links[label.tag - 1])!, options: [:])
            return
        }
        if label.tag < 5 {
            let flatLink = (label.text! as NSString).range(of: "www.flaticon.com")
            if gesture.didTapAttributedTextInLabel(label: labels[label.tag - 1], inRange: flatLink) {
                print("FLAT")
                UIApplication.shared.open(URL(string: "http://www.flaticon.com/")!, options: [:])
                return
            }
        }
    }
}
