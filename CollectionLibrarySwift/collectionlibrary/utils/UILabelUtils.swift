//
//  UILabelUtils.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/17.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class UILabelUtils{
    
    //动态设置行高的方法
    static func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat,lineSpacing:CGFloat=0) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        //这里这个height随便给，设为0也可以
        let size = CGSize(width: width, height: 9999)
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //行间距设置
        paraph.lineSpacing = lineSpacing
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle: paraph]
        //boundingRect函数只有NSString可以用
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return strSize.height
        
    }
}
