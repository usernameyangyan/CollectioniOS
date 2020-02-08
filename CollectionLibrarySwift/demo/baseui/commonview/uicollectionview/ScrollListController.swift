//
//  ScrollListController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/21.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

class ScrollListController:YYIBaseTableViewController{
    
    var arryM:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("commonview_uicollectionview"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        tableView.separatorStyle = .none
        
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        //数据组装
        self.arryM=NSMutableArray()
        self.arryM!.add(InternationalUtils.getInstance.getString("collectionview_common"))
        self.arryM!.add(InternationalUtils.getInstance.getString("collectionview_header"))
        self.arryM!.add(InternationalUtils.getInstance.getString("scrollview_header"))
        
        for str in arryM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
            
            item.setSelectionHandler(selectHandler: {[weak self](currentItem) in
                 self?.cellTapEvent(item: currentItem as! CommonTableItem )
            })
            
        }
        
        
        
    }
    
    
    func cellTapEvent(item: CommonTableItem) {
        switch item.indexPath.row {
        case 0:
            navigationController?.pushViewController(CommonUICollectionViewController(), animated: true)
        case 1:
             navigationController?.pushViewController(UICollectionViewHeadrController(), animated: true)
        default:
            navigationController?.pushViewController(ScrollViewHeaderViewController(), animated: true)
        }
    }
    
}

