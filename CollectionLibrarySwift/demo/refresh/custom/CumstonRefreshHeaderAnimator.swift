//
//  CumstonRefreshHeaderAnimator.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/6.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class CumstonRefreshHeaderAnimator:UIView,YYRefreshAnimatorProtocol,YYRefreshProtocol{
    
    var view: UIView{return self}
    
    var insets: UIEdgeInsets=UIEdgeInsets.zero
    
    var trigger: CGFloat=60
    
    var executeIncremental: CGFloat=60
    
    var state: YYRefreshViewState = .pullToRefresh
    
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "loading15")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(imageView)
        
        imageView
            .centerY(equalTo: self.yy_centerY)
            .centerX(equalTo: self.yy_centerX)
            .build()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func refreshAnimationBegin(view: YYRefreshComponent) {
         let images = (0...29).map{return $0 < 10 ? "loading0\($0)" : "loading\($0)"}
         self.imageView.animationDuration = 2.0
         self.imageView.animationRepeatCount = 0
         self.imageView.animationImages = images.map{return UIImage(named:$0)!}
         self.imageView.startAnimating()
    }
    
    func refreshAnimationEnd(view: YYRefreshComponent) {
        imageView.stopAnimating()        
    }
    
    func refresh(view: YYRefreshComponent, progressDidChange progress: CGFloat) {
    }
    
    func refresh(view: YYRefreshComponent, stateDidChange state: YYRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
        
        switch state {
            
        default:
            break
        }
    }
    
    
}
