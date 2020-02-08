//
//  PageMenuController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/2.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class PageMenuController:UIViewController{
    
    
    
    let titles = ["头条", "娱乐", "头条.娱乐.体育", "体育", "头条号", "新时代", "深圳", "微资讯", "视频", "财经", "科技", "汽车", "时尚"]
    var menu:YYPageMenu?
    
    var changeStyle:Bool=false
    var changeStyleConver:Bool=false
    var changeInStyle:Bool=false
    var changeLabelStyle:Bool=false
    var changPosition:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("pagemenu"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        menu = YYPageMenu.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50),vc: self, titles: titles)
        PositionSettingUtils.position(aboveView: self.navigation.bar, childView: menu!, style: .adaptive)
        PositionSettingUtils.position(aboveView: menu!, childView: menu!.page!.view, style: .fixed)
        
        self.view.addSubview(menu!)
        
        
        let viewControllers: [UIViewController] = self.titles.map { _ in
            UIViewController.autoHeight=menu!.page!.view.frame.height
            let vc: ChildPageViewController = ChildPageViewController(pageMenuVc: self)
            return vc
        }
        
        menu!.page?.initController(viewControllers: viewControllers)
        menu!.style=getLineWidthWithLabel()
        menu!.backgroundColor=UIColor.yellow
        
        menu!.page!.didFinishPagingCallBack={
            currentViewController,currentIndex in
            
            self.menu!.setSelectIndex(index: currentIndex)
        }
    }
    
    
    //MARK:下划线长度根据标签长度
    func getLineWidthWithLabel() -> YYPageMenuStyle {
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = .red
        style.indicatorCorner = .corner(value: 3)
        style.indicatorStyle = .line(widthType: .sizeToFit(minWidth: 20), position: .bottom((margin: 1, height: 2)))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        return style
    }
    
    //MARK:下划线固定长度
    func getLineWidthFixed() -> YYPageMenuStyle {
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = .red
        style.indicatorCorner = .corner(value:3)
        style.indicatorStyle = .line(widthType: .fixed(width: 10), position: .bottom((margin: 1, height: 2)))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        return style
    }
    
    //MARK:遮罩固定长度
    func getConverWidthFixed() -> YYPageMenuStyle {
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = UIColor(white: 0.9, alpha: 1)
        style.indicatorStyle = .cover(widthType: .fixed(width: 30))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        return style
    }
    
    //MARK:遮罩自适应长度
    func getConverWidth() -> YYPageMenuStyle {
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = UIColor(white: 0.9, alpha: 1)
        style.indicatorStyle = .cover(widthType: .sizeToFit(minWidth: 20))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        return style
    }
    
    //MARK:标题自适应长度
    func getTitleWidth() -> YYPageMenuStyle {
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = .red
        style.indicatorCorner = .corner(value: 3)
        style.indicatorStyle = .line(widthType: .sizeToFit(minWidth: 20), position: .bottom((margin: 1, height: 2)))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        style.labelWidthType = .sizeToFit(minWidth: 20)
        return style
    }
    
    //MARK:标题自适应长度
    func getTitleWidthFixed() -> YYPageMenuStyle {
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = .red
        style.indicatorCorner = .corner(value: 3)
        style.indicatorStyle = .line(widthType: .fixed(width: 80), position: .bottom((margin: 1, height: 2)))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        style.labelWidthType = .fixed(width: 80)
        return style
    }
    
    //MARK:底部
    func getLineBottom() -> YYPageMenuStyle {
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = .red
        style.indicatorCorner = .corner(value: 3)
        style.indicatorStyle = .line(widthType: .sizeToFit(minWidth: 20), position: .bottom((margin: 1, height: 2)))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        return style
    }
    
    //MARK:顶部
    func getLineTop() -> YYPageMenuStyle {
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = .red
        style.indicatorCorner = .corner(value: 3)
        style.indicatorStyle = .line(widthType: .sizeToFit(minWidth: 20), position: .top((margin: 1, height: 2)))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        return style
    }
    
}
