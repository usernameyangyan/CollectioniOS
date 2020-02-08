//
//  AutoViewHeight.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/4.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

open class AutoHeightUIViewController:UIViewController{
    
    var height:CGFloat?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        height=UIViewController.autoHeight
        UIViewController.autoHeight=UIScreen.main.bounds.height
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        self.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height!)
       
        super.viewDidLoad()
    }
    
}


extension UIViewController{
    static var autoHeight:CGFloat=UIScreen.main.bounds.height
}
