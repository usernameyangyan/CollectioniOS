//
//  File.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/10/10.
//  Copyright © 2019 YoungManSter. All rights reserved.
//  decribe:自定义一个通用的顶部导航栏
//

import UIKit


extension UIViewController{
    
    func toLastViewController(animated:Bool)
    {
        if self.navigationController != nil
        {
            if self.navigationController?.viewControllers.count == 1
            {
                self.dismiss(animated: animated, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: animated)
            }
        }
        else if self.presentingViewController != nil {
            self.dismiss(animated: animated, completion: nil)
        }
    }
    
    class func currentViewController() -> UIViewController
    {
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            return self.currentViewController(from: rootVC)
        } else {
            return UIViewController()
        }
    }
    
    class func currentViewController(from fromVC:UIViewController) -> UIViewController
    {
        if fromVC.isKind(of: UINavigationController.self) {
            let navigationController = fromVC as! UINavigationController
            return currentViewController(from: navigationController.viewControllers.last!)
        }
        else if fromVC.isKind(of: UITabBarController.self) {
            let tabBarController = fromVC as! UITabBarController
            return currentViewController(from: tabBarController.selectedViewController!)
        }
        else if fromVC.presentedViewController != nil {
            return currentViewController(from:fromVC.presentingViewController!)
        }
        else {
            return fromVC
        }
    }
}




///////////////////////////////////YYCustonNavigationBar定义///////////////////////////////
class YYCustomNavigationBar:UIView{
    
    class initNavigationBar: <#super class#> {
        <#code#>
    }
    
    
}
