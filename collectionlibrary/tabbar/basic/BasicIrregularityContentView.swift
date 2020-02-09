//
//  BasicIrregularityContentView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/28.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class BasicIrregularityContentView:YYTabBarItemContentView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.superview?.bringSubviewToFront(self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }

  

    public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    
    func setBasicSetting(tabBuilder:TabBarBasicParamBuilder,specialIndex:Int){
        textColor=tabBuilder.defultStyle().getTextColor()
        highlightTextColor=tabBuilder.defultStyle().getSelectTextColor()
        highlightIconColor=tabBuilder.defultStyle().getSelectImgColor()
        iconColor=tabBuilder.defultStyle().getImgColor()
        
        self.imageView.backgroundColor = tabBuilder.defultStyle().irregularity().getIrregularityBackgroundColor()
        self.imageView.layer.borderWidth = tabBuilder.defultStyle().irregularity().getIrregularityBorderWidth()
        self.imageView.layer.borderColor = tabBuilder.defultStyle().irregularity().getIrregularityBorderColor().cgColor
        self.imageView.layer.cornerRadius = 35
        self.insets = UIEdgeInsets.init(top: -32, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        
        
        if(specialIndex==tabBuilder.defultStyle().getRemindUseClickIndex()){
            let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(playImpliesAnimation(_:)), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        }
    
    }
    
    @objc internal func playImpliesAnimation(_ sender: AnyObject?) {
        if self.selected == true || self.highlighted == true {
            return
        }
        let view = self.imageView
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.15, 0.8, 1.15]
        impliesAnimation.duration = 0.3
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        impliesAnimation.isRemovedOnCompletion = true
        view.layer.add(impliesAnimation, forKey: nil)
    }
}
