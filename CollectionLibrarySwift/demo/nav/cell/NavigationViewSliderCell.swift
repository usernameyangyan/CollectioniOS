//
//  NavigationViewSliderCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class NavigationViewSliderItem:YYTableViewItem{
    
    var content:String!
    var vc:UIViewController!
    
    override init() {
        super.init()
        cellHeight=70
    }
}


class NavigationViewSliderCell:YYTableViewCell{
    
    
    lazy var titleLab:UILabel={
        let titleLab=UILabel.init()
        titleLab.font=UIFont.systemFont(ofSize: 15)
        return titleLab
    }()
    
    lazy var slider:UISlider={
        let slider=UISlider.init()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.thumbTintColor = UIColor.blue
        
        slider.addTarget(self, action:#selector(change(_:)), for: UIControl.Event.valueChanged)
        return slider
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(slider)
        
        titleLab
            .left(equalTo: contentView.yy_left,constant: 20)
            .centerY(equalTo: contentView.yy_centerY)
            .height(30)
            .build()
        
        slider
            .right(equalTo: contentView.yy_right,constant: 20)
            .centerY(equalTo: contentView.yy_centerY)
            .width(80)
            .build()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    override func cellDidAppear() {
        let item=self.item as! NavigationViewSliderItem
        titleLab.text=item.content
    }
    
    
    
    @objc func change(_ uiSlider:UISlider){
        let item=self.item as! NavigationViewSliderItem
        
        if(item.indexPath.row==1){
            NavigationUtils
                .with(controller:item.vc)
                .setAlpha(alpha: CGFloat(uiSlider.value))
                .build()
        }
        
    }
    
    
    
    //MARK:自定义底部分割线
    override func draw(_ rect: CGRect) {
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setStrokeColor(UIColor.colorWithHexString("#D2D3D5").cgColor)
        context.stroke(CGRect(x:0, y: rect.size.height, width: rect.size.width, height:1))
    }
    
    
}
