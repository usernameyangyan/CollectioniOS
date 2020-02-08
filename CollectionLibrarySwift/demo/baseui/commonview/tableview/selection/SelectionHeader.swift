//
//  SelectionHeader.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class SelectionHeader:UIView{
    
    lazy var titleLab:UILabel={
        let titleLab=UILabel.init()
        titleLab.numberOfLines=0
        titleLab.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLab.font=UIFont.systemFont(ofSize: 15)
        return titleLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.colorWithHexString("#D2D3D5")
        self.addSubview(titleLab)
        
        titleLab
            .top(equalTo: self.yy_top, constant: 10)
            .bottom(equalTo: self.yy_bottom, constant: 10)
            .left(equalTo: self.yy_left, constant: 10)
            .right(equalTo: self.yy_right, constant: 10)
            .build()
    }
    
    
    required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
    
    
    func setContent(con:String){
        titleLab.text=con
    }
    
   
    
}
