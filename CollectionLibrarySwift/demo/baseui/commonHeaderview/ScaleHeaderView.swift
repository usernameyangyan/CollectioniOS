//
//  ScaleHeaderView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/21.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class ScaleHeaderView:YYStretchyHeaderView{
    
    lazy var backgroundImageView:UIImageView={
        let backgroundImageView=UIImageView.init()
        backgroundImageView.image=UIImage(named: "a")
        return backgroundImageView
    }()
    
    lazy var userImageView:UIImageView={
        let userImageView=UIImageView()
        userImageView.image=UIImage(named: "b")
        userImageView.layer.cornerRadius = 50
        userImageView.layer.masksToBounds = true
        return userImageView
    }()
    
    lazy var userNameLabel:UILabel={
        let userNameLabel=UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        userNameLabel.text="YoungManSter"
        return userNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    fileprivate func initView(){
        self.contentView.addSubview(backgroundImageView)
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(userNameLabel)
        
        backgroundImageView
            .top(equalTo: self.contentView.yy_top)
            .left(equalTo: self.contentView.yy_left)
            .right(equalTo: self.contentView.yy_right)
            .bottom(equalTo: self.contentView.yy_bottom)
            .build()
        
        userImageView
            .centerX(equalTo: contentView.yy_centerX)
            .centerY(equalTo: contentView.yy_centerY,constant: -30)
            .width(100)
            .height(100)
            .build()
        
        userNameLabel
            .top(equalTo: userImageView.yy_bottom,constant: 10)
            .centerX(equalTo: userImageView.yy_centerX)
            .build()
        
        
        self.maximumContentHeight=300
        
    }
    
    
}
