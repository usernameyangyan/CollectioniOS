//
//  ColorUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/11/12.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit


open class ColorUtils{
    //MARK:item或者按钮点击颜色变化
    static func clickSelectBgChange(view:UIView,selectColor:UIColor,unSelectColor:UIColor){
        view.backgroundColor = selectColor
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1 ){
            view.backgroundColor =  unSelectColor;
            
        }
    }
}

//MARK:16进制颜色的转化
extension UIColor{
    //MARK: - RGB
    class func RGBColor(red : CGFloat, green : CGFloat, blue :CGFloat ) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha:1)
    }
    class func RGBColor(_ RGB:CGFloat) -> UIColor {
        return RGBColor(red: RGB, green: RGB, blue: RGB)
    }
    //MARK: - 16进制字符串转UIColor
    class func colorWithHexString(_ hex:String) ->UIColor {
        return colorWithHexString(hex, alpha:1)
    }
    class func colorWithHexString (_ hex:String, alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from:1)
        } else if (cString.hasPrefix("0X") || cString.hasPrefix("0x")) {
            cString = (cString as NSString).substring(to: 2)
        }
        if ((cString as NSString).length != 6) {
            return gray
        }
        let rString = (cString as NSString).substring(to:2)
        let gString = ((cString as NSString).substring(from:2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from:4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
}
