//
//  YYRefreshAnimator.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

open class YYRefreshAnimator: YYRefreshProtocol, YYRefreshAnimatorProtocol {
    // The view that called when component refresh, returns a custom view or self if 'self' is the customized views.
    open var view: UIView
    // Customized inset.
    open var insets: UIEdgeInsets
    // Refresh event is executed threshold required y offset, set a value greater than 0.0, the default is 60.0
    open var trigger: CGFloat = 60.0
    // Offset y refresh event executed by this parameter you can customize the animation to perform when you refresh the view of reservations height
    open var executeIncremental: CGFloat = 60.0
    // Current refresh state, default is .pullToRefresh
    open var state: YYRefreshViewState = .pullToRefresh
    
    public init() {
        view = UIView()
        insets = UIEdgeInsets.zero
    }
    
    open func refreshAnimationBegin(view: YYRefreshComponent) {
        /// Do nothing!
    }
    
    open func refreshAnimationWillEnd(view: YYRefreshComponent) {
        /// Do nothing!
    }
    
    open func refreshAnimationEnd(view: YYRefreshComponent) {
        /// Do nothing!
    }
    
    open func refresh(view: YYRefreshComponent, progressDidChange progress: CGFloat) {
        /// Do nothing!
    }
    
    open func refresh(view: YYRefreshComponent, stateDidChange state: YYRefreshViewState) {
        /// Do nothing!
    }
}
