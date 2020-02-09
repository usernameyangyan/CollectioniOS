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

open class NavigationUtils{
    
    public class func with(controller:UIViewController) -> NavigationUtils {
        if (instance == nil) {
            instance = NavigationUtils()
        }
        vc=controller
        return instance!
    }
    
    private init(){
        
    }
    
    
    public func setHidden(isHidden:Bool)->NavigationUtils{
        vc!.navigation.bar.isHidden=isHidden
        return instance!
    }
    
    public func setAlpha(alpha: CGFloat)->NavigationUtils{
        vc!.navigation.bar.alpha=alpha
        return instance!
    }
    
    public func setBarBackgroundColor(barTintColor: UIColor)->NavigationUtils{
        vc!.navigation.bar.barTintColor=barTintColor
        return instance!
    }
    
    public func setTitleColor(tintColor: UIColor)->NavigationUtils{
        setTitleTextAttributes(titleTextAttributes: [NSAttributedString.Key.foregroundColor:tintColor]).build()
        vc!.navigation.bar.tintColor=tintColor
        return instance!
    }
    
    public func setTitleSize(ofSize: CGFloat)->NavigationUtils{
        setTitleTextAttributes(titleTextAttributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:ofSize)]).build()
        return instance!
    }
    
    public func setShadowImage(shadowImage: UIImage?)->NavigationUtils{
        vc!.navigation.bar.shadowImage=shadowImage
        return instance!
    }
    
    public func setShadowHidden(isShadowHidden: Bool)->NavigationUtils{
        vc!.navigation.bar.isShadowHidden=isShadowHidden
        return instance!
    }
    
    public func setShadow(shadow: Shadow)->NavigationUtils{
        vc!.navigation.bar.shadow=shadow
        return instance!
    }
    
    public func setTitleTextAttributes(titleTextAttributes: [NSAttributedString.Key : Any])->NavigationUtils{
        vc!.navigation.bar.titleTextAttributes=titleTextAttributes
        return instance!
    }
    
    public func setTranslucent(isTranslucent: Bool)->NavigationUtils{
        if(isTranslucent){
            setAlpha(alpha: 0).build()
        }else{
            setAlpha(alpha: 1).build()
        }
        return instance!
    }
    
    public func setBarStyle(barStyle: UIBarStyle)->NavigationUtils{
        vc!.navigation.bar.barStyle=barStyle
        return instance!
    }
    
    public func setStatusBarStyle(statusBarStyle: UIStatusBarStyle)->NavigationUtils{
        vc!.navigation.bar.statusBarStyle=statusBarStyle
        return instance!
    }
    
    public func setAdditionalHeight(additionalHeight: CGFloat)->NavigationUtils{
        vc!.navigation.bar.additionalHeight=additionalHeight
        return instance!
    }
    
    public func setLayoutPaddings(layoutPaddings: UIEdgeInsets)->NavigationUtils{
        vc!.navigation.bar.layoutPaddings=layoutPaddings
        return instance!
    }
    
    public func setLayoutMargins(layoutMargins: UIEdgeInsets)->NavigationUtils{
        vc!.navigation.bar.layoutMargins=layoutMargins
        return instance!
    }
    
    
    public func setLargeTitleTextAttributes(_largeTitleTextAttributes: [NSAttributedString.Key: Any])->NavigationUtils{
        vc!.navigation.bar.largeTitleTextAttributes=_largeTitleTextAttributes
        return instance!
    }
    
    public func setBackgroundImage(backgroundImage: UIImage?)->NavigationUtils{
        vc!.navigation.bar.setBackgroundImage(backgroundImage, for: .default)
        return instance!
    }
    
    public func setTitle(title:String)->NavigationUtils{
        vc!.navigation.item.title = title
        return instance!
    }
    
    public func setBackBarButtonItem(style: BackBarButtonItem.ItemStyle, tintColor: UIColor? = nil)->NavigationUtils{
        vc!.navigation.bar.backBarButtonItem  = BackBarButtonItem.init(style: style, tintColor: tintColor)
        return instance!
    }
    
    public func setBackBarButtonItem(cumstonItem:BackBarButtonItem,tintColor: UIColor? = nil)->NavigationUtils{
        cumstonItem.tintColor=tintColor
        vc!.navigation.bar.backBarButtonItem=cumstonItem
        return instance!
    }
    
    
    public func hiddenBackBarItem()->NavigationUtils{
        vc!.navigation.item.setLeftBarButton(nil, animated: false)
        return instance!
    }
    
    
    public func setLeftButtonItem(item: UIBarButtonItem)->NavigationUtils{
        vc!.navigation.item.leftBarButtonItem = item
        return instance!
    }
    
    public func setLeftButtonItems(items: [UIBarButtonItem])->NavigationUtils{
        vc!.navigation.item.leftBarButtonItems = items
        return instance!
    }
    
    
    public func setRightButtonItem(item: UIBarButtonItem)->NavigationUtils{
        vc!.navigation.item.rightBarButtonItem = item
        return instance!
    }
    
    public func setRightButtonItems(items: [UIBarButtonItem])->NavigationUtils{
        vc!.navigation.item.rightBarButtonItems = items
        return instance!
    }
    
    //结束语句
    open func build() {}
    
}


