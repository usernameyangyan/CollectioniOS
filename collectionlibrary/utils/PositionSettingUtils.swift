//
//  PositionSettingUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit


public class PositionSettingUtils{
    
    public enum PositionStype : Int {
        case fixed
        case adaptive
    }
    
    public static func position(visibileHeight:CGFloat?=UIScreen.main.bounds.height,aboveView:UIView,childView:UIView,style:PositionStype){
        
        if(style == .adaptive){
            childView.frame=CGRect(x: childView.frame.origin.x, y: aboveView.frame.height+aboveView.frame.origin.y, width: childView.frame.width, height: childView.frame.height)
        }else{
            childView.frame=CGRect(x: childView.frame.origin.x, y: aboveView.frame.height+aboveView.frame.origin.y, width: childView.frame.width, height: visibileHeight!-aboveView.frame.height-aboveView.frame.origin.y)
        }
        
    }
}
