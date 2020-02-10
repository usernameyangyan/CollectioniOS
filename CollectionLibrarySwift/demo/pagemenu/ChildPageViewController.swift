//
//  ChildPageViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/2.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class ChildPageViewController:YYIBaseTableViewController{
    
    var arrayM:NSMutableArray?
    var pageMenuVc:PageMenuController?
    
    
    init(pageMenuVc:PageMenuController){
        super.init(nibName: nil, bundle: nil)
        self.pageMenuVc=pageMenuVc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationUtils
            .with(controller: self)
            .setHidden(isHidden: true)
            .build()
        
        self.view.backgroundColor=UIColor.white
        
        tableView.separatorStyle = .none
        
        
        
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        //数据组装
        self.arrayM=NSMutableArray()
        self.arrayM!.add("指示器类型")
        self.arrayM!.add("横线指示器宽度(指定宽度/自适应)")
        self.arrayM!.add("遮罩指示器宽度(指定宽度/自适应)")
        self.arrayM!.add("标题宽度(指定宽度/自适应)")
        self.arrayM!.add("横线指示器位置")
        
        
        for str in arrayM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
            
            item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                self?.cellTapEvent(item: selectItem as! CommonTableItem )
            })
        }
        
        manager.reloadData()
    }
    
    
    
    func cellTapEvent(item: CommonTableItem) {
        switch item.indexPath.row {
        case 0:
            if(pageMenuVc!.changeInStyle){
                pageMenuVc!.changeInStyle=false
                pageMenuVc!.menu!.style=pageMenuVc!.getLineWidthWithLabel()
                
                
            }else{
                pageMenuVc!.changeInStyle=true
                pageMenuVc!.menu!.style=pageMenuVc!.getConverWidth()
            }
            
        case 1:
            if(pageMenuVc!.changeStyle){
                pageMenuVc!.changeStyle=false
                pageMenuVc!.menu!.style=pageMenuVc!.getLineWidthWithLabel()
                
            }else{
                pageMenuVc!.changeStyle=true
                pageMenuVc!.menu!.style=pageMenuVc!.getLineWidthFixed()
            }
        case 2:
            if(pageMenuVc!.changeStyleConver){
                pageMenuVc!.changeStyleConver=false
                pageMenuVc!.menu!.style=pageMenuVc!.getConverWidthFixed()
                
                
            }else{
                pageMenuVc!.changeStyleConver=true
                pageMenuVc!.menu!.style=pageMenuVc!.getConverWidth()
            }
        case 3:
            if(pageMenuVc!.changeLabelStyle){
                pageMenuVc!.changeLabelStyle=false
                pageMenuVc!.menu!.style=pageMenuVc!.getTitleWidth()
                
                
            }else{
                pageMenuVc!.changeLabelStyle=true
                pageMenuVc!.menu!.style=pageMenuVc!.getTitleWidthFixed()
            }
        case 4:
            if(pageMenuVc!.changPosition){
                pageMenuVc!.changPosition=false
                pageMenuVc!.menu!.style=pageMenuVc!.getLineBottom()
                
                
            }else{
                pageMenuVc!.changPosition=true
                pageMenuVc!.menu!.style=pageMenuVc!.getLineTop()
            }
        default :
            break
        }
    }
    
}
