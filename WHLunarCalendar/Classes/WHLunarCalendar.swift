//
//  WHLunarCalendar.swift
//  Pods
//
//  Created by 김우현 on 2017. 8. 31..
//
//

import UIKit

@IBDesignable
open class WHLunarCalendar: UIView{
    open var delegate: LunarCalendarDelegate? {
        didSet { calendar.delegate = delegate }
    }
    
    let calendar = LunarCalendarControllerView()
    
    override open func layoutSubviews() {
        calendar.view.frame = self.bounds
        self.addSubview(calendar.view)
    }
}
