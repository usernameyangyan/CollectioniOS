//
//  UseUICollectionViewCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/11/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CommonUICollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLab)
    }
    
    
    lazy var titleLab:UILabel={
        let titleLab=UILabel.init()
        titleLab.numberOfLines=0
        titleLab.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLab.font=UIFont.systemFont(ofSize: 15)
        titleLab.textAlignment = .center
        
        return titleLab
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setValueForCell(content:String){
        
        self.titleLab.text=content
        self .titleLab.frame=CGRect(x: 10, y: 0, width: self.bounds.size.width-20, height: self.bounds.size.height)
    }
    
}
