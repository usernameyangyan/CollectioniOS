//
//  NavigationUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

var instance: NavigationUtils?
var vc:UIViewController?

class NavigationUtils{
    
    class func with(controller:UIViewController) -> NavigationUtils {
        if (instance == nil) {
            instance = NavigationUtils()
        }
        vc=controller
        return instance!
    }
    
    private init(){
        
    }
    
    
    func setHidden(isHidden:Bool)->NavigationUtils{
        vc!.navigation.bar.isHidden=isHidden
        return instance!
    }
    
    func setAlpha(alpha: CGFloat)->NavigationUtils{
        vc!.navigation.bar.alpha=alpha
        return instance!
    }
    
    func setBarBackgroundColor(barTintColor: UIColor)->NavigationUtils{
        vc!.navigation.bar.barTintColor=barTintColor
        return instance!
    }
    
    func setTitleColor(tintColor: UIColor)->NavigationUtils{
        setTitleTextAttributes(titleTextAttributes: [NSAttributedString.Key.foregroundColor:tintColor]).build()
        vc!.navigation.bar.tintColor=tintColor
        return instance!
    }
    
    func setTitleSize(ofSize: CGFloat)->NavigationUtils{
        setTitleTextAttributes(titleTextAttributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:ofSize)]).build()
        return instance!
    }
    
    func setShadowImage(shadowImage: UIImage?)->NavigationUtils{
        vc!.navigation.bar.shadowImage=shadowImage
        return instance!
    }
    
    func setShadowHidden(isShadowHidden: Bool)->NavigationUtils{
        vc!.navigation.bar.isShadowHidden=isShadowHidden
        return instance!
    }
    
    func setShadow(shadow: Shadow)->NavigationUtils{
        vc!.navigation.bar.shadow=shadow
        return instance!
    }
    
    func setTitleTextAttributes(titleTextAttributes: [NSAttributedString.Key : Any])->NavigationUtils{
        vc!.navigation.bar.titleTextAttributes=titleTextAttributes
        return instance!
    }
    
    func setTranslucent(isTranslucent: Bool)->NavigationUtils{
        if(isTranslucent){
            setAlpha(alpha: 0).build()
        }else{
            setAlpha(alpha: 1).build()
        }
        return instance!
    }
    
    func setBarStyle(barStyle: UIBarStyle)->NavigationUtils{
        vc!.navigation.bar.barStyle=barStyle
        return instance!
    }
    
    func setStatusBarStyle(statusBarStyle: UIStatusBarStyle)->NavigationUtils{
        vc!.navigation.bar.statusBarStyle=statusBarStyle
        return instance!
    }
    
    func setAdditionalHeight(additionalHeight: CGFloat)->NavigationUtils{
        vc!.navigation.bar.additionalHeight=additionalHeight
        return instance!
    }
    
    func setLayoutPaddings(layoutPaddings: UIEdgeInsets)->NavigationUtils{
        vc!.navigation.bar.layoutPaddings=layoutPaddings
        return instance!
    }
    
    func setLayoutMargins(layoutMargins: UIEdgeInsets)->NavigationUtils{
        vc!.navigation.bar.layoutMargins=layoutMargins
        return instance!
    }
    
    
    func setLargeTitleTextAttributes(_largeTitleTextAttributes: [NSAttributedString.Key: Any])->NavigationUtils{
        vc!.navigation.bar.largeTitleTextAttributes=_largeTitleTextAttributes
        return instance!
    }
    
    func setBackgroundImage(backgroundImage: UIImage?)->NavigationUtils{
        vc!.navigation.bar.setBackgroundImage(backgroundImage, for: .default)
        return instance!
    }
    
    func setTitle(title:String)->NavigationUtils{
        vc!.navigation.item.title = title
        return instance!
    }
    
    func setBackBarButtonItem(style: BackBarButtonItem.ItemStyle, tintColor: UIColor? = nil)->NavigationUtils{
        vc!.navigation.bar.backBarButtonItem  = BackBarButtonItem.init(style: style, tintColor: tintColor)
        return instance!
    }
    
    func setBackBarButtonItem(cumstonItem:BackBarButtonItem,tintColor: UIColor? = nil)->NavigationUtils{
        cumstonItem.tintColor=tintColor
        vc!.navigation.bar.backBarButtonItem=cumstonItem
        return instance!
    }
    
    
    func hiddenBackBarItem()->NavigationUtils{
        vc!.navigation.item.setLeftBarButton(nil, animated: false)
        return instance!
    }
    
    
    func setLeftButtonItem(item: UIBarButtonItem)->NavigationUtils{
        vc!.navigation.item.leftBarButtonItem = item
        return instance!
    }
    
    func setLeftButtonItems(items: [UIBarButtonItem])->NavigationUtils{
        vc!.navigation.item.leftBarButtonItems = items
        return instance!
    }
    
    
    func setRightButtonItem(item: UIBarButtonItem)->NavigationUtils{
        vc!.navigation.item.rightBarButtonItem = item
        return instance!
    }
    
    func setRightButtonItems(items: [UIBarButtonItem])->NavigationUtils{
        vc!.navigation.item.rightBarButtonItems = items
        return instance!
    }
    
    //结束语句
    open func build() {}
    
}


