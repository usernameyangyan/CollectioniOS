//
//  BasePresenter.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

open class BasePresenter:NSObject{
    
    public var mView:UIViewController?=nil
    
    override required public init() {
    }
    
    func setV(mView:UIViewController){
        self.mView=mView
    }
    
}
