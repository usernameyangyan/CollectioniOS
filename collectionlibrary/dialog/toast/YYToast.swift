//
//  YYToast.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/12.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

open class YYToast{
    private static var toastContentViews:[UIView]=[UIView]()
    
    //Toast展示的时间
    public enum Duration {
        case short
        case long
        case custom(TimeInterval)
    }
    //Toast展示的位置
    public enum Gravity {
        case center
        case bottom
    }
    
    ///Toast提示内容文本
    private var text:String?
    
    ///Toast弹出位置(默认为枚举量.center)
    private var gravity:Gravity = .bottom
    
    func setGravity(gravity:Gravity) -> YYToast {
        self.gravity=gravity
        return self
    }
    
    ///Toast持续时间(默认为枚举量.short)
    private var duration:Duration = .short
    
    func setDuration(duration:Duration) -> YYToast {
        self.duration=duration
        return self
    }
    
    ///Toast内边距(默认值)
    private var padding:CGFloat = 15
    
    ///字体大小
    private var fontSize:CGFloat=16
    
    func setFontSize(fontSize:CGFloat) -> YYToast {
        self.fontSize=fontSize
        return self
    }
    
    ///Toast圆角(默认值)
    private var cornerRadius:CGFloat = 25
    
    public func setCornerRadius(cornerRadius:CGFloat) ->  YYToast{
        self.cornerRadius=cornerRadius
        return self
    }
    
    private var lineSpacing:CGFloat=10
    public func setLineSpacing(lineSpacing:CGFloat) -> YYToast {
        self.lineSpacing=lineSpacing
        return self
    }
    
    private var textColor:UIColor=UIColor.white
    public func setTextColor(textColor:UIColor) -> YYToast {
        self.textColor=textColor
        return self
    }
    
    private var contentViewBackgroudColor:UIColor=UIColor.black
    public func setContentViewBackgroudColor(contentViewBackgroudColor:UIColor) -> YYToast {
        self.contentViewBackgroudColor=contentViewBackgroudColor
        return self
    }
    
    
    
    
    private var contentView: UIView?
    private var height:CGFloat=0
    
    
    fileprivate func commonint(){
        contentView = UIView()
        contentView!.backgroundColor = contentViewBackgroudColor
        contentView!.layer.cornerRadius = cornerRadius
        contentView!.layer.masksToBounds = true
        let label:UILabel = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = textColor
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width-40
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize),
                          NSAttributedString.Key.paragraphStyle: paraph]
        label.attributedText = NSAttributedString(string: self.text!, attributes: attributes)
        contentView!.addSubview(label)
        
        label
            .left(equalTo: contentView!.yy_left,constant: padding)
            .right(equalTo: contentView!.yy_right,constant: padding)
            .bottom(equalTo: contentView!.yy_bottom,constant: padding)
            .top(equalTo: contentView!.yy_top,constant: padding)
            .build()
       
        label.sizeToFit()
        height=label.frame.height
    }
    
    private func removeToastView(){
        for view in YYToast.toastContentViews{
            view.alpha = 0.0;
        }
        YYToast.toastContentViews.removeAll()
    }
    
    ///展示一个Toast视图
    public func show(view:UIView,text:String) -> Void {
        self.text = text;
        commonint()
        removeToastView()
        YYToast.toastContentViews.append(contentView!)
        view.addSubview(contentView!)
        let height=UILabelUtils.getLabHeigh(labelStr: self.text!, font: UIFont.systemFont(ofSize: fontSize), width: UIScreen.main.bounds.width-40,lineSpacing: lineSpacing)+padding*2+self.height
        
        
        switch gravity {
        case .center:
            contentView!
                .centerX(equalTo: view.yy_centerX)
                .centerY(equalTo: view.yy_centerY)
                .height(height)
                .build()
        default:
            contentView!
                .centerX(equalTo: view.yy_centerX)
                .bottom(equalTo: view.yy_bottom,constant: UIScreen.main.bounds.height/10)
                .height(height)
                .build()
            break
        }
        
        ///动画
        contentView!.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        contentView!.alpha = 0.0;
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
            self.contentView!.transform = CGAffineTransform.identity;
            self.contentView!.alpha = 1.0;
        }) { (finished) in
            
        }
        ///展示时间
        var time: TimeInterval
        switch duration {
        case .short:
            time = 1.5
            break
        case .long:
            time = 3.0
            break
        case .custom(let customTime):
            time = customTime
            break
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            UIView.animate(withDuration: 0.25, animations: {
                self.contentView!.alpha = 0.0
            }, completion: { (finished) in
                self.contentView!.removeFromSuperview()
            })
            
        }
        
    }
}
