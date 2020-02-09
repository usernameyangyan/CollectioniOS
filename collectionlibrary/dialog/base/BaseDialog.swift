//
//  BaseDialog.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/10.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

open class BaseDialog:UIView{
    
    /**视图的宽高 */
    let _screenWidth  = UIScreen.main.bounds.size.width
    let _screenHeight = UIScreen.main.bounds.size.height
    
    var _effectView:UIVisualEffectView!
    var maskLayer=true
    var maskLayerAlpha:CGFloat=0.5
    var showMaskLayer:Bool=false
    fileprivate var dialogContentView:BaseDialogContentView?
    
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        _effectView        = UIVisualEffectView()
        _effectView.frame  = CGRect(x: 0, y: 0, width: _screenWidth, height: _screenHeight)
        _effectView.effect = nil
        _effectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        _effectView.backgroundColor=UIColor.black
        
        
        self.addSubview(_effectView)
        self.frame = CGRect(x: 0, y: 0, width: _screenWidth, height: _screenHeight)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加内容视图
    open func addContentView(_dialogContentView:BaseDialogContentView){
        dialogContentView=_dialogContentView
        dialogContentView!.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        self.addSubview(dialogContentView!)
    }
    
    
    //MARK：展现视图
    public func show(){
        
        if(showMaskLayer){
            _effectView.alpha=maskLayerAlpha
        }else{
            _effectView.alpha=0.0
        }
        
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        switch dialogContentView!.animationOption {
            
        case .none:
            dialogContentView!.alpha = 0.0
            UIView.animate(withDuration: 0.34, animations: { [unowned self] in
                self.dialogContentView!.alpha = 1.0
            })
            break
            
        case .zoom:
            
            self.dialogContentView!.layer.setValue(0, forKeyPath: "transform.scale")
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                [unowned self] in
                self.dialogContentView!.layer.setValue(1.0, forKeyPath: "transform.scale")
                }, completion: { _ in
                    
            })
            
            break
        case .topToCenter:
            
            let startPoint = CGPoint(x: center.x, y: dialogContentView!.frame.height)
            dialogContentView!.layer.position = startPoint
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: { [unowned self] in
                self.dialogContentView!.layer.position = self.center
                }, completion: { _ in
                    
            })
            
            break
            
        }
        
    }
    
    
    
}
