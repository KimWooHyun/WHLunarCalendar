//
//  LunarCalendarControllerView.swift
//  Pods
//
//  Created by 김우현 on 2017. 8. 31..
//
//
import UIKit

public protocol LunarCalendarDelegate {
    func lunarCalendarCellClick(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

@IBDesignable
open class LunarCalendarControllerView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegate: LunarCalendarDelegate?
    
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
        let month = formatter.string(from: firstDay as Date )
        
        prevButton.layer.backgroundColor = UIColor.brightGray.cgColor
        prevButton.layer.cornerRadius = 18.0
        prevButton.setTitle("<", for: .normal)
        prevButton.setTitleColor(UIColor.darkGray, for: .normal)
        prevButton.contentVerticalAlignment = .center
        prevButton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        prevButton.tag = 1
        prevButton.addTarget(self, action: #selector(changeDay), for: .touchUpInside)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(prevButton)
        
        let pLeading = NSLayoutConstraint(item: prevButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 5)
        let pTop = NSLayoutConstraint(item: prevButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let pWidth = NSLayoutConstraint(item: prevButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
        let pHeight = NSLayoutConstraint(item: prevButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
        self.view.addConstraints([pLeading, pTop, pWidth, pHeight])
        
        
        monthTF.addTarget(self, action: #selector(dateTextInputPressed), for: .touchDown)
        monthTF.text = String(self.thisYear) + "." + month
        monthTF.textAlignment = .center
        monthTF.font = UIFont.systemFont(ofSize: 36)
        monthTF.textColor = UIColor.darkGray
        monthTF.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(monthTF)
        
        let mLeading = NSLayoutConstraint(item: monthTF, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let mTop = NSLayoutConstraint(item: monthTF, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let mWidth = NSLayoutConstraint(item: monthTF, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let mHeight = NSLayoutConstraint(item: monthTF, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 36)
        self.view.addConstraints([mLeading, mTop, mWidth, mHeight])
        
        isLunarButton.layer.borderWidth = 1.0
        isLunarButton.layer.borderColor = UIColor.darkGray.cgColor
        isLunarButton.layer.cornerRadius = 8.0
        isLunarButton.setTitle("음력", for: .normal)
        isLunarButton.setTitleColor(UIColor.darkGray, for: .normal)
        isLunarButton.setTitleColor(UIColor.white, for: .selected)
        isLunarButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        isLunarButton.addTarget(self, action: #selector(isLunarButtonClick), for: .touchUpInside)
        isLunarButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(isLunarButton)
        
        let lLeading = NSLayoutConstraint(item: isLunarButton, attribute: .right, relatedBy: .equal, toItem: self.monthTF, attribute: .right, multiplier: 1, constant: 8)
        let lTop = NSLayoutConstraint(item: isLunarButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 7)
        let lWidth = NSLayoutConstraint(item: isLunarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
        let lHeight = NSLayoutConstraint(item: isLunarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)
        self.view.addConstraints([lLeading, lTop, lWidth, lHeight])
        
        nextButton.layer.backgroundColor = UIColor.brightGray.cgColor
        nextButton.layer.cornerRadius = 18.0
        nextButton.setTitle(" >", for: .normal)
        nextButton.setTitleColor(UIColor.darkGray, for: .normal)
        nextButton.contentVerticalAlignment = .center
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        nextButton.tag = 2
        nextButton.addTarget(self, action: #selector(changeDay), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nextButton)
        
        let nTrailing = NSLayoutConstraint(item: nextButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -5)
        let nTop = NSLayoutConstraint(item: nextButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let nWidth = NSLayoutConstraint(item: nextButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
        let nHeight = NSLayoutConstraint(item: nextButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
        self.view.addConstraints([nTrailing, nTop, nWidth, nHeight])
        
        for (index, week) in weeks.enumerated() {
            let label = UILabel()
            label.text = week
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.darkGray
            label.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(label)
            
            if (index == 0) {
                let weekLeading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
                let weekTop = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: prevButton, attribute: .bottom, multiplier: 1, constant: 10)
                let weekWidth = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width/7)
                let weekHeight = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 14)
                self.view.addConstraints([weekLeading, weekTop, weekWidth, weekHeight])
            }
            else {
                let weekLeading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: (view.frame.width/7) * CGFloat(index))
                let weekTop = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: prevButton, attribute: .bottom, multiplier: 1, constant: 10)
                let weekWidth = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width/7)
                let weekHeight = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 14)
                self.view.addConstraints([weekLeading, weekTop, weekWidth, weekHeight])
            }
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
        cell.solarDay = String(year) + "-" + String(month) + "-" + String(day)
        changeLunar(isSelected: isLunarButton.isSelected, cell: cell, date: date)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.lunarCalendarCellClick(collectionView, didSelectItemAt: indexPath)
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
            cell.lunarDay = String(describing: lunar["year"] as! Int) + "-" + String(describing: lunar["month"] as! Int) + "-" + String(describing: lunar["day"] as! Int)
            cell.isLeap = lunar["isYunMonth"] as! Bool?
        }
        else {
            cell.LunarLabel.text = ""
            cell.isLeap = nil
            cell.lunarDay = nil
        }
    }
    
    @objc func isLunarButtonClick(sender: UIButton!) {
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.3) {
            () -> Void in
            self.isLunarButton.backgroundColor = sender.isSelected ? UIColor.navy : UIColor.clear
            self.view.layoutIfNeeded()
        }
        self.collectionview.reloadData()
    }
    
    @objc func dateTextInputPressed(sender: UITextField) {
        let inputView = UIView(frame: CGRect(x:0, y:0, width: self.view.frame.width, height:240))
        datePickerView.frame = CGRect(x:0, y:40, width: self.view.frame.width, height:200)
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        let doneButton = UIButton(frame: CGRect(x:(self.view.frame.size.width) - 100, y:0, width:100, height: 50))
        doneButton.setTitle("Done", for: UIControl.State.normal)
        doneButton.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        
        inputView.addSubview(datePickerView)
        inputView.addSubview(doneButton)
        sender.inputView = inputView
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let changeDate = sender.date.startOfMonth()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM"
        self.monthTF.text = dateFormatter.string(from: sender.date)
        self.thisMonth = Calendar.current.component(.month, from: changeDate)
        self.thisWeekday = Calendar.current.component(.weekday, from: changeDate)
        self.firstDay = changeDate.add(day: -(thisWeekday - 1))
        self.collectionview.reloadData()
    }
    
    @objc func doneButtonClick(sender:UIButton) {
        handleDatePicker(sender: datePickerView)
        monthTF.resignFirstResponder()
    }
    
    @objc func changeDay(sender: UIButton) {
        var changeDate: Date? = nil
        if (sender.tag == 1) {
            changeDate = self.thisWeekday == 1 ? self.firstDay.add(month: -1).startOfMonth() : self.firstDay.startOfMonth()
        }
        else if (sender.tag == 2){
            changeDate = self.thisWeekday == 1 ? self.firstDay.add(month: 1).startOfMonth() : self.firstDay.add(month: 2).startOfMonth()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM"
        self.monthTF.text = dateFormatter.string(from: changeDate!)
        self.thisMonth = Calendar.current.component(.month, from: changeDate!)
        self.thisWeekday = Calendar.current.component(.weekday, from: changeDate!)
        self.firstDay = (changeDate?.add(day: -(thisWeekday - 1)))!
        self.collectionview.reloadData()
    }
}

open class WHLunarCalendarCell: UICollectionViewCell {
    var DayLabel: UILabel!
    var LunarLabel: UILabel!
    open var lunarDay: String? = nil
    open var solarDay: String? = nil
    open var isLeap: Bool? = nil
    
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
    
    override open var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.navy : UIColor.brightGray
            self.DayLabel.textColor = isSelected ? UIColor.white : UIColor.darkGray
            self.LunarLabel.textColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
