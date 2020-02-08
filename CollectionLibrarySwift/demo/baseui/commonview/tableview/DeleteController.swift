//
//  DeleteController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/21.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class DeleteController:YYIBaseTableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("tableview_delete"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
    
        
        tableView.separatorStyle = .none
        
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        for _ in 0 ..< 20 {
            let item = CommonTableItem()
            item.desc="左滑可删除item"
            item.editingStyle = .delete
            section.add(item: item)
            
            
            item.setDeletionHandler(deletionHandler: { [weak self] (item) in
                self?.deleteConfirm(item: item as! CommonTableItem)
            })
        }
                
    }
    
    func deleteConfirm(item: CommonTableItem, needConfirm: Bool = true) {
        if !needConfirm {
            print(item.cellTitle ?? "")
            item.delete()
            return
        }
        
        let alertVC = UIAlertController(title: "Confirmation", message: "Are you sure to delete", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            item.delete(.fade)
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
}
