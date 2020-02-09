//
//  DefaultNoNetWorkViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class DefaultNoNetWorkViewController:UIViewController{
    var dataShowView:YYDataShowView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"默认没有网络加载显示样式(可根据需要修改对应参数)")
            .build()
       
        
        let defaultDataShowViewParams=DefaultDataShowViewParams()
        defaultDataShowViewParams
            .setDefaultDataShowViewType(showViewType: .noNetWork)
            .setDefaultNoNetworkShowImg(defaultNoNetworkShowImg: "nonetwork")
            .build()
        
        dataShowView=YYDataShowView(defaultDataShowViewParams: defaultDataShowViewParams,aboveView: navigation.bar,reloadHandler: {
            YYDialog.createToast().show(view: self.view, text: "点击重新加载按钮")
        })
        
        dataShowView!.show(parentView: self)
    }
}
