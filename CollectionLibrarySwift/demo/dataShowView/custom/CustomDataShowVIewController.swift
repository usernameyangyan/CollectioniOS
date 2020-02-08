//
//  CustomDataShowVIewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/6.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class CustomDataShowVIewController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"自定义加载显示样式")
            .build()
        
        let customView=CustomDataShowView()
        YYDataShowView.init(custom: customView,aboveView: navigation.bar).show(parentView: self)
    }
}
