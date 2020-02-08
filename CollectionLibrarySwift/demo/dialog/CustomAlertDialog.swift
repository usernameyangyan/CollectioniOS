//
//  CustomDialog.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/10.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class CustomAlertDialog:BaseDialogContentView{
    
    fileprivate let img:UIImageView={
        let img=UIImageView.init()
        img.image=UIImage(named: "thumb")
        
        return img
    }()
    
    fileprivate let labelMessage:UILabel={
        let labelMessage = UILabel.init()
        labelMessage.textColor = UIColor.systemRed
        labelMessage.textAlignment = .center
        labelMessage.numberOfLines = 0
        labelMessage.font = UIFont.systemFont(ofSize: 16)
        
        return labelMessage
    }()
    

    fileprivate let okBtn:UIButton={
       let okBtn = UIButton(type: .custom)
        okBtn.setTitle("OK", for: .normal)
        okBtn.setTitleColor(UIColor.white, for: .normal)
        okBtn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        okBtn.backgroundColor=UIColor.systemBlue
        okBtn.layer.cornerRadius=5
        okBtn.addTarget(self, action: #selector(submitBtn(sender:)), for: .touchUpInside)
        
        return okBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _contentHeight=200
        _contentWidth=UIScreen.main.bounds.width-40
        animationOption = .topToCenter
        self.layer.cornerRadius=10
        self.layer.masksToBounds=true

        
        self.backgroundColor=UIColor.white
        self.addSubview(img)
        self.addSubview(labelMessage)
        self.addSubview(okBtn)

    
        img
            .top(equalTo: self.yy_top,constant: 15)
            .width(50)
            .height(50)
            .centerX(equalTo: self.yy_centerX)
            .build()
        

        labelMessage
            .top(equalTo: img.yy_bottom,constant: 20)
            .width(_contentWidth-40)
            .centerX(equalTo: self.yy_centerX)
            .build()
        
        okBtn
            .bottom(equalTo: self.yy_bottom,constant: 5)
            .centerX(equalTo: self.yy_centerX)
            .width(80)
            .height(30)
            .build()
        
        labelMessage.text = "因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。"
        labelMessage.sizeToFit()
    
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func submitBtn(sender:UIButton){
        dimiss()
    }
}
