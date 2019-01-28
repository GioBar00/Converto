//
//  Extensions.swift
//  Converto
//
//  Created by Giovanni Barbiero on 22/01/2019.
//  Copyright © 2019 Giovanni Barbiero. All rights reserved.
//

import UIKit

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
//    subscript (r: Range<Int>) -> String {
//        let start = index(startIndex, offsetBy: r.lowerBound)
//        let end = index(startIndex, offsetBy: r.upperBound)
//        return self[Range(start ..< end)]
//    }
}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        return displaySpinner(onView: onView, style: .whiteLarge, viewColor: UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5))
    }
    
    class func displaySpinnerGray(onView : UIView) -> UIView {
        return displaySpinner(onView: onView, style: .gray, viewColor: UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0))
    }
    
    class func displaySpinner(onView : UIView, style: UIActivityIndicatorView.Style, viewColor : UIColor) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = viewColor
        let ai = UIActivityIndicatorView.init(style: style)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension Date {
    
    static func today() -> Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        var searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1
        if searchWeekdayIndex > 7 {
            searchWeekdayIndex = 1
        }
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex
        
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
    func toWeekDay() -> Weekday {
        let calendar = Calendar(identifier: .gregorian)
        var index = calendar.component(.weekday, from: self) - 1
        if index < 0 {
            index = 6
        }
        let weekdaysenglish = getWeekDaysInEnglish().map { $0.lowercased() }
        let name = weekdaysenglish[index]
        return Weekday(rawValue: name)!
    }
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .Next:
                return .forward
            case .Previous:
                return .backward
            }
        }
    }
}
