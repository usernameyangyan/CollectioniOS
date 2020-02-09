//
//  NavBarConfig.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/10/13.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit


////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension YYNavigationBar {
    
    open override var isHidden: Bool {
        didSet { viewController?.adjustsSafeAreaInsetsAfterIOS11() }
    }
    
    open override var alpha: CGFloat {
        get { return super.alpha }
        set {
            _alpha = newValue
            
            layer.shadowOpacity = newValue < 1 ? 0 : shadow.opacity
            
            if let background = subviews.first {
                background.alpha = newValue
            }
        }
    }
    
    /// map to barTintColor
    open override var backgroundColor: UIColor? {
        get { return super.backgroundColor }
        set { barTintColor = newValue }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) { return true }
        return additionalView?.frame.contains(point) ?? false
    }
}

extension YYNavigationBar {
    
    @available(iOS 11.0, *)
    open override var prefersLargeTitles: Bool {
        get { return super.prefersLargeTitles }
        set {
            super.prefersLargeTitles = newValue
            
            viewController?.navigationItem.largeTitleDisplayMode = newValue ? .always : .never
        }
    }
    
    @available(iOS 11.0, *)
    open override var largeTitleTextAttributes: [NSAttributedString.Key : Any]? {
        get { return super.largeTitleTextAttributes }
        set {
            super.largeTitleTextAttributes = newValue
            
            viewController?.navigationItem.title = viewController?._navigationItem.title
            let superNavigationBar = viewController?.navigationController?.navigationBar
            superNavigationBar?.largeTitleTextAttributes = newValue
        }
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////


extension UINavigationBar {
    
    public func setTitleAlpha(_ alpha: CGFloat) {
        let color = titleTextAttributes?[.foregroundColor] as? UIColor ?? defaultTitleColor
        setTitleColor(color.withAlphaComponent(alpha))
    }
    
    @available(iOS 11.0, *)
    public func setLargeTitleAlpha(_ alpha: CGFloat) {
        let color = largeTitleTextAttributes?[.foregroundColor] as? UIColor ?? defaultTitleColor
        setLargeTitleColor(color.withAlphaComponent(alpha))
    }
    
    public func setTintAlpha(_ alpha: CGFloat) {
        tintColor = tintColor.withAlphaComponent(alpha)
    }
}

private extension UINavigationBar {
    
    var defaultTitleColor: UIColor {
        return barStyle == .default ? UIColor.black : UIColor.white
    }
    
    func setTitleColor(_ color: UIColor) {
        if var titleTextAttributes = titleTextAttributes {
            titleTextAttributes[.foregroundColor] = color
            self.titleTextAttributes = titleTextAttributes
        } else {
            titleTextAttributes = [.foregroundColor: color]
        }
    }
    
    @available(iOS 11.0, *)
    func setLargeTitleColor(_ color: UIColor) {
        if var largeTitleTextAttributes = largeTitleTextAttributes {
            largeTitleTextAttributes[.foregroundColor] = color
            self.largeTitleTextAttributes = largeTitleTextAttributes
        } else {
            self.largeTitleTextAttributes = [.foregroundColor: color]
        }
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////


extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard _configuration.isEnabled else { return }
        
        sendNavigationBarToBack()
        
        guard let bar = topViewController?._navigationBar else { return }
        
        isNavigationBarHidden = false
        navigationBar.isHidden = bar.isHidden
        
        bar.adjustsLayout()
        
        topViewController?.adjustsSafeAreaInsetsAfterIOS11()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard #available(iOS 11.0, *), _configuration.isEnabled else { return }
        
        topViewController?._navigationBar.adjustsLayout()
    }
    
    func sendNavigationBarToBack() {
        navigationBar.tintColor = UIColor.clear
        if navigationBar.shadowImage == nil {
            let image = UIImage()
            navigationBar.setBackgroundImage(image, for: .default)
            navigationBar.shadowImage = image
            navigationBar.backIndicatorImage = image
            navigationBar.backIndicatorTransitionMaskImage = image
        }
        view.sendSubviewToBack(navigationBar)
    }
}


extension UINavigationController {
    
    open var _configuration: Configuration {
        if let configuration = objc_getAssociatedObject(
            self,
            &AssociatedKeys.configuration)
            as? Configuration {
            return configuration
        }
        let configuration = Configuration()
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.configuration,
            configuration,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return configuration
    }
}

extension UIViewController {
    
    open var _navigationBar: YYNavigationBar {
        if let bar = objc_getAssociatedObject(
            self,
            &AssociatedKeys.navigationBar)
            as? YYNavigationBar {
            return bar
        }
        
        let bar = YYNavigationBar(viewController: self)
        
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.navigationBar,
            bar,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bar
    }
    
    open var _navigationItem: UINavigationItem {
        if let item = objc_getAssociatedObject(
            self,
            &AssociatedKeys.navigationItem)
            as? UINavigationItem {
            return item
        }
        
        let item = UINavigationItem()
        item.copy(by: navigationItem)
        
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.navigationItem,
            item,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return item
    }
}

private extension UINavigationItem {
    
    func copy(by navigationItem: UINavigationItem) {
        self.title = navigationItem.title
        self.prompt = navigationItem.prompt
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension UITableViewController {
    
    private var observation: NSKeyValueObservation {
        if let observation = objc_getAssociatedObject(
            self,
            &AssociatedKeys.observation)
            as? NSKeyValueObservation {
            return observation
        }
        
        let observation = tableView.observe(
            \.contentOffset,
            options: .new) { [weak self] tableView, change in
                guard let `self` = self else { return }
                
                self.view.bringSubviewToFront(self._navigationBar)
                self._navigationBar.frame.origin.y = tableView.contentOffset.y + Const.StatusBar.maxY
        }
        
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.observation,
            observation,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return observation
    }
    
    func observeContentOffset() {
        _navigationBar.automaticallyAdjustsPosition = false
        
        _ = observation
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension UIViewController {
    
    func setupNavigationBarWhenViewDidLoad() {
        guard let navigationController = navigationController else { return }
        navigationController.sendNavigationBarToBack()
        
        if #available(iOS 11.0, *) {
            _navigationBar.prefersLargeTitles = navigationController.navigationBar.prefersLargeTitles
        }
        
        let configuration = navigationController._configuration
        _navigationBar.setup(with: configuration)
        
        setupBackBarButtonItem(navigationController)
        
        view.addSubview(_navigationBar)
    }
    
    private func setupBackBarButtonItem(_ navigationController: UINavigationController) {
        let count = navigationController.viewControllers.count
        guard count > 1 else { return }
        
        let backButton = UIButton(type: .system)
        let image = UIImage(named: "navigation_back_default", in: Bundle.current, compatibleWith: nil)
        backButton.setImage(image, for: .normal)
        
        if let title = navigationController.viewControllers[count - 2]._navigationItem.title {
            let maxWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 3
            let width = (title as NSString).boundingRect(
                with: CGSize(width: maxWidth, height: 20),
                options: NSStringDrawingOptions.usesFontLeading,
                attributes: [.font: UIFont.boldSystemFont(ofSize: 17)],
                context: nil).size.width
            backButton.setTitle(width < maxWidth ? title : "Back", for: .normal)
        } else {
            backButton.setTitle("Back", for: .normal)
        }
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        backButton.contentEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 8)
        backButton.sizeToFit()
        
        _navigationBar.backBarButtonItem = BackBarButtonItem(style: .custom(backButton))
    }
    
    func updateNavigationBarWhenViewWillAppear() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.barStyle = _navigationBar._barStyle
        navigationBar.isHidden = _navigationBar.isHidden
        if #available(iOS 11.0, *) {
            adjustsSafeAreaInsetsAfterIOS11()
            navigationItem.title = _navigationItem.title
            navigationBar.largeTitleTextAttributes = _navigationBar.largeTitleTextAttributes
        }
        view.bringSubviewToFront(_navigationBar)
    }
}

extension UIViewController {
    
    public func adjustsNavigationBarLayout() {
        _navigationBar.adjustsLayout()
        _navigationBar.setNeedsLayout()
    }
    
    func adjustsSafeAreaInsetsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        
        let height = _navigationBar.additionalView?.frame.height ?? 0
        additionalSafeAreaInsets.top = _navigationBar.isHidden
            ? -view.safeAreaInsets.top
            : _navigationBar._additionalHeight + height
    }
}

private extension YYNavigationBar {
    
