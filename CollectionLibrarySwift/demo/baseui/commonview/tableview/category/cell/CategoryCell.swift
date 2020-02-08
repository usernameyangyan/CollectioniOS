//
//  CategoryCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/20.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CategoryItem:YYTableViewItem{
    var title: String!
}

class CategoryCell: YYTableViewCell {
    
    lazy var lineSpear:UIView={
        let lineSpear=UIView.init()
        lineSpear.backgroundColor=UIColor.colorWithHexString("#D2D3D5")
        return lineSpear
    }()
    
    
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
        
        self.contentView.addSubview(lineSpear)
        self.contentView.addSubview(titleLab)
        
        lineSpear.left(equalTo: contentView.yy_left)
            .height(self.bounds.height)
            .width(10).build()
        
        titleLab
            .left(equalTo: lineSpear.yy_right)
            .right(equalTo: contentView.yy_right)
            .centerY(equalTo: contentView.yy_centerY)
            .build()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /// cell即将出现在屏幕中的回调方法 在这个方法里面赋值
    override func cellWillAppear() {
        let item = self.item as! CategoryItem
        titleLab.text = item.title
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            lineSpear.backgroundColor = UIColor.blue
        }else{
            lineSpear.backgroundColor = UIColor.colorWithHexString("#D2D3D5")
        }
        
    }
    
}
