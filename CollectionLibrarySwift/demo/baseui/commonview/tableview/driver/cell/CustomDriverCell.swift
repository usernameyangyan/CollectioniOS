//
//  CustomDriverCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CustomDriverItem:YYTableViewItem{
    var desc: String!
}

class CustomDriverCell:YYTableViewCell{
    lazy var titleLab:UILabel={
        let titleLab=UILabel.init()
        titleLab.numberOfLines=0
        titleLab.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLab.textAlignment = .center
        titleLab.font=UIFont.systemFont(ofSize: 15)
        return titleLab
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLab)
        
        
        titleLab
            .top(equalTo: contentView.yy_top, constant: 15)
            .bottom(equalTo: contentView.yy_bottom, constant: 15)
            .left(equalTo: contentView.yy_left, constant: 15)
            .right(equalTo: contentView.yy_right, constant: 15)
            .build()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    /// cell即将出现在屏幕中的回调方法 在这个方法里面赋值
    override func cellWillAppear() {
        let item = self.item as! CustomDriverItem
        titleLab.text = item.desc
    }
    
    
    
    override func setCustomLineView(_ width: CGFloat,_ height:CGFloat) -> UIView? {
        let line = UIView()
        line.frame = CGRect(x:0, y: height, width: width, height:1)
        line.backgroundColor = UIColor.colorWithHexString("#FF0000")
        return line
        
    }
    
}
