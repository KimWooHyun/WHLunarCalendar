//
//  ViewController.swift
//  WHLunarCalendar
//
//  Created by kimwoohyun on 08/31/2017.
//  Copyright (c) 2017 kimwoohyun. All rights reserved.
//

import UIKit
import WHLunarCalendar

class ViewController: UIViewController {
    @IBOutlet weak var lunarCalendar: WHLunarCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lunarCalendar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: LunarCalendarDelegate{
    func lunarCalendarCellClick(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? WHLunarCalendarCell else { return }
        print(cell.solarDay)
        print(cell.lunarDay)    // Optional
        print(cell.isLeap)      // Optional
    }
}
