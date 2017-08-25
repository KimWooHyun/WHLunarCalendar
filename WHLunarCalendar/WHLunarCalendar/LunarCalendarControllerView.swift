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
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width/7, height: view.frame.height/6)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
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
        return cell
    }
}

class WHLunarCalendarCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.brightGray.cgColor
        self.layer.borderWidth = 1.0
        addViews()
    }
    
    func addViews(){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.textAlignment = .center
        label.text = "A"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
