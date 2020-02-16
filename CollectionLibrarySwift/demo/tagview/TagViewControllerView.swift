//
//  TagViewControllerView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/14.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation


class TagViewControllerView:UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"YYTagView")
            .build()
        
        
        let tags=["测试使用内容","YYTagView","33","西亚","123456","ijklmn","45677","This should be the third tag","人间烟火"]
        
        let tagView=YYTagViewBuilder
            .with()
            .setTagItems(tags)
            .setTagTextFont(textFont: UIFont.systemFont(ofSize: 20))
            .setTagTextColor(color: UIColor.white)
            .setTagAlignment(alignment: .center)
            .setTagBackgroundColor(color: UIColor.systemBlue)
            .setTagSelectedTextColor(color: UIColor.red)
            .setTagSelectedBorderColor(color: UIColor.gray)
            .setTagCornerRadius(cornerRadius: 5)
            .setTagVerticalPadding(padding: 10)
            .setTagHorizontalPadding(padding: 10)
            .setTagVerticalMargin(margin: 10)
            .setTagHorizontalMargin(margin: 10)
            .buildTagView()
        
        
        tagView.setTagClick(tagClick: {
            title,tagView,sender in
            print(title)
        })
        
        self.view.addSubview(tagView)
        
        tagView
            .centerX(equalTo: view.yy_centerX)
            .centerY(equalTo: view.yy_centerY)
            .width(UIScreen.main.bounds.width-30)
            .build()
        
    
        
    }
    
}
