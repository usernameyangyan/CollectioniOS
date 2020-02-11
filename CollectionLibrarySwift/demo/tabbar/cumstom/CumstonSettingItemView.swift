//
//  CumstonSettingItemView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CumstonSettingItemView:YYTabBarItemContentView{
    public var duration = 0.3

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor=UIColor.black
        highlightTextColor=UIColor.red
        iconColor=UIColor.black
        highlightIconColor=UIColor.red
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}


class CumstonRemindItemView: CumstonSettingItemView {
    
    var tipsImageView: UIImageView = {
        let tipsImageView = UIImageView.init(image: UIImage.init(named: "tips")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 10, left: 10, bottom: 25, right: 25), resizingMode: UIImage.ResizingMode.stretch))
        return tipsImageView
    }()
    
    var tipsLabel: UILabel = {
        let tipsLabel = UILabel.init(frame: CGRect.zero)
        tipsLabel.text = "点击查看"
        tipsLabel.font = UIFont.systemFont(ofSize: 14.0)
        tipsLabel.textColor = UIColor.white
        return tipsLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tipsImageView)
        self.addSubview(self.tipsLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tipsImageView.frame = CGRect.init(x: bounds.size.width - 92, y: -38, width: 92, height: 36)
        tipsLabel.sizeToFit()
        tipsLabel.center = CGPoint.init(x: tipsImageView.center.x, y: tipsImageView.center.y - 3)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func hideRemindTip() {
        tipsLabel.isHidden=true
        tipsImageView.isHidden=true
    }
}

class CumstonAnimateWithTipsContentView: CumstonSettingItemView {

    
    override func badgeChangedAnimation(animated: Bool, completion: (() -> ())?) {
        super.badgeChangedAnimation(animated: animated, completion: nil)
        notificationAnimation()
    }
    
    func notificationAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        impliesAnimation.values = [0.0 ,-8.0, 4.0, -4.0, 3.0, -2.0, 0.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}

class CumstonAnimateWithNumContentView: CumstonSettingItemView {
    
    override func badgeChangedAnimation(animated: Bool, completion: (() -> ())?) {
          super.badgeChangedAnimation(animated: animated, completion: nil)
          notificationAnimation()
      }
    
    func notificationAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        self.badgeView.layer.add(impliesAnimation, forKey: nil)
    }
}


class CumstonAnimateWithImgContentView: CumstonSettingItemView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        badgeColor = UIColor.clear
        badgeView.imageView.image = UIImage.init(named: "tips2")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 10, left: 10, bottom: 25, right: 25)).withRenderingMode(.alwaysTemplate)
        badgeView.tintColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
