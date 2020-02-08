//
//  ExpanableListCell2.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class ExpanableListItem2:YYExpandTreeCellItem{
    
    override init() {
        super.init()
        cellHeight=40
    }
}

class ExpanableListCell2:YYTableViewCell{
    
    
    lazy var titleLab:UILabel={
        let titleLab=UILabel.init()
        titleLab.numberOfLines=0
        titleLab.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLab.textColor=UIColor.white
        titleLab.font=UIFont.systemFont(ofSize: 14)
        return titleLab
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor=UIColor.green
        self.contentView.addSubview(titleLab)
        
        
        titleLab
            .top(equalTo: contentView.yy_top, constant: 15)
            .bottom(equalTo: contentView.yy_bottom, constant: 15)
            .left(equalTo: contentView.yy_left, constant: 15)
            .right(equalTo: contentView.yy_right, constant: 15)
            .build()
        
        titleLab.text="第二层"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
