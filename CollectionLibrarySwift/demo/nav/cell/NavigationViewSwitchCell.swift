//
//  NavigationViewCell.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/19.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit


class NavigationViewSwitchItem:YYTableViewItem{
    
    var content:String!
    var vc:UIViewController!
    
    
    override init() {
        super.init()
        cellHeight=70
    }
    
    
}


class NavigationViewSwitchCell:YYTableViewCell{
    
    
    lazy var titleLab:UILabel={
        let titleLab=UILabel.init()
        titleLab.font=UIFont.systemFont(ofSize: 15)
        return titleLab
    }()
    
    lazy var switchBtn:UISwitch={
        let switchBtn=UISwitch.init()
        switchBtn.onTintColor=UIColor.blue
        switchBtn.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        return switchBtn
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(switchBtn)
        
        
        titleLab
            .left(equalTo: contentView.yy_left,constant: 20)
            .centerY(equalTo: contentView.yy_centerY)
            .height(30)
            .build()
        
        
        switchBtn
            .right(equalTo: contentView.yy_right)
            .centerY(equalTo: contentView.yy_centerY)
            .width(70)
            .build()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func cellWillAppear() {
        
        let item=self.item as! NavigationViewSwitchItem
        titleLab.text=item.content
        
    }
    
    
    @objc func switchChanged(_ uiSwitch:UISwitch)
    {
        
        let item=self.item as! NavigationViewSwitchItem
        if uiSwitch.isOn{
            switch item.indexPath.row {
            case 0:
                NavigationUtils
                    .with(controller:item.vc)
                    .setHidden(isHidden: true)
                    .build()
            case 2:
                NavigationUtils
                    .with(controller:item.vc)
                    .setBarBackgroundColor(barTintColor: UIColor.blue)
                    .build()
            case 3:
                NavigationUtils
                    .with(controller:item.vc)
                    .setTitleColor(tintColor: UIColor.white)
                    .build()
            case 4:
                NavigationUtils
                    .with(controller:item.vc)
                    .setBackgroundImage(backgroundImage: UIImage(named: "a"))
                    .build()
            case 5:
                NavigationUtils
                    .with(controller:item.vc)
                    .setShadowHidden(isShadowHidden: true)
                    .build()
            case 6:
                NavigationUtils
                    .with(controller:item.vc)
                    .setTranslucent(isTranslucent: true)
                    .build()
                
            case 7:
                NavigationUtils
                    .with(controller:item.vc)
                    .setTitle(title: "变换的标题")
                    .build()
            case 8:
                NavigationUtils
                    .with(controller:item.vc)
                    .setTitleSize(ofSize: 25)
                    .build()
            case 9:
                let right=UIBarButtonItem(title: "分享", style: UIBarButtonItem.Style.plain, target: self, action: nil)
                let right1=UIBarButtonItem(title: "分享1", style: UIBarButtonItem.Style.plain, target: self, action: nil)
                
                NavigationUtils
                    .with(controller:item.vc)
                    .setRightButtonItems(items: [right,right1])
                    .build()
                
            default:
                let left=UIBarButtonItem(title: "分享", style: UIBarButtonItem.Style.plain, target: self, action: nil)
                let left1=UIBarButtonItem(title: "分享1", style: UIBarButtonItem.Style.plain, target: self, action: nil)
                
                NavigationUtils
                    .with(controller:item.vc)
                    .setLeftButtonItems(items: [left,left1])
                    .build()
            }
            
        }else{
            switch item.indexPath.row {
            case 0:
                NavigationUtils
                    .with(controller:item.vc)
                    .setHidden(isHidden: false)
                    .build()
            case 2:
                NavigationUtils
                    .with(controller:item.vc)
                    .setBarBackgroundColor(barTintColor: UIColor.red)
                    .build()
            case 3:
                NavigationUtils
                    .with(controller:item.vc)
                    .setTitleColor(tintColor: UIColor.black)
                    .build()
            case 4:
                NavigationUtils
                    .with(controller:item.vc)
                    .setBackgroundImage(backgroundImage: nil)
                    .build()
            case 5:
                NavigationUtils
                    .with(controller:item.vc)
                    .setShadowHidden(isShadowHidden: false)
                    .build()
                
            case 6:
                NavigationUtils
                    .with(controller:item.vc)
                    .setTranslucent(isTranslucent: false)
                    .build()
            case 7:
                NavigationUtils
                    .with(controller:item.vc)
                    .setTitle(title: InternationalUtils.getInstance.getString("nav_use"))
                    .build()
                
            case 8:
                NavigationUtils
                    .with(controller:item.vc)
                    .setTitleSize(ofSize: 19)
                    .build()
                
            case 9:
                
                NavigationUtils
                    .with(controller:item.vc)
                    .setRightButtonItems(items: [])
                    .build()
            default:
                
                NavigationUtils
                    .with(controller:item.vc )
                    .setLeftButtonItems(items: [])
                    .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
                    .build()
            }
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
