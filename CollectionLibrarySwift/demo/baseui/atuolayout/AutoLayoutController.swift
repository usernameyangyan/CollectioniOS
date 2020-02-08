//
//  AutoLayoutController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/21.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class AutoLayoutController:UIViewController{
    
    
    lazy var centerLabel:UILabel={
        let centerLabel=UILabel.init()
        centerLabel.text="中间按钮"
        centerLabel.textAlignment = .center
        centerLabel.backgroundColor=UIColor.lightGray
        return centerLabel
    }()
    
    lazy var leftLabel:UILabel={
        let leftLabel=UILabel.init()
        leftLabel.text="左边按钮"
        leftLabel.textAlignment = .center
        leftLabel.backgroundColor=UIColor.lightGray
        return leftLabel
    }()
    
    lazy var rightLabel:UILabel={
        let rightLabel=UILabel.init()
        rightLabel.text="右边按钮"
        rightLabel.textAlignment = .center
        rightLabel.backgroundColor=UIColor.lightGray
        return rightLabel
    }()
    
    lazy var topLabel:UILabel={
        let topLabel=UILabel.init()
        topLabel.text="上边按钮"
        topLabel.textAlignment = .center
        topLabel.backgroundColor=UIColor.lightGray
        return topLabel
    }()
    
    lazy var bottomLabel:UILabel={
        let bottomLabel=UILabel.init()
        bottomLabel.text="下边按钮"
        bottomLabel.textAlignment = .center
        bottomLabel.backgroundColor=UIColor.lightGray
        return bottomLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("autolayout"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        self.view.addSubview(centerLabel)
        self.view.addSubview(topLabel)
        self.view.addSubview(bottomLabel)
        self.view.addSubview(leftLabel)
        self.view.addSubview(rightLabel)
        
        centerLabel
            .centerX(equalTo: view.yy_centerX)
            .centerY(equalTo: view.yy_centerY)
            .width(80)
            .height(40)
            .build()
        
        topLabel
            .bottom(equalTo: centerLabel.yy_top,constant: 20)
            .centerX(equalTo: centerLabel.yy_centerX)
            .width(80)
            .height(40)
            .build()
        
        bottomLabel
            .top(equalTo: centerLabel.yy_bottom,constant: 20)
            .centerX(equalTo: centerLabel.yy_centerX)
            .width(80)
            .height(40)
            .build()
        
        rightLabel
            .left(equalTo: centerLabel.yy_right,constant: 20)
            .centerY(equalTo: centerLabel.yy_centerY)
            .width(80)
            .height(40)
            .build()
        
        leftLabel
            .trailing(equalTo: centerLabel.yy_leading,constant: 20)
            .centerY(equalTo: centerLabel.yy_centerY)
            .width(80)
            .height(40)
            .build()
        
    }
}
