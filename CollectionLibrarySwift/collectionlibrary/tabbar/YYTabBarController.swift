//
//  YYTabBarController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/24.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

/// 是否需要自定义点击事件回调类型
public typealias YYTabBarControllerShouldHijackHandler = ((_ tabBarController: UITabBarController, _ viewController: UIViewController, _ index: Int) -> (Bool))
/// 自定义点击事件回调类型
public typealias YYTabBarControllerDidHijackHandler = ((_ tabBarController: UITabBarController, _ viewController: UIViewController, _ index: Int) -> (Void))

public class YYTabBarController:UITabBarController, YYTabBarDelegate {

    /// 打印异常
       public static func printError(_ description: String) {
           #if DEBUG
               print("ERROR: ESTabBarController catch an error '\(description)' \n")
           #endif
       }
       
       /// 当前tabBarController是否存在"More"tab
       public static func isShowingMore(_ tabBarController: UITabBarController?) -> Bool {
           return tabBarController?.moreNavigationController.parent != nil
       }

       /// Ignore next selection or not.
       fileprivate var ignoreNextSelection = false

       /// Should hijack select action or not.
       open var shouldHijackHandler: YYTabBarControllerShouldHijackHandler?
       /// Hijack select action.
       open var didHijackHandler: YYTabBarControllerDidHijackHandler?
       
       /// Observer tabBarController's selectedViewController. change its selection when it will-set.
       open override var selectedViewController: UIViewController? {
           willSet {
               guard let newValue = newValue else {
                   // if newValue == nil ...
                   return
               }
               guard !ignoreNextSelection else {
                   ignoreNextSelection = false
                   return
               }
               guard let tabBar = self.tabBar as? YYTabBar, let items = tabBar.items, let index = viewControllers?.firstIndex(of: newValue) else {
                   return
               }
               let value = (YYTabBarController.isShowingMore(self) && index > items.count - 1) ? items.count - 1 : index
               tabBar.select(itemAtIndex: value, animated: false)
           }
       }
       
       /// Observer tabBarController's selectedIndex. change its selection when it will-set.
       open override var selectedIndex: Int {
           willSet {
               guard !ignoreNextSelection else {
                   ignoreNextSelection = false
                   return
               }
               guard let tabBar = self.tabBar as? YYTabBar, let items = tabBar.items else {
                   return
               }
               let value = (YYTabBarController.isShowingMore(self) && newValue > items.count - 1) ? items.count - 1 : newValue
               tabBar.select(itemAtIndex: value, animated: false)
           }
       }
       
       /// Customize set tabBar use KVC.
       open override func viewDidLoad() {
           super.viewDidLoad()
           let tabBar = { () -> YYTabBar in
               let tabBar = YYTabBar()
               tabBar.delegate = self
               tabBar.customDelegate = self
               tabBar.tabBarController = self
               return tabBar
           }()
           self.setValue(tabBar, forKey: "tabBar")
       }

       // MARK: - UITabBar delegate
       open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
           guard let idx = tabBar.items?.firstIndex(of: item) else {
               return;
           }
           if idx == tabBar.items!.count - 1, YYTabBarController.isShowingMore(self) {
               ignoreNextSelection = true
               selectedViewController = moreNavigationController
               return;
           }
           if let vc = viewControllers?[idx] {
               ignoreNextSelection = true
               selectedIndex = idx
               delegate?.tabBarController?(self, didSelect: vc)
           }
       }
       
       open override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
           if let tabBar = tabBar as? YYTabBar {
               tabBar.updateLayout()
           }
       }
       
       open override func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {
           if let tabBar = tabBar as? YYTabBar {
               tabBar.updateLayout()
           }
       }
       
       // MARK: - ESTabBar delegate
       internal func tabBar(_ tabBar: UITabBar, shouldSelect item: UITabBarItem) -> Bool {
           if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
               return delegate?.tabBarController?(self, shouldSelect: vc) ?? true
           }
           return true
       }
       
       internal func tabBar(_ tabBar: UITabBar, shouldHijack item: UITabBarItem) -> Bool {
           if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
               return shouldHijackHandler?(self, vc, idx) ?? false
           }
           return false
       }
       
       internal func tabBar(_ tabBar: UITabBar, didHijack item: UITabBarItem) {
           if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
               didHijackHandler?(self, vc, idx)
           }
       }
}
