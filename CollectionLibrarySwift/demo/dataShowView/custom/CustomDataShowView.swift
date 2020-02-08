//
//  CustomDataShowView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation


class CustomDataShowView:BaseDataShowContentView{
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
        
    }
    
    private func commonInit(){
        let showImg=UIImageView.init()
        self.addSubview(showImg)
        showImg.image=UIImage(named: "loading_fail")
        showImg
            .centerX(equalTo: self.yy_centerX)
            .top(equalTo: self.yy_top)
            .height(150)
            .width(150)
            .build()
        
        let showText:UILabel = UILabel()
        showText.textAlignment = .center
        showText.numberOfLines = 0
        showText.textColor = UIColor.gray
        showText.preferredMaxLayoutWidth = UIScreen.main.bounds.width-40
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 10
        
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:16),NSAttributedString.Key.paragraphStyle: paraph]
        let text="数据加载失败"
        showText.attributedText = NSAttributedString(string: text, attributes: attributes)
        self.addSubview(showText)
        
        let height=UILabelUtils.getLabHeigh(labelStr: text, font: UIFont.systemFont(ofSize: 16), width: UIScreen.main.bounds.width-40,lineSpacing: 10)
        
        showText
            .centerX(equalTo: self.yy_centerX)
            .top(equalTo: showImg.yy_bottom,constant: 10)
            .height(height)
            .build()
        
        //需要设置内容局域高度
        _contentHeight=150+10+height
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
