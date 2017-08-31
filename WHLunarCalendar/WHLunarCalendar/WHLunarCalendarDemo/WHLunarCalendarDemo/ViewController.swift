//
//  ViewController.swift
//  WHLunarCalendarDemo
//
//  Created by 김우현 on 2017. 8. 23..
//  Copyright © 2017년 kimwoohyun. All rights reserved.
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
        let cell = collectionView.cellForItem(at: indexPath) as! WHLunarCalendarCell
        
        print(cell.lunarDay!)
        print(cell.solorDay!)
        print(cell.isLeap!)
    }
}
