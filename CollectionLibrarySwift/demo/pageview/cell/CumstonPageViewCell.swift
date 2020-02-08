//
//  CumstonPageViewCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/30.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CumstonPageViewCell:UICollectionViewCell{
    
    open var imageView: UIImageView {
         
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 500))
           self.contentView.addSubview(imageView)
           return imageView
       }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
