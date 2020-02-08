//
//  TextCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/21.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class TextItem:YYTableViewItem{
    
    var content:String!

}


class TextCell:YYTableViewCell{
    
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
            .top(equalTo: contentView.yy_top, constant: 10)
            .bottom(equalTo: contentView.yy_bottom, constant: 10)
            .left(equalTo: contentView.yy_left, constant: 10)
            .right(equalTo: contentView.yy_right, constant: 10)
            .build()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func cellWillAppear() {
    
        let item = self.item as! TextItem
        titleLab.text=item.content
    }
    
    
}
