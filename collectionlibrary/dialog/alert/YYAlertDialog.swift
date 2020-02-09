//
//  YYAlertDialog.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/9.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

public typealias YYAlertViewClickButtonBlock = ((_ alertView:YYDefaultAlertDialog)->Void)?

public enum YYShowBtnStyle{
    case sbumit
    case cancel
    case both
}

//MARK:默认内容框
class YYDefalutAlertContentView:BaseDialogContentView{
    
    private var baseDialog:BaseDialog?
    
    private var showBtnType:YYShowBtnStyle=YYShowBtnStyle.both
    
    var clickSubmitBlock:YYAlertViewClickButtonBlock=nil
    var clickCancelBlock:YYAlertViewClickButtonBlock=nil
    
    //MAKR:默认加载宽
    /**标题视图 */
    lazy var labelTitle:UILabel={
        let labelTitle=UILabel.init()
        labelTitle.textColor = UIColor.black
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 0
        labelTitle.font = UIFont.systemFont(ofSize: 20)
        
        return labelTitle
    }()
    
    
    lazy var labelMessage:UILabel={
        let labelMessage = UILabel.init()
        labelMessage.textColor = UIColor.black
        labelMessage.textAlignment = .center
        labelMessage.numberOfLines = 0
        labelMessage.font = UIFont.systemFont(ofSize: 16)
        
        return labelMessage
    }()
    
    
    
    lazy var lineH:UIView={
        let lineV = UIView.init()
        lineV.backgroundColor=UIColor.lightGray
        return lineV
    }()
    
    lazy var lineV:UIView={
        let lineV = UIView.init()
        lineV.backgroundColor=UIColor.lightGray
        return lineV
    }()
    
