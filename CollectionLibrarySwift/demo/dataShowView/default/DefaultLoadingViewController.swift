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
        
        let imgs=["default_data_show_loading1","default_data_show_loading2","default_data_show_loading3","default_data_show_loading4","default_data_show_loading5","default_data_show_loading6","default_data_show_loading7","default_data_show_loading8","default_data_show_loading10","default_data_show_loading11","default_data_show_loading12"]
        
        let defaultDataShowViewParams=DefaultDataShowViewParams()
        defaultDataShowViewParams
            .setDefaultDataShowViewType(showViewType: .loading)
            .setDefaultLoadingImags(defaultLoadingImags: imgs)
            .build()
        
        dataShowView=YYDataShowView(defaultDataShowViewParams: defaultDataShowViewParams,aboveView: navigation.bar)
        
        dataShowView!.show(parentView: self)
    }
}
