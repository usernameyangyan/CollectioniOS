//
//  IBaseControllerView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

open class IBaseControllerView<T:BasePresenter>:AutoHeightUIViewController{
    
    public var mPresenter:T? = T.self()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        mPresenter?.setV(mView: self)
    }
}
