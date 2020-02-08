//
//  CumstonRefreshFooterAnimator.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/7.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class CumstonRefreshFooterAnimator:UIView,YYRefreshAnimatorProtocol,YYRefreshProtocol{
    var view: UIView{return self}
    
    var insets: UIEdgeInsets = .zero
    
    var trigger: CGFloat=48
    
    var executeIncremental: CGFloat=48
    
    var state: YYRefreshViewState = .pullToRefresh
    
    open var noMoreDataDescription: String  = "我也是有底线的~"
    open var loadingDescription: String     = "正在加载中..."
    
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(indicatorView)
        
        titleLabel
            .centerX(equalTo: self.yy_centerX)
            .centerY(equalTo: self.yy_centerY)
            .build()
        
        indicatorView
            .left(equalTo: self.yy_left,constant: 50)
            .centerY(equalTo: self.yy_centerY).build()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func refreshAnimationBegin(view: YYRefreshComponent) {
        indicatorView.startAnimating()
        titleLabel.text = loadingDescription
        indicatorView.isHidden = false
    }
    
    func refreshAnimationEnd(view: YYRefreshComponent) {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }
    
    func refresh(view: YYRefreshComponent, progressDidChange progress: CGFloat) {
        
    }
    
    func refresh(view: YYRefreshComponent, stateDidChange state: YYRefreshViewState) {
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
            break
        default:
            break
        }
    }
    
    
    
}
