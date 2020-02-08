//
//  DefaultLoadingViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/6.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class DefaultLoadingViewController:UIViewController{
    var dataShowView:YYDataShowView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"默认加载数据显示样式(可根据需要修改对应参数)")
            .build()
        
        
        let defaultDataShowViewParams=DefaultDataShowViewParams()
        defaultDataShowViewParams
            .setDefaultDataShowViewType(showViewType: .loading)
            .build()
        
        dataShowView=YYDataShowView(defaultDataShowViewParams: defaultDataShowViewParams,aboveView: navigation.bar)
        
        dataShowView!.show(parentView: self)
    }
}