    lazy var cancelBtn:UIButton={
        let button = UIButton(type: .custom)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(cancelBtn(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var submitBtn:UIButton={
        let button = UIButton(type: .custom)
        button.setTitle("确定", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(submitBtn(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    
    
    convenience init(baseDialog:BaseDialog){
        self.init()
        self.baseDialog=baseDialog
        self.commonint()
    }
    
    
    fileprivate func commonint(){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius  = 10
        self.layer.masksToBounds = true
        
        labelMessage.frame = CGRect(x: 16, y: 22, width: _contentWidth-32, height: 0)
        self.addSubview(labelTitle)
        self.addSubview(labelMessage)
        self.addSubview(lineH)
        self.addSubview(submitBtn)
        self.addSubview(lineV)
        self.addSubview(cancelBtn)
    }
    
    
    @objc func submitBtn(sender:UIButton){
        dimiss()
        
        if(clickSubmitBlock != nil){
            clickSubmitBlock!(baseDialog as! YYDefaultAlertDialog)
        }
        
    }
    
    @objc func cancelBtn(sender:UIButton){
        dimiss()
        
        if(clickCancelBlock != nil){
            clickCancelBlock!(baseDialog as! YYDefaultAlertDialog)
        }
    }
    
    
    
    
    
    func setContentViewWidth(width:CGFloat){
        _contentWidth = width
    }
    
    func setContentViewBackgroundColor(color:UIColor){
        backgroundColor=color
    }
    
    
    func setTitleColor(color:UIColor){
        labelTitle.textColor=color
    }
    
    func setTitleSize(ofSize:CGFloat){
        labelTitle.font = UIFont.systemFont(ofSize: ofSize)
    }
    
    func setContentColor(color:UIColor) {
        labelMessage.textColor=color
    }
    
    func setContentSize(ofSize:CGFloat) {
        labelMessage.font = UIFont.systemFont(ofSize: ofSize)
    }
    
    func setAnimationOption(animationOption:YYDialogAnimationOptions){
        self.animationOption=animationOption
    }
    
    func setCornerRadius(radius:CGFloat){
        self.layer.cornerRadius  = radius
    }
    
    func setSubmitButtonListener(clickSubmitBlock:YYAlertViewClickButtonBlock?) {
        self.clickSubmitBlock=clickSubmitBlock!
    }
    
    
    func setCancleButtonListener(clickCancelBlock:YYAlertViewClickButtonBlock) {
        self.clickCancelBlock=clickCancelBlock
    }
    
    func setButtonType(btnType:YYShowBtnStyle) {
        showBtnType=btnType
    }
    
    
    func setSubmitBtnBackgroundColor(color:UIColor)  {
        submitBtn.backgroundColor=color
    }
    
    func setSubmitBtnContent(title:String) {
        submitBtn.setTitle(title, for: .normal)
    }
    
    func setSubmitBtnContentColor(color:UIColor) {
        submitBtn.setTitleColor(color, for: .normal)
    }
    
    func setSubmitBtnSize(ofSize:CGFloat){
        submitBtn.titleLabel?.font=UIFont.systemFont(ofSize: ofSize)
    }
    
    
    func setCancelBtnBackgroundColor(color:UIColor) {
        cancelBtn.backgroundColor=color
    }
    
    func setCancelBtnContent(title:String){
        cancelBtn.setTitle(title, for: .normal)
    }
    
    func setCancelBtnContentColor(color:UIColor) {
        cancelBtn.setTitleColor(color, for: .normal)
    }
    
    func setCancelBtnSize(ofSize:CGFloat) {
        cancelBtn.titleLabel?.font=UIFont.systemFont(ofSize: ofSize)
    }
    
    
    func setButtonState(){
        if(showBtnType == .sbumit){
            cancelBtn.isHidden=true
            submitBtn.isHidden=false
            lineV.isHidden=true
            
            submitBtn.frame = CGRect(x: 0, y: lineH.frame.maxY, width:_contentWidth, height: 50)
            
            _contentHeight=submitBtn.frame.origin.y+submitBtn.frame.height
            
            self.frame=CGRect(x: (frame.origin.x), y: frame.origin.y, width: _contentWidth, height:_contentHeight)
            self.center = CGPoint(x: baseDialog!._screenWidth/2, y: baseDialog!._screenHeight/2)
        }else if(showBtnType == .both){
            cancelBtn.isHidden=false
            submitBtn.isHidden=false
            lineV.isHidden=false
            submitBtn.frame = CGRect(x: 0, y: lineH.frame.maxY, width:_contentWidth/2-0.25, height: 50)
            lineV.frame = CGRect(x: _contentWidth/2 , y: lineH.frame.maxY, width:0.5, height: submitBtn.frame.size.height)
            
            cancelBtn.frame = CGRect(x: _contentWidth/2+0.25, y: lineH.frame.maxY, width:_contentWidth/2 , height: 50)
            
            _contentHeight=submitBtn.frame.origin.y+submitBtn.frame.height
            
            self.frame=CGRect(x: (frame.origin.x), y: (frame.origin.y), width: _contentWidth, height:_contentHeight)
            self.center = CGPoint(x: baseDialog!._screenWidth/2, y: baseDialog!._screenHeight/2)
        }else if(showBtnType == .cancel){
            submitBtn.isHidden=true
            cancelBtn.isHidden=false
            lineV.isHidden=true
            
            cancelBtn.frame = CGRect(x: 0, y: lineH.frame.maxY, width:_contentWidth, height: 50)
            
            
            _contentHeight=cancelBtn.frame.origin.y+cancelBtn.frame.height
            self.frame=CGRect(x: (frame.origin.x), y: frame.origin.y, width: _contentWidth, height:_contentHeight)
            self.center = CGPoint(x:baseDialog!._screenWidth/2, y: baseDialog!._screenHeight/2)
        }
    }
    
}



//MARK:默认
open class YYDefaultAlertDialog:BaseDialog{
    
    /** 显示的数据 */
    private var _title:String!
    private var _message:String?
    
    
    var defaultContentView:YYDefalutAlertContentView?
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        defaultContentView=YYDefalutAlertContentView(baseDialog: self)
        addContentView(_dialogContentView: defaultContentView!)
        defaultContentView!.setParentView(parentView: self)
        showMaskLayer=true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    public func setContentViewWidth(width:CGFloat)->YYDefaultAlertDialog{
        defaultContentView!.setContentViewWidth(width: width)
        return self
    }
    
    public func setContentViewBackgroundColor(color:UIColor)->YYDefaultAlertDialog{
        defaultContentView!.setContentViewBackgroundColor(color: color)
        return self
    }
    
    
    public func setTitleColor(color:UIColor)->YYDefaultAlertDialog{
        defaultContentView!.setTitleColor(color: color)
        return self
    }
    
    public func setTitleSize(ofSize:CGFloat)->YYDefaultAlertDialog{
        defaultContentView!.setTitleSize(ofSize: ofSize)
        return self
    }
    
    public func setContentColor(color:UIColor) -> YYDefaultAlertDialog {
        defaultContentView!.setContentColor(color: color)
        return self
    }
    
    public func setContentSize(ofSize:CGFloat) -> YYDefaultAlertDialog {
        defaultContentView?.labelMessage.font = UIFont.systemFont(ofSize: ofSize)
        return self
    }
    
    public func setAnimationOption(animationOption:YYDialogAnimationOptions)->YYDefaultAlertDialog{
        defaultContentView!.setAnimationOption(animationOption: animationOption)
        return self
    }
    
    public func setMaskLayer(showMaskLayer:Bool)->YYDefaultAlertDialog{
        self.showMaskLayer=showMaskLayer
        if(showMaskLayer){
            _effectView.alpha=maskLayerAlpha
        }else{
            _effectView.alpha=0.0
        }
        
        return self
        
    }
    
    public func setMaskLayerAlpha(alpha:CGFloat)->YYDefaultAlertDialog{
        maskLayerAlpha=alpha
        _effectView.alpha = maskLayerAlpha
        
        return self
    }
    
    
    
    public func setSubmitButtonListener(clickSubmitBlock:YYAlertViewClickButtonBlock?) -> YYDefaultAlertDialog {
        defaultContentView!.setSubmitButtonListener(clickSubmitBlock: clickSubmitBlock)
        return self
    }
    
    
    public func setCancleButtonListener(clickCancelBlock:YYAlertViewClickButtonBlock) -> YYDefaultAlertDialog {
        defaultContentView!.setCancleButtonListener(clickCancelBlock: clickCancelBlock)
        return self
    }
    
    public func setButtonType(btnType:YYShowBtnStyle) -> YYDefaultAlertDialog {
        defaultContentView!.setButtonType(btnType: btnType)
        return self
    }
    
    public func setSubmitBtnBackgroundColor(color:UIColor) -> YYDefaultAlertDialog {
        defaultContentView!.setSubmitBtnBackgroundColor(color: color)
        return self
    }
    
    public func setSubmitBtnContent(title:String) -> YYDefaultAlertDialog {
        defaultContentView!.setSubmitBtnContent(title: title)
        return self
    }
    
    public func setSubmitBtnContentColor(color:UIColor) -> YYDefaultAlertDialog {
        defaultContentView!.setSubmitBtnContentColor(color: color)
        return self
    }
    
    public func setSubmitBtnSize(ofSize:CGFloat) -> YYDefaultAlertDialog {
        defaultContentView!.setSubmitBtnSize(ofSize: ofSize)
        return self
    }
    
    
    public func setCancelBtnBackgroundColor(color:UIColor) -> YYDefaultAlertDialog {
        defaultContentView!.setCancelBtnBackgroundColor(color: color)
        return self
    }
    
    public func setCancelBtnContent(title:String) -> YYDefaultAlertDialog {
        defaultContentView!.setCancelBtnContent(title: title)
        return self
    }
    
    public func setCancelBtnContentColor(color:UIColor) -> YYDefaultAlertDialog {
        defaultContentView!.setCancelBtnContentColor(color: color)
        return self
    }
    
    public func setCancelBtnSize(ofSize:CGFloat) -> YYDefaultAlertDialog {
        defaultContentView!.setCancelBtnSize(ofSize: ofSize)
        return self
    }
    
    public func setCornerRadius(radius:CGFloat)->YYDefaultAlertDialog{
        defaultContentView!.setCornerRadius(radius: radius)
        return self
    }
    
    
    public func show(title:String,message:String){
        //标题
        _title          = title
        defaultContentView?.labelTitle.text   = _title
        let labelX:CGFloat = 10
        let labelY:CGFloat = 20
        let labelW:CGFloat = defaultContentView!._contentWidth - 2*labelX
        defaultContentView!.labelTitle.sizeToFit()
        let size = defaultContentView!.labelTitle.frame.size
        defaultContentView!.labelTitle.frame = CGRect(x: labelX, y: labelY, width: labelW, height: size.height)
        //消息
        _message        = message
        defaultContentView!.labelMessage.text = _message
        defaultContentView!.labelMessage.sizeToFit()
        
        let sizeMessage = defaultContentView!.labelMessage.frame.size
        defaultContentView!.labelMessage.frame = CGRect(x: labelX, y: defaultContentView!.labelTitle.frame.maxY+10, width: labelW, height: sizeMessage.height)
        
        defaultContentView!.lineH.frame = CGRect(x: 0, y: defaultContentView!.labelMessage.frame.maxY+10, width:defaultContentView!._contentWidth , height: 0.5)
        
        defaultContentView!.setButtonState()
        self.show()
    }
    
}






open class YYAlertDialog{
    
    
    public func defalutDialog()->YYDefaultAlertDialog{
        return YYDefaultAlertDialog()
        
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
        
        
    }
    
    
}
