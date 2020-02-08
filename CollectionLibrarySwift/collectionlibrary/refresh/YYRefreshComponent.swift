//
//  YYRefreshComponent.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation
import UIKit

public typealias YYRefreshHandler = (() -> ())

open class YYRefreshComponent: UIView {
    
    open weak var scrollView: UIScrollView?
    
    /// @param handler Refresh callback method
    open var handler: YYRefreshHandler?
    
    /// @param animator Animated view refresh controls, custom must comply with the following two protocol
    open var animator: (YYRefreshProtocol & YYRefreshAnimatorProtocol)!
    
    /// @param refreshing or not
    fileprivate var _isRefreshing = false
    open var isRefreshing: Bool {
        get {
            return self._isRefreshing
        }
    }
    
    /// @param auto refreshing or not
    fileprivate var _isAutoRefreshing = false
    open var isAutoRefreshing: Bool {
        get {
            return self._isAutoRefreshing
        }
    }
    
    /// @param tag observing
    fileprivate var isObservingScrollView = false
    fileprivate var isIgnoreObserving = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin]
    }
    
    public convenience init(frame: CGRect, handler: @escaping YYRefreshHandler) {
        self.init(frame: frame)
        self.handler = handler
        self.animator = YYRefreshAnimator.init()
    }
    
    public convenience init(frame: CGRect, handler: @escaping YYRefreshHandler, animator: YYRefreshProtocol & YYRefreshAnimatorProtocol) {
        self.init(frame: frame)
        self.handler = handler
        self.animator = animator
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver()
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        /// Remove observer from superview immediately
        self.removeObserver()
        DispatchQueue.main.async { [weak self, newSuperview] in
            /// Add observer to new superview in next runloop
            self?.addObserver(newSuperview)
        }
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.scrollView = self.superview as? UIScrollView
        if let _ = animator {
            let v = animator.view
            if v.superview == nil {
                let inset = animator.insets
                self.addSubview(v)
                v.frame = CGRect.init(x: inset.left,
                                      y: inset.right,
                                      width: self.bounds.size.width - inset.left - inset.right,
                                      height: self.bounds.size.height - inset.top - inset.bottom)
                v.autoresizingMask = [
                    .flexibleWidth,
                    .flexibleTopMargin,
                    .flexibleHeight,
                    .flexibleBottomMargin
                ]
            }
        }
    }
    
    // MARK: - Action
    
    public final func startRefreshing(isAuto: Bool = false) -> Void {
        guard isRefreshing == false && isAutoRefreshing == false else {
            return
        }
        
        _isRefreshing = !isAuto
        _isAutoRefreshing = isAuto
        
        self.start()
    }
    
    public final func stopRefreshing() -> Void {
        guard isRefreshing == true || isAutoRefreshing == true else {
            return
        }
        
        self.stop()
    }
    
    public func start() {
        
    }
    
    public func stop() {
        _isRefreshing = false
        _isAutoRefreshing = false
    }
    
    //  ScrollView contentSize change action
    public func sizeChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
        
    }
    
    //  ScrollView offset change action
    public func offsetChangeAction(object: AnyObject?, change: [NSKeyValueChangeKey : Any]?) {
        
    }
    
}

extension YYRefreshComponent /* KVO methods */ {
    
    fileprivate static var context = "YYRefreshKVOContext"
    fileprivate static let offsetKeyPath = "contentOffset"
    fileprivate static let contentSizeKeyPath = "contentSize"
    
    public func ignoreObserver(_ ignore: Bool = false) {
        if let scrollView = scrollView {
            scrollView.isScrollEnabled = !ignore
        }
        isIgnoreObserving = ignore
    }
    
    fileprivate func addObserver(_ view: UIView?) {
        if let scrollView = view as? UIScrollView, !isObservingScrollView {
            scrollView.addObserver(self, forKeyPath: YYRefreshComponent.offsetKeyPath, options: [.initial, .new], context: &YYRefreshComponent.context)
            scrollView.addObserver(self, forKeyPath: YYRefreshComponent.contentSizeKeyPath, options: [.initial, .new], context: &YYRefreshComponent.context)
            isObservingScrollView = true
        }
    }
    
    fileprivate func removeObserver() {
        if let scrollView = superview as? UIScrollView, isObservingScrollView {
            scrollView.removeObserver(self, forKeyPath: YYRefreshComponent.offsetKeyPath, context: &YYRefreshComponent.context)
            scrollView.removeObserver(self, forKeyPath: YYRefreshComponent.contentSizeKeyPath, context: &YYRefreshComponent.context)
            isObservingScrollView = false
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &YYRefreshComponent.context {
            guard isUserInteractionEnabled == true && isHidden == false else {
                return
            }
            if keyPath == YYRefreshComponent.contentSizeKeyPath {
                if isIgnoreObserving == false {
                    sizeChangeAction(object: object as AnyObject?, change: change)
                }
            } else if keyPath == YYRefreshComponent.offsetKeyPath {
                if isIgnoreObserving == false {
                    offsetChangeAction(object: object as AnyObject?, change: change)
                }
            }
        } else {

        }
    }
    
}


