//
//  ExchangeHistoryViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 22/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit
import SwiftChart

class ExchangeHistoryViewController: UIViewController, ChartDelegate {

    @IBOutlet var timeButtons: [UIButton]!
    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var lblValue: UILabel!
    //METTERE COME VALORE SEMPRE QUELLO DEL GIORNO PRIMA COME PRIMO VALORE
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblValue.text = ""
        chart.delegate = self
        
        chart.removeAllSeries()
        
        var serieData: [Double] = [0.6, 1.0, 1.3, 1.2, 1.5, 2.0]
        var labels: [Double] = [0, 1, 2, 3, 4]
        var labelsAsString: Array<String> = ["Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì"]
        
        // Date formatter to retrieve the month names
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        
        let series = ChartSeries(serieData)
        series.area = true
        
        // Configure chart layout
        
        //chart.lineWidth = 0.5
        chart.labelFont = UIFont.init(name: "GillSans", size: 12)
        chart.xLabels = labels
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return labelsAsString[labelIndex]
        }
        chart.xLabelsTextAlignment = .center
        //chart.yLabelsOnRightSide = true
        // Add some padding above the x-axis
        //chart.minY = serieData.min()! - 5
        chart.minY = 0
        
        chart.add(series)
    }

    @IBAction func btnTimeClick(_ sender: Any) {
        let btn = sender as! UIButton
        select(button: btn, true)
        deselectOthers(btn)
    }
    
    private func deselectOthers(_ btn : UIButton) {
        var temp = timeButtons
        temp?.removeAll(where: {$0.tag == btn.tag})
        for x in temp ?? [UIButton]() {
            select(button: x, false)
        }
    }
    
//    private func select(button btn: UIButton) {
//        let color1 = btn.backgroundColor
//        btn.backgroundColor = btn.titleLabel?.textColor
//        btn.titleLabel?.textColor = color1
//    }
    
    private func select(button btn: UIButton, _ bool : Bool) {
        btn.backgroundColor = bool ? UIColor(red: 37/255, green: 65/255, blue: 178/255, alpha: 1) : UIColor.white
        btn.setTitleColor(bool ? UIColor.white : UIColor(red: 37/255, green: 65/255, blue: 178/255, alpha: 1), for: .normal)
    }
    
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        if let value = chart.valueForSeries(0, atIndex: indexes[0]) {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 5
            var s : String = numberFormatter.string(from: NSNumber(value: value))!
            if s.first == Character(",") {
                s = "0" + s
            }
            lblValue.text = s
            
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        lblValue.text = ""
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
}
