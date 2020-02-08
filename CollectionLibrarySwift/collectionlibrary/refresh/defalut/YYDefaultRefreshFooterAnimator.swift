//
//  YYRefreshFooterAnimator.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

open class YYDefaultRefreshFooterAnimator: UIView, YYRefreshProtocol, YYRefreshAnimatorProtocol {

    open var loadingMoreDescription: String = ""
    open var noMoreDataDescription: String  = "没有更多数据"
    open var loadingDescription: String     = "正在加载中..."

    open var view: UIView { return self }
    open var duration: TimeInterval = 0.3
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var trigger: CGFloat = 42.0
    open var executeIncremental: CGFloat = 42.0
    open var state: YYRefreshViewState = .pullToRefresh
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(style: .gray)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(indicatorView)
        
        titleLabel
            .centerX(equalTo: self.yy_centerX)
            .centerY(equalTo: self.yy_centerY)
            .build()
        
        
        indicatorView
            .right(equalTo: titleLabel.yy_left,constant: 10)
            .centerY(equalTo: self.yy_centerY).build()
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func refreshAnimationBegin(view: YYRefreshComponent) {
        indicatorView.startAnimating()
        titleLabel.text = loadingDescription
        indicatorView.isHidden = false
    }
    
    open func refreshAnimationEnd(view: YYRefreshComponent) {
        indicatorView.stopAnimating()
        titleLabel.text = loadingMoreDescription
        indicatorView.isHidden = true
    }
    
    open func refresh(view: YYRefreshComponent, progressDidChange progress: CGFloat) {
        // do nothing
    }
    
    open func refresh(view: YYRefreshComponent, stateDidChange state: YYRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
        
        switch state {
        case .refreshing, .autoRefreshing :
            titleLabel.text = loadingDescription
            break
        case .noMoreData:
            titleLabel.text = noMoreDataDescription
            break
        case .pullToRefresh:
            titleLabel.text = loadingMoreDescription
            break
        default:
            break
        }
        
    }
    
}
