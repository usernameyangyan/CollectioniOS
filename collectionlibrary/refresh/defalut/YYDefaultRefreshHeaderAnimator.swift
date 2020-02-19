//
//  YYRefreshHeaderAnimator.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

open class YYDefaultRefreshHeaderAnimator: UIView, YYRefreshProtocol, YYRefreshAnimatorProtocol {
    
    
    open var pullToRefreshDescription = "下拉刷新"
    open var releaseToRefreshDescription = "释放刷新"
    open var loadingDescription = "正在加载中..."
    
    open var view: UIView { return self }
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var trigger: CGFloat = 60.0
    open var executeIncremental: CGFloat = 60.0
    open var state: YYRefreshViewState = .pullToRefresh
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image=UIImage.init(named: "Collectionlibrary.bundle/icon_pull_to_refresh_arrow@2x.png")
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 0.625, alpha: 1.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(style: .gray)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = pullToRefreshDescription
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(indicatorView)
        
        
       
        
        titleLabel
            .centerX(equalTo: self.yy_centerX)
            .centerY(equalTo: self.yy_centerY)
            .build()
        
        imageView
            .centerY(equalTo: self.yy_centerY)
            .right(equalTo: self.titleLabel.yy_left,constant: 10)
            .build()
        
        indicatorView
            .centerY(equalTo: self.yy_centerY)
            .right(equalTo: self.titleLabel.yy_left,constant: 10)
            .build()
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func refreshAnimationBegin(view: YYRefreshComponent) {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        imageView.isHidden = true
        titleLabel.text = loadingDescription
        imageView.transform = CGAffineTransform(rotationAngle: 0.000001 - CGFloat.pi)
    }
    
    open func refreshAnimationEnd(view: YYRefreshComponent) {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        imageView.isHidden = false
        titleLabel.text = pullToRefreshDescription
        imageView.transform = CGAffineTransform.identity
    }
    
    open func refresh(view: YYRefreshComponent, progressDidChange progress: CGFloat) {
        // Do nothing
        
    }
    
    open func refresh(view: YYRefreshComponent, stateDidChange state:YYRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
        
        switch state {
        case .refreshing, .autoRefreshing:
            titleLabel.text = loadingDescription
            break
        case .releaseToRefresh:
            titleLabel.text = releaseToRefreshDescription
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions(), animations: {
                [weak self] in
                self?.imageView.transform = CGAffineTransform(rotationAngle: 0.000001 - CGFloat.pi)
            }) { (animated) in }
            break
        case .pullToRefresh:
            titleLabel.text = pullToRefreshDescription
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions(), animations: {
                [weak self] in
                self?.imageView.transform = CGAffineTransform.identity
            }) { (animated) in }
            break
        default:
            break
        }
    }
    
}

