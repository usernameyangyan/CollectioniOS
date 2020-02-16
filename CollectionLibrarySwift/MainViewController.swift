//
//  MainViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/10/11.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    
    let reuseidentifier:String="collectionView"
    
    var collectionView:UICollectionView?
    var flowLayout:CommonCollectionViewLayout?
    var arrayM:NSMutableArray?
    var itemS:CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("main.home"))
            .hiddenBackBarItem()
            .build()
        
        self.itemS=(UIScreen.main.bounds.size.width - 20)/2
        
        flowLayout = CommonCollectionViewLayout.init(lineSpacing: 10, columnSpacing:10, sectionInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        flowLayout!.delegate=self
        
        self.collectionView=UICollectionView(frame: self.view.frame, collectionViewLayout: self.flowLayout!)
        self.collectionView!.dataSource=self
        self.collectionView!.delegate=self
        
        
        
        //数据组装
        self.arrayM=NSMutableArray()
        self.arrayM!.add(InternationalUtils.getInstance.getString("base_setting"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("commonview_tableview"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("commonview_uicollectionview"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("commonview_navbar"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("autolayout"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tabbar"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("pageview"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("pagemenu"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("refresh"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("imageLoader"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("dialog"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("httputil"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("datashowview"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("tagview"))
        self.arrayM!.add(InternationalUtils.getInstance.getString("mvp"))
        
        //注册cell
        self.collectionView!.register(CommonUICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseidentifier)
        
        
        self.collectionView!.backgroundColor=UIColor.colorWithHexString("#EEE9E9")
        self.view.addSubview(self.collectionView!)
        
    }
    
}


extension MainViewController:UICollectionViewDelegate,UICollectionViewDataSource,CommonCollectionViewLayoutDelegate{
    func columnOfLayout(_ collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func itemHeight(_ collectionView: UICollectionView, layout CommonCollectionViewLayout: CommonCollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return itemS!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayM!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CommonUICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: reuseidentifier, for: indexPath) as? CommonUICollectionViewCell
        
        cell!.layer.cornerRadius=6.0
        cell!.backgroundColor=UIColor.white
        cell!.setValueForCell(content: arrayM!.object(at: indexPath.row)as! String)
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        ColorUtils.clickSelectBgChange(view: cell, selectColor: UIColor.colorWithHexString("#E5E5E5"), unSelectColor: UIColor.white)
        
        switch (indexPath.row) {
        case 0:
            navigationController?.pushViewController(BaseFunctionController(), animated: true)
        case 1:
            navigationController?.pushViewController(TableViewViewListController(), animated: true)
        case 2:
            navigationController?.pushViewController(ScrollListController(), animated: true)
        case 3:
            navigationController?.pushViewController(NavShowViewController(), animated: true)
        case 4:
            navigationController?.pushViewController(AutoLayoutController(), animated: true)
        case 5:
            navigationController?.pushViewController(TabBarListController(), animated: true)
        case 6:
            navigationController?.pushViewController(PageViewController(), animated: true)
        case 7:
            navigationController?.pushViewController(PageMenuController(), animated: true)
        case 8:
            navigationController?.pushViewController(RefreshListViewController(), animated: true)
        case 9:
            navigationController?.pushViewController(ImageLoaderViewController(), animated: true)
        case 10:
            navigationController?.pushViewController(DialogViewController(), animated: true)
        case 11:
            navigationController?.pushViewController(DataManagerViewController(), animated: true)
        case 12:
            navigationController?.pushViewController(DataShowViewController(), animated: true)
        case 13:
            navigationController?.pushViewController(TagViewControllerView(), animated: true)
        case 14:
            navigationController?.pushViewController(MVPUseControllerView(), animated: true)
        default:
            break
        }
        
    }
}