    func setup(with configuration: Configuration) {
        isHidden = configuration.isHidden
        alpha = configuration.alpha
        isTranslucent = configuration.isTranslucent
        barTintColor = configuration.barTintColor
        tintColor = configuration.tintColor
        
        titleTextAttributes = configuration.titleTextAttributes
        shadowImage = configuration.shadowImage
        setBackgroundImage(
            configuration.backgroundImage,
            for: configuration.barPosition,
            barMetrics: configuration.barMetrics)
        
        barStyle = configuration.barStyle
        statusBarStyle = configuration.statusBarStyle
        
        additionalHeight = configuration.additionalHeight
        
        isShadowHidden = configuration.isShadowHidden
        
        if let shadow = configuration.shadow {
            self.shadow = shadow
        }
        
        if #available(iOS 11.0, *) {
            layoutPaddings = configuration.layoutPaddings
            largeTitleTextAttributes = configuration.largeTitleTextAttributes
        }
    }
}

private extension Bundle {
    
    static var current: Bundle? {
        guard let resourcePath = Bundle(for: YYNavigationBar.self).resourcePath,
            let bundle = Bundle(path: "\(resourcePath)/YYNavigationBar.bundle")
            else {
                return nil
        }
        return bundle
    }
}


public extension Navigation where Base: UIViewController {
    
