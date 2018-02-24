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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(calendar.view)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        // TODO: decode delegate
        super.init(coder: aDecoder)
        self.addSubview(calendar.view)
    }
    
    override open func layoutSubviews() {
        calendar.view.frame = self.bounds
    }
}
