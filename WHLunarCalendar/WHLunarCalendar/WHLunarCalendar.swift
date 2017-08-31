//
//  WHLunarCalendar.swift
//  WHLunarCalendar
//
//  Created by 김우현 on 2017. 8. 23..
//  Copyright © 2017년 kimwoohyun. All rights reserved.
//

import UIKit

@IBDesignable
open class WHLunarCalendar: UIView{
    open var delegate: LunarCalendarDelegate?
    let calendar = LunarCalendarControllerView()
    
    override open func layoutSubviews() {
        calendar.view.frame = self.bounds
        self.addSubview(calendar.view)
        calendar.delegate = delegate
    }
}