    var bar: YYNavigationBar {
        assert(!(base is UINavigationController),
               "UINavigationController can't use this property, please use configuration.")
        return base._navigationBar
    }
    
    var item: UINavigationItem {
        assert(!(base is UINavigationController),
               "UINavigationController can't use this property, please use configuration.")
        return base._navigationItem
    }
}

public extension Navigation where Base: UINavigationController {
    
    var configuration: Configuration {
        return base._configuration
    }
    
    @available(iOS 11.0, *)
    func prefersLargeTitles() {
        base.navigationBar.prefersLargeTitles = true
    }
}


extension UIViewController : WRAwakeProtocol{
    
    
    
    
    private var isNavigationBarEnabled: Bool {
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled,
            navigationController.viewControllers.contains(self) else { return false }
        return true
    }
    
    @objc private func navigation_viewDidLoad() {
        navigation_viewDidLoad()
        
        guard isNavigationBarEnabled else { return }
        
        setupNavigationBarWhenViewDidLoad()
        
        if let tableViewController = self as? UITableViewController {
            tableViewController.observeContentOffset()
        }
    }
    
    @objc private func navigation_viewWillAppear(_ animated: Bool) {
        navigation_viewWillAppear(animated)
        
        guard isNavigationBarEnabled else { return }
        
        updateNavigationBarWhenViewWillAppear()
    }
    
    @objc private func navigation_setNeedsStatusBarAppearanceUpdate() {
        navigation_setNeedsStatusBarAppearanceUpdate()
        
        adjustsNavigationBarLayout()
    }
    
    @objc private func navigation_viewDidLayoutSubviews() {
        navigation_viewDidLayoutSubviews()
        
        view.bringSubviewToFront(_navigationBar)
    }
    
    @objc public static func wrAwake()
    {
        let needSwizzleSelectors = [
            #selector(viewDidLoad),
            #selector(setNeedsStatusBarAppearanceUpdate),
            #selector(viewWillAppear(_:)),
            #selector(viewDidLayoutSubviews),
        ]
        
        for selector in needSwizzleSelectors
        {
            let newSelectorStr = "navigation_" + selector.description
            if let originalMethod = class_getInstanceMethod(self, selector),
                let swizzledMethod = class_getInstanceMethod(self, Selector(newSelectorStr)) {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
}


extension UIApplication
{
    private static let runOnce:Void = { //使用静态属性以保证只调用一次(该属性是个方法)
        NothingToSeeHere.harmlessFunction()
    }()
    
    open override var next: UIResponder?{ //重写next属性
        UIApplication.runOnce
        return super.next
    }
}


public protocol WRAwakeProtocol: class {
    static func wrAwake()
}


class NothingToSeeHere
{
    static func harmlessFunction(){
        UIViewController.wrAwake()
    }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////
