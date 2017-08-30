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
    var firstDay = Date().startOfMonth()
    let weeks = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    let thisYear = Calendar.current.component(.year, from: Date().startOfMonth())
    var thisMonth = Calendar.current.component(.month, from: Date().startOfMonth())
    var thisWeekday = Calendar.current.component(.weekday, from: Date().startOfMonth())
    let isLunarButton = UIButton(type: .custom)
    let prevButton = UIButton(type: .custom)
    let nextButton = UIButton(type: .custom)
    let monthTF = UITextField()
    var datePickerView = UIDatePicker()
    
    override open func viewWillAppear(_ animated: Bool) {
        firstDay = firstDay.add(day: -(thisWeekday - 1))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let month = formatter.string(from: firstDay.add(month: 1) as Date )
        
        monthTF.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 36)
        monthTF.addTarget(self, action: #selector(dateTextInputPressed), for: .touchDown)
        monthTF.text = String(self.thisYear) + "." + month
        monthTF.textAlignment = .center
        monthTF.font = UIFont.systemFont(ofSize: 36)
        monthTF.textColor = UIColor.darkGray
        monthTF.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(monthTF)
        
        isLunarButton.frame = CGRect(x: 270, y: 8, width: 35, height: 25)
        isLunarButton.layer.borderWidth = 1.0
        isLunarButton.layer.borderColor = UIColor.darkGray.cgColor
        isLunarButton.layer.cornerRadius = 8.0
        isLunarButton.setTitle("음력", for: .normal)
        isLunarButton.setTitleColor(UIColor.darkGray, for: .normal)
        isLunarButton.setTitleColor(UIColor.white, for: .selected)
        isLunarButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        isLunarButton.addTarget(self, action: #selector(isLunarButtonClick), for: .touchUpInside)
        self.view.addSubview(isLunarButton)
        
        prevButton.frame = CGRect(x: 5, y: 0, width: 35, height: 35)
        prevButton.layer.backgroundColor = UIColor.brightGray.cgColor
        prevButton.layer.cornerRadius = 18.0
        prevButton.setTitle("<", for: .normal)
        prevButton.setTitleColor(UIColor.darkGray, for: .normal)
        prevButton.contentVerticalAlignment = .top
        prevButton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        prevButton.tag = 1
        prevButton.addTarget(self, action: #selector(changeDay), for: .touchUpInside)
        self.view.addSubview(prevButton)
        
        nextButton.frame = CGRect(x: view.frame.width - 40, y: 0, width: 35, height: 35)
        nextButton.layer.backgroundColor = UIColor.brightGray.cgColor
        nextButton.layer.cornerRadius = 18.0
        nextButton.setTitle(" >", for: .normal)
        nextButton.setTitleColor(UIColor.darkGray, for: .normal)
        nextButton.contentVerticalAlignment = .top
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        nextButton.tag = 2
        nextButton.addTarget(self, action: #selector(changeDay), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        for (index, week) in weeks.enumerated() {
            let label = UILabel(frame: CGRect(x: (view.frame.width/7) * CGFloat(index), y: 46, width: view.frame.width/7, height: 14))
            label.text = week
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.darkGray
            label.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(label)
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width/7, height: (view.frame.height - 70)/6)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionview = UICollectionView(frame: CGRect(x: 0, y: 70, width: view.frame.width, height: view.frame.height - 70), collectionViewLayout: layout)
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
        
        let date = firstDay.add(day: indexPath.row)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        if (thisMonth != month) {
            cell.isUserInteractionEnabled = false
            cell.alpha = 0.2
        }
        else {
            cell.isUserInteractionEnabled = true
            cell.alpha = 1.0
        }
        cell.DayLabel.text = String(day)
        changeLunar(isSelected: isLunarButton.isSelected, cell: cell, date: date)
        
        return cell
    }
    
    func changeLunar (isSelected: Bool, cell: WHLunarCalendarCell, date: Date) {
        if (isSelected) {
            let lunar = Lunar().solar2lunar(solar_date: date)
            if(lunar["isYunMonth"] as! Bool) {
                cell.LunarLabel.text = "윤 " + String(describing: lunar["month"] as! Int) + "." + String(describing: lunar["day"] as! Int)
            }
            else {
                cell.LunarLabel.text = "음 " + String(describing: lunar["month"] as! Int) + "." + String(describing: lunar["day"] as! Int)
            }
        }
        else {
            cell.LunarLabel.text = ""
        }
    }
    
    func isLunarButtonClick(sender: UIButton!) {
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.3) {
            () -> Void in
            self.isLunarButton.backgroundColor = sender.isSelected ? UIColor.navy : UIColor.clear
            self.view.layoutIfNeeded()
        }
        self.collectionview.reloadData()
    }
    
    func dateTextInputPressed(sender: UITextField) {
        let inputView = UIView(frame: CGRect(x:0, y:0, width: self.view.frame.width, height:240))
        datePickerView.frame = CGRect(x:0, y:40, width: self.view.frame.width, height:200)
        datePickerView.datePickerMode = UIDatePickerMode.date

        let doneButton = UIButton(frame: CGRect(x:(self.view.frame.size.width) - 100, y:0, width:100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        
        inputView.addSubview(datePickerView)
        inputView.addSubview(doneButton)
        sender.inputView = inputView
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let changeDate = sender.date.startOfMonth()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM"
        self.monthTF.text = dateFormatter.string(from: sender.date)
        self.thisMonth = Calendar.current.component(.month, from: changeDate)
        self.thisWeekday = Calendar.current.component(.weekday, from: changeDate)
        self.firstDay = changeDate.add(day: -(thisWeekday - 1))
        self.collectionview.reloadData()
    }
    
    func doneButtonClick(sender:UIButton) {
        handleDatePicker(sender: datePickerView)
        monthTF.resignFirstResponder()
    }
    
    func changeDay(sender: UIButton) {
        var changeDate: Date? = nil
        if (sender.tag == 1) {
            changeDate = self.thisWeekday == 1 ? self.firstDay.add(month: -1).startOfMonth() : self.firstDay.startOfMonth()
        }
        else if (sender.tag == 2){
            changeDate = self.firstDay.add(month: 2).startOfMonth()
        }
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM"
        self.monthTF.text = dateFormatter.string(from: changeDate!)
        self.thisMonth = Calendar.current.component(.month, from: changeDate!)
        self.thisWeekday = Calendar.current.component(.weekday, from: changeDate!)
        self.firstDay = (changeDate?.add(day: -(thisWeekday - 1)))!
        self.collectionview.reloadData()
    }
}

class WHLunarCalendarCell: UICollectionViewCell {
    var DayLabel: UILabel!
    var LunarLabel: UILabel!
    var lunarDay: String? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.layer.backgroundColor = UIColor.brightGray.cgColor
        addViews()
    }
    
    func addViews(){
        DayLabel = UILabel(frame: CGRect(x: -6, y: 28, width: frame.width, height: 20))
        DayLabel.textAlignment = .right
        DayLabel.font = UIFont.systemFont(ofSize: 20)
        DayLabel.textColor = UIColor.darkGray
        DayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        LunarLabel = UILabel(frame: CGRect(x: 5, y: 2, width: frame.width, height: 20))
        LunarLabel.textAlignment = .left
        LunarLabel.font = UIFont.systemFont(ofSize: 10)
        LunarLabel.textColor = UIColor.darkGray
        LunarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(DayLabel)
        addSubview(LunarLabel)
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.navy : UIColor.brightGray
            self.DayLabel.textColor = isSelected ? UIColor.white : UIColor.darkGray
            self.LunarLabel.textColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
