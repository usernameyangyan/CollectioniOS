//
//  PageViewItemSliderCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/1.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class PageViewItemSliderItem:YYTableViewItem{
    var index:Int!
    var pageView:YYPageView!
    
}

class PageViewItemSliderCell:YYTableViewCell{
    
    lazy var slider:UISlider={
        let slider=UISlider.init()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.thumbTintColor = UIColor.systemBlue
        slider.addTarget(self, action:#selector(change(_:)), for: UIControl.Event.valueChanged)
        return slider
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(slider)
        
        
        slider
            .centerX(equalTo: contentView.yy_centerX)
            .centerY(equalTo: contentView.yy_centerY)
            .width(UIScreen.main.bounds.width-40)
            .build()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    
    
    @objc func change(_ uiSlider:UISlider){
        
        let item=self.item as! PageViewItemSliderItem
        
        switch item.index {
        case 0:
            if(item.pageView.transformer?.type == YYPageViewTransformerType.none){
                let newScale = 0.5+CGFloat(uiSlider.value)*0.5 // [0.5 - 1.0]
                item.pageView.itemSize = item.pageView.frame.size.applying(CGAffineTransform(scaleX: newScale, y: newScale))
            }
            
        case 1:
            if(item.pageView.transformer?.type == YYPageViewTransformerType.none){
                item.pageView.interitemSpacing = CGFloat(uiSlider.value) * 20
            }
        case 2:
            item.pageView.pageControl.itemSpacing = 6.0 + CGFloat(uiSlider.value*10.0)
        case 3:
            item.pageView.pageControl.interitemSpacing = 6.0 + CGFloat(uiSlider.value*10.0)
        default:
            break
        }
        
        
    }
    
}
