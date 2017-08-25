//
//  LunarCalendarCollectionView.swift
//  WHLunarCalendar
//
//  Created by 김우현 on 2017. 8. 24..
//  Copyright © 2017년 kimwoohyun. All rights reserved.
//

import UIKit

@IBDesignable
open class LunarCalendarControllerView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionview: UICollectionView!
    var cellId = "Cell"
    var fitstDay = Date().startOfMonth()
    let thisYear = Calendar.current.component(.year, from: Date().startOfMonth())
    let thisMonth = Calendar.current.component(.month, from: Date().startOfMonth())
    let thisWeekday = Calendar.current.component(.weekday, from: Date().startOfMonth())
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        fitstDay = fitstDay.add(day: -(thisWeekday - 1))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        label.text = String(self.thisYear) + "년 " + String(self.thisMonth) + "월"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width/7, height: (view.frame.height - 20)/6)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionview = UICollectionView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 20), collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(WHLunarCalendarCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    
    public func collectionView(_ cellForItemAtcollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! WHLunarCalendarCell
        
        let date = fitstDay.add(day: indexPath.row)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        if (thisMonth != month) {
            cell.isUserInteractionEnabled = false
            cell.alpha = 0.5
        }
        else {
            cell.isUserInteractionEnabled = true
            cell.alpha = 1.0
        }
        cell.DayLabel.text = String(day)
        return cell
    }
}

class WHLunarCalendarCell: UICollectionViewCell {
    var DayLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.layer.backgroundColor = UIColor.brightGray.cgColor
        addViews()
    }
    
    func addViews(){
        DayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: 20))
        DayLabel.textAlignment = .right
        DayLabel.font = UIFont.systemFont(ofSize: 14)
        DayLabel.textColor = UIColor.darkGray
        DayLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(DayLabel)
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.navy : UIColor.brightGray
            self.DayLabel.textColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
