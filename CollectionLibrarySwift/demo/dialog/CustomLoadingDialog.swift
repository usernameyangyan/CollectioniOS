//
//  CustomLoadingDialog.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/13.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class CustomLoadingDialog:BaseDialogContentView{
    
    lazy var img:UIImageView={
        let img=UIImageView.init()
        img.image = UIImage(named: "loading15")
        return img
    }()
    
    lazy var labelMessage:UILabel={
        let labelMessage = UILabel.init()
        labelMessage.textColor = UIColor.white
        labelMessage.textAlignment = .center
        labelMessage.numberOfLines = 0
        labelMessage.text="正在加载中..."
        labelMessage.font = UIFont.systemFont(ofSize: 16)
        
        return labelMessage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _contentWidth=150
        _contentHeight=150
        
        labelMessage.preferredMaxLayoutWidth = _contentWidth-10
        
        
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        self.layer.cornerRadius  = 10
        self.layer.masksToBounds = true
        
        self.addSubview(img)
        self.addSubview(labelMessage)
        
        self.frame=CGRect(x: frame.origin.x, y:frame.origin.y, width: _contentWidth, height:_contentHeight)
        self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        
        
        img
            .centerX(equalTo: self.yy_centerX)
            .centerY(equalTo: self.yy_centerY,constant: -20)
            .width(30)
            .height(30)
            .build()
        
        
        labelMessage
            .centerX(equalTo: self.yy_centerX)
            .top(equalTo: self.img.yy_bottom)
            .height(50)
            .build()
        
        let images = (0...29).map{return $0 < 10 ? "loading0\($0)" : "loading\($0)"}
        self.img.animationDuration = 2.0
        self.img.animationRepeatCount = 0
        self.img.animationImages = images.map{return UIImage(named:$0)!}
        self.img.startAnimating()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dimiss() {
        super.dimiss()
        self.img.stopAnimating()
    }
    
}
