//
//  Extension.swift
//  WHLunarCalendar
//
//  Created by 김우현 on 2017. 8. 24..
//  Copyright © 2017년 kimwoohyun. All rights reserved.
//

import UIKit

extension UIColor {
    class var navy: UIColor {
        return UIColor(red: 34.0 / 255.0, green: 41.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
    }
    class var darkGray: UIColor {
        return UIColor(red: 121.0 / 255.0, green: 121.0 / 255.0, blue: 121.0 / 255.0, alpha: 1.0)
    }
    class var gray: UIColor {
        return UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    }
    class var brightGray: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 251.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
    }
    class var gold: UIColor {
        return UIColor(red: 137.0 / 255.0, green: 103.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0)
    }
}

extension Date {
    func add(day: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: day, to: self)!
    }
    func add(month: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .month, value: month, to: self)!
    }
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
