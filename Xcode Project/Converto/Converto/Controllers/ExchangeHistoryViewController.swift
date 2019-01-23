//
//  ExchangeHistoryViewController.swift
//  Converto
//
//  Created by Giovanni Barbiero on 22/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit
import SwiftChart

class ExchangeHistoryViewController: UIViewController, ChartDelegate, DataReloadHandler {

    @IBOutlet var timeButtons: [UIButton]!
    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var errorView: UIView!
    
    var serieData: [Double] = []
    var labels: [Double] = []
    var labelsAsString: Array<String> = []
    
    var historyType : HistoryType = .OneMonth
    
    let dateFormatter = DateFormatter()
    
    var sv : UIView? = nil
    
    var loading = false
    var timeoutTimer : Timeout? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        StaticClass.exchangeRateReload = self
        lblValue.text = ""
        chart.delegate = self
        chart.hideHighlightLineOnTouchEnd = true
        chart.xLabelsTextAlignment = .center
        chart.labelFont = UIFont.init(name: "GillSans", size: 12)
        
        self.view.bringSubviewToFront(errorView)
        errorView.isHidden = true
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        clearChart()
        GetHistory(type: historyType)
        
        
    }
    
    func clearChart() {
        chart.removeAllSeries()
        serieData = []
        labels = []
        labelsAsString = []
        
        chart.yLabelsFormatter = { String(format:"%.2f", $1) + " " + ConvertoViewController.rightCurrency.symbol }
    }
    
    func showError() {
        if loading {
            clearTimeout()
        }
        errorView.isHidden = !loading
        chart.isHidden = loading
        loading = false
        if let spinner = sv {
            UIViewController.removeSpinner(spinner: spinner)
        }
    }
    
    func clearTimeout() {
        timeoutTimer?.cancel()
        timeoutTimer = nil
    }
    
    func parseData(_ data : [Date : Double]) {
        loading = false
        clearTimeout()
        clearChart()
        errorView.isHidden = true
        let dates = data.keys.sorted()
        print("TIPO")
        print(historyType.rawValue)
        var i = 0
        for date in dates {
            serieData.append(data[date]!)
            
            let name = GetLabelName(date: date)
            if (labels.count == 0 || labelsAsString.last! != name) {
                labels.append(Double(i))
                labelsAsString.append(name)
            }
            
            i += 1
        }
        
        let series = ChartSeries(serieData)
        series.area = true
        
        chart.xLabels = labels
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return self.labelsAsString[labelIndex]
        }
        
        chart.minY = serieData.min()! - 0.1
        
        chart.add(series)
        
        if let spinner = sv {
            UIViewController.removeSpinner(spinner: spinner)
        }
    }
    
    func GetLabelName(date: Date) -> String {
        let calendar = Calendar.current
        let dateForm = DateFormatter()
        dateForm.dateFormat = "MMM"
        switch historyType {
        case .OneMonth:
            dateForm.dateFormat = "d/M/yyyy"
            if labels.count == 0 {
                return dateForm.string(from: date)
            }
            return dateForm.string(from: date.previous(.monday, considerToday: true))
        case .SixMonth:
            return dateForm.string(from: date)
        case .OneYear:
            if labels.count == 0 {
                return dateForm.string(from: date)
            }
            let d = dateForm.date(from: labelsAsString.last!)!
            if calendar.component(.month, from: d) == calendar.component(.month, from: calendar.date(byAdding: .month, value: -2, to: date)!) {
                return dateForm.string(from: date)
            }
            return labelsAsString.last!
        case .FiveYears:
            dateForm.dateFormat = "yyyy"
            return dateForm.string(from: date)
        default:
            dateForm.dateFormat = "yyyy"
            if labels.count == 0 {
                return dateForm.string(from: date)
            }
            let d = dateForm.date(from: labelsAsString.last!)!
            if calendar.component(.year, from: date) - calendar.component(.year, from: d) > 1 {
                return dateForm.string(from: date)
            }
            return labelsAsString.last!
        }
    }
    
    func GetHistory(type : HistoryType) {
        loading = true
        timeoutTimer = Timeout(10) {
            self.showError()
        }
        ApiManager.Instance.GetHistory(base: ConvertoViewController.leftCurrency, symbol: ConvertoViewController.rightCurrency, from: GetDate(offset: type), to: Date(), completion: parseData(_:))
    }
    
    func GetDate(offset type: HistoryType) -> Date {
        let now = Calendar.current
        switch type {
        case .OneMonth:
            return now.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        case .SixMonth:
            return now.date(byAdding: .month, value: -6, to: Date()) ?? Date()
        case .OneYear:
            return now.date(byAdding: .year, value: -1, to: Date()) ?? Date()
        case .FiveYears:
            return now.date(byAdding: .year, value: -5, to: Date()) ?? Date()
        default:
            return dateFormatter.date(from: "1999-01-01") ?? Date()
        }
    }
    
    @IBAction func btnTimeClick(_ sender: Any) {
        let btn = sender as! UIButton
        select(button: btn, true)
        deselectOthers(btn)
        chart.isHidden = false
        errorView.isHidden = true
        sv = UIViewController.displaySpinner(onView: chart)
        historyType = HistoryType(rawValue: btn.tag)!
        GetHistory(type: historyType)
    }
    
    private func deselectOthers(_ btn : UIButton) {
        var temp = timeButtons
        temp?.removeAll(where: {$0.tag == btn.tag})
        for x in temp ?? [UIButton]() {
            select(button: x, false)
        }
    }
    
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
            if s.first == Character(",") || s.first == Character(".") {
                s = "0" + s
            }
            lblValue.text = s
            
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        lblValue.text = ""
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        lblValue.text = ""
    }
    
    func reloadData() {
        select(button: timeButtons[0], true)
        deselectOthers(timeButtons[0])
        historyType = .OneMonth
        chart.isHidden = false
        GetHistory(type: historyType)
    }
}
