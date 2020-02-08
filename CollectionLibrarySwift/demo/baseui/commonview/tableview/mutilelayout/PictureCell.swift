//
//  PictureCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/21.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class PictureItem:YYTableViewItem{
    
    var content:String!
}

class PictureCell:YYTableViewCell{
    
    lazy var img:UIImageView={
        let img=UIImageView.init()
        img.image=UIImage(named: "b")
        img.layer.cornerRadius = 25
        img.layer.masksToBounds = true
        return img
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
        self.contentView.addSubview(img)
        self.contentView.addSubview(titleLab)
        
        img
            .left(equalTo: contentView.yy_left,constant: 10)
            .top(equalTo: contentView.yy_top,constant: 10)
            .width(50)
            .height(50)
            .build()
        
        titleLab
            .left(equalTo: contentView.yy_left,constant: 70)
            .right(equalTo: contentView.yy_right,constant: 10)
            .bottom(equalTo: contentView.yy_bottom,constant: 10)
            .top(equalTo: contentView.yy_top,constant: 10)
            .build()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func cellWillAppear(){
        super.cellDidAppear()
        
        let item=self.item as! PictureItem
        titleLab.text=item.content
    }
    
    
}
