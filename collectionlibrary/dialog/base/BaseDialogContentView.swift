//
//  BaseContentView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/12.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

public enum YYDialogAnimationOptions {
    case none
    case zoom        // 先放大，再缩小，再还原
    case topToCenter // 从上到中间
}


open class BaseDialogContentView:UIView{
    public var _contentWidth:CGFloat  = 300.0
    public var _contentHeight:CGFloat = 0
    public var animationOption:YYDialogAnimationOptions = .none
    fileprivate var parentView:BaseDialog?
    
    public func setParentView(parentView:BaseDialog){
        self.parentView=parentView
    }
    
    
    //销毁视图
    open func dimiss(){
        
        switch animationOption {
        case .none:
            
            UIView.animate(withDuration: 0.3, animations: {
                [unowned self] in
                self.alpha = 0.0
                self.parentView!._effectView.alpha = 0.0
                }, completion: { [unowned self] (finished:Bool) in
                    self.parentView!.removeFromSuperview()
            })
            
            break
            
        case .zoom:
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0.0
                
            }, completion: { [unowned self] (finished:Bool) in
                self.parentView!.removeFromSuperview()
            })
            
            break
        case .topToCenter:
            let endPoint = CGPoint(x: center.x, y: self.parentView!.frame.height+frame.height)
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.position = endPoint
            }, completion: {[unowned self] (finished:Bool)in
                self.parentView!.removeFromSuperview()
            })
            
            break
            
        }
        
    }
}
