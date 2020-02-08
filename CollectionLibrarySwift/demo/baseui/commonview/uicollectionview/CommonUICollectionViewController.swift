//
//  UseUICollectionViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/11/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CommonUICollectionViewController:UIViewController{
    
    let reuseidentifier:String="useUICollectionView"
    
    var collectionView:UICollectionView?
    var flowLayout:CommonCollectionViewLayout?
    var arrayM:NSMutableArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("collectionview_common"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        
        flowLayout = CommonCollectionViewLayout.init(lineSpacing: 10, columnSpacing:10, sectionInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        flowLayout!.delegate=self
        
        flowLayout?.estimatedItemSize=CGSize(width: 200, height: 150)
        
        collectionView=UICollectionView(frame: self.view.frame, collectionViewLayout: self.flowLayout!)
        collectionView!.dataSource=self
        self.collectionView!.delegate=self
        
        
        
        
        //数据组装
        arrayM=NSMutableArray()
        
        for i in 0..<50 {
            arrayM!.add(String.init(format: "测试使用%d", i))
        }
        
        
        //注册cell
        self.collectionView!.register(CommonUICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseidentifier)
        
        
        
        self.collectionView!.backgroundColor=UIColor.colorWithHexString("#EEE9E9")
        self.view.addSubview(self.collectionView!)
        
    }
    
}



extension CommonUICollectionViewController:CommonCollectionViewLayoutDelegate,UICollectionViewDelegate, UICollectionViewDataSource{
    func columnOfLayout(_ collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func itemHeight(_ collectionView: UICollectionView, layout commonCollectionViewLayout: CommonCollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row%2==0){
            return 200
        }else{
            return 150
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayM!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CommonUICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: reuseidentifier, for: indexPath) as? CommonUICollectionViewCell
        
        cell!.setValueForCell(content: arrayM!.object(at: indexPath.row) as! String)
        cell!.layer.cornerRadius=6.0
        cell!.backgroundColor=UIColor.white
        
        
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        ColorUtils.clickSelectBgChange(view: cell, selectColor: UIColor.colorWithHexString("#E5E5E5"), unSelectColor: UIColor.white)
    }
    
}


