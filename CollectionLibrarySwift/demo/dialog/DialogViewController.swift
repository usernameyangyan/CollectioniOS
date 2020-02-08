//
//  DialogViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/9.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class DialogViewController:YYIBaseTableViewController{
    
    var arrayM:NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: InternationalUtils.getInstance.getString("dialog"))
            .build()
        
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        
        //数据组装
        self.arrayM=NSMutableArray()
        arrayM?.add("默认提示框样式")
        arrayM?.add("默认提示框样式(参数自定义)")
        arrayM?.add("自定义提示框样式")
        arrayM?.add("YYToast的使用")
        arrayM?.add("默认加载框样式")
        arrayM?.add("自定义加载框样式")
        
        for str in arrayM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
            
            item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                self?.cellTapEvent(item: selectItem as! CommonTableItem )
            })
        }
        
        
        
    }
    
    
    func cellTapEvent(item: CommonTableItem) {
        switch item.indexPath.row {
        case 0:
            YYDialog
                .createAlertDialog()
                .defalutDialog()
                .setButtonType(btnType: .sbumit)
                .show(title: "提示", message: "因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。")
            
        case 1:
            YYDialog
                .createAlertDialog()
                .defalutDialog()
                .setTitleColor(color: UIColor.red)
                .setTitleSize(ofSize: 20)
                .setContentColor(color: UIColor.gray)
                .setSubmitBtnSize(ofSize: 20)
                .setSubmitBtnContentColor(color: UIColor.green)
                .setAnimationOption(animationOption: .zoom)
                .setSubmitButtonListener(clickSubmitBlock: {
                    _ in
                    YYDialog
                        .createToast()
                        .show(view: self.view, text: "点击了确定按钮")
                })
                .setButtonType(btnType: .both)
                .show(title: "提示", message: "因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。")
        case 2:
            YYDialog
                .createAlertDialog()
                .customDialog(custom: CustomAlertDialog())
                .setMaskLayer(showMaskLayer: true)
                .show()
            
        case 3:
            
            YYDialog
                .createToast()
                .show(view: self.view, text: "因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。")
            
        case 4:
            let dialog = YYDialog
                .createLoadingDialog()
                .defalutDialog()
            
            dialog
                .setMessageSize(fontSize: 16)
                .setContentViewCornerRadius(radius: 5)
                .setMaskLayer(showMaskLayer: true)
                .setAnimationOption(animationOption: .zoom)
                .show(message: "请稍后...")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
                dialog.dismiss()
            }
            
        case 5:
            
            let dialog=YYDialog
                .createLoadingDialog()
                .customDialog(custom: CustomLoadingDialog())
            
            dialog.show()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
                dialog.dismiss()
            }
            
        default:
            break
        }
    }
}
