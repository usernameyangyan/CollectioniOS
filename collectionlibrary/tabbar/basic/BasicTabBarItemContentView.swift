//
//  BasicTabBarItemContentView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/28.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class BasicTabBarItemContentView:YYTabBarItemContentView{
    
    fileprivate var duration = 0.3
    fileprivate var tabBuilder:TabBarBasicParamBuilder?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setBasicSetting(tabBuilder:TabBarBasicParamBuilder,specialIndex:Int){
        self.tabBuilder=tabBuilder
        textColor=tabBuilder.defultStyle().getTextColor()
        highlightTextColor=tabBuilder.defultStyle().getSelectTextColor()
        iconColor=tabBuilder.defultStyle().getImgColor()
        highlightIconColor=tabBuilder.defultStyle().getSelectImgColor()
        
        if(tabBuilder.defultStyle().getRemindUseClickIndex() == specialIndex){
            let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(playImpliesAnimation(_:)), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        }
        
        
        if(tabBuilder.defultStyle().getClickAnimationStyle() == .backgroundcolorWithoutTitles){
            
            if(tabBuilder.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getSpecialBgColorIndex() == specialIndex){
                iconColor=tabBuilder.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getSpecialImgColor()
                highlightIconColor=tabBuilder.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getSpecialSelectImgColor()
                
                backdropColor=tabBuilder.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getSpecialBgColor()
                highlightBackdropColor=tabBuilder.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getSpecialSelectBgColor()
                
            }else{
                backdropColor=tabBuilder.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getItemBgColor()
                highlightBackdropColor=tabBuilder.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getSelectItemBgColor()
            }
        }
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        
        if(self.tabBuilder!.defultStyle().getClickAnimationStyle() == .bounces){
            self.bounceAnimation()
        }else if(self.tabBuilder!.defultStyle().getClickAnimationStyle() == .backgroundcolorWithoutTitles){
            if(self.tabBuilder!.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getSwithcBouncesAnimation() == true){
                self.bounceAnimation()
            }
        }
        
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        if(self.tabBuilder!.defultStyle().getClickAnimationStyle() == .bounces){
            self.bounceAnimation()
        }else if(self.tabBuilder!.defultStyle().getClickAnimationStyle() == .backgroundcolorWithoutTitles){
            if(self.tabBuilder!.defultStyle().backgroundColorWithoutTitlesAnimationStyle().getSwithcBouncesAnimation() == true){
                self.bounceAnimation()
            }
        }
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
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
