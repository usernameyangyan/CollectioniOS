//
//  YYLoadingDialog.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/12.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit


class YYDefalutLoadingContentView:BaseDialogContentView{
    private var baseDialog:BaseDialog?
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.color=UIColor.white
        return indicatorView
    }()
    
    lazy var labelMessage:UILabel={
        let labelMessage = UILabel.init()
        labelMessage.textColor = UIColor.white
        labelMessage.textAlignment = .center
        labelMessage.numberOfLines = 0
        labelMessage.font = UIFont.systemFont(ofSize: 16)
        return labelMessage
    }()
    
    convenience init(baseDialog:BaseDialog){
        self.init()
        self.baseDialog=baseDialog
        self.commonint()
    }
    
    fileprivate func commonint(){
        
        _contentWidth=150
        _contentHeight=150
        
        labelMessage.preferredMaxLayoutWidth = _contentWidth-10
        
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        self.layer.cornerRadius  = 10
        self.layer.masksToBounds = true
        
        self.addSubview(indicatorView)
        self.addSubview(labelMessage)
        
        self.frame=CGRect(x: frame.origin.x, y:frame.origin.y, width: _contentWidth, height:_contentHeight)
        self.center = CGPoint(x: baseDialog!._screenWidth/2, y: baseDialog!._screenHeight/2)
        
        
        indicatorView
            .centerX(equalTo: self.yy_centerX)
            .centerY(equalTo: self.yy_centerY,constant: -20)
            .width(40)
            .height(40)
            .build()
        
        
        labelMessage
            .centerX(equalTo: self.yy_centerX)
            .top(equalTo: self.indicatorView.yy_bottom)
            .height(50)
            .build()
        
    }
    
    func setAnimationOption(animationOption:YYDialogAnimationOptions){
        self.animationOption=animationOption
    }
    
    override func dimiss() {
        super.dimiss()
        indicatorView.stopAnimating()
    }
}

open class YYDefalutLoadingDialog:BaseDialog{
    
    var defaultContentView:YYDefalutLoadingContentView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        defaultContentView=YYDefalutLoadingContentView(baseDialog: self)
        addContentView(_dialogContentView: defaultContentView!)
        defaultContentView!.setParentView(parentView: self)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setMessageColor(color:UIColor) -> YYDefalutLoadingDialog {
        defaultContentView!.labelMessage.textColor=color
        return self
    }
    
    public func setMessageSize(fontSize:CGFloat) -> YYDefalutLoadingDialog {
        defaultContentView!.labelMessage.font=UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    public func setContentViewCornerRadius(radius:CGFloat) -> YYDefalutLoadingDialog {
        defaultContentView!.layer.cornerRadius=radius
        return self
    }
    
    public func setIndicatorColor(color:UIColor) -> YYDefalutLoadingDialog {
        defaultContentView!.indicatorView.color=color
        return self
    }
    
    public func setContentViewBackgroundColor(color:UIColor)-> YYDefalutLoadingDialog{
        defaultContentView!.backgroundColor=color
        return self
    }
    
    public func setAnimationOption(animationOption:YYDialogAnimationOptions)->YYDefalutLoadingDialog{
        defaultContentView!.setAnimationOption(animationOption: animationOption)
        return self
    }
    
    public func setMaskLayer(showMaskLayer:Bool)->YYDefalutLoadingDialog{
        self.showMaskLayer=showMaskLayer
        if(showMaskLayer){
            _effectView.alpha=maskLayerAlpha
        }else{
            _effectView.alpha=0.0
        }
        
        return self
        
    }
    
    public func setMaskLayerAlpha(alpha:CGFloat)->YYDefalutLoadingDialog{
        maskLayerAlpha=alpha
        _effectView.alpha = maskLayerAlpha
        
        return self
    }
    
    
    public func show(message:String){
        defaultContentView!.labelMessage.text=message
        defaultContentView!.indicatorView.startAnimating()
        self.show()
    }
    
    public func dismiss(){
        defaultContentView!.dimiss()
    }
    
}


open class YYLoadingDialog{
    public func defalutDialog()->YYDefalutLoadingDialog{
        return YYDefalutLoadingDialog()
        
    }
    
    public func customDialog(custom:BaseDialogContentView)->CustomDialog{
        return CustomDialog(custom: custom)
        
    }
    
    
    //MARK：自定义视图
    public class CustomDialog{
        fileprivate var custom:BaseDialogContentView?
        fileprivate var dialog:BaseDialog?
        
        public init(custom:BaseDialogContentView) {
            
            self.custom=custom
            dialog=BaseDialog()
            
            custom.frame=CGRect(x: custom.frame.origin.x, y: custom.frame.origin.y, width: custom._contentWidth, height:custom._contentHeight)
            custom.center = CGPoint(x: dialog!._screenWidth/2, y: dialog!._screenHeight/2)
            dialog?.addContentView(_dialogContentView: self.custom!)
            custom.setParentView(parentView: dialog!)
        }
        
        
        public func setMaskLayer(showMaskLayer:Bool)->CustomDialog{
            dialog!.showMaskLayer=showMaskLayer
            if(showMaskLayer){
                dialog!._effectView.alpha=dialog!.maskLayerAlpha
            }else{
                dialog!._effectView.alpha=0.0
            }
            
            return self
            
        }
        
        public func setMaskLayerAlpha(alpha:CGFloat)->CustomDialog{
            dialog!.maskLayerAlpha=alpha
            dialog!._effectView.alpha = dialog!.maskLayerAlpha
            
            return self
        }
        
        public func show(){
            self.dialog!.show()
        }
        
        public func dismiss() {
            self.custom!.dimiss()
        }
        
        
    }
}
