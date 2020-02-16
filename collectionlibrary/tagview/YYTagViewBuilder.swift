//
//  YYTagViewBuilder.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/15.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

var tagViewBuilder: YYTagViewBuilder?
var tagView:YYTagVIew?

open class YYTagViewBuilder{
    
    public class func with() -> YYTagViewBuilder {
        tagViewBuilder = YYTagViewBuilder()
        tagView=YYTagVIew()
        return tagViewBuilder!
    }
    
    private init(){
        
    }
    
    
    public func setTagTextColor(color:UIColor)->YYTagViewBuilder{
        tagView?.textColor=color
        return self
    }
    
    public func setTagSelectedTextColor(color:UIColor)->YYTagViewBuilder{
        tagView?.selectedTextColor=color
        return self
    }
    
    public func setTagLineBreakMode(lineBreakMode:NSLineBreakMode)->YYTagViewBuilder{
        tagView?.tagLineBreakMode=lineBreakMode
        return self
    }
    
    public func setTagBackgroundColor(color:UIColor)->YYTagViewBuilder{
        tagView?.tagBackgroundColor=color
        return self
    }
    
    public func setTagSelectBackgroundColor(color:UIColor)->YYTagViewBuilder{
        tagView?.tagHighlightedBackgroundColor=color
        return self
    }
    
    public func setTagCornerRadius(cornerRadius:CGFloat)->YYTagViewBuilder{
        tagView?.cornerRadius=cornerRadius
        return self
    }
    
    public func setTagBorderWidth(borderWidth: CGFloat)->YYTagViewBuilder{
        tagView?.borderWidth=borderWidth
        return self
    }
    
    public func setTagBorderColor(color:UIColor)->YYTagViewBuilder{
        tagView?.borderColor=color
        return self
    }
    
    public func setTagSelectedBorderColor(color:UIColor)->YYTagViewBuilder{
        tagView?.tagHighlightedBackgroundColor=color
        return self
    }
    
    public func setTagHorizontalPadding(padding:CGFloat)->YYTagViewBuilder{
        tagView?.paddingX=padding
        return self
    }
    
    public func setTagVerticalPadding(padding:CGFloat)->YYTagViewBuilder{
        tagView?.paddingY=padding
        return self
    }
    
    public func setTagHorizontalMargin(margin:CGFloat)->YYTagViewBuilder{
        tagView?.marginX=margin
        return self
    }
    
    public func setTagVerticalMargin(margin:CGFloat)->YYTagViewBuilder{
        tagView?.marginY=margin
        return self
    }
    
    public func setTagAlignment(alignment: YYTagVIew.Alignment)->YYTagViewBuilder{
        tagView?.alignment=alignment
        return self
    }
    
    public func setTagShadowColor(color:UIColor)->YYTagViewBuilder{
        tagView?.shadowColor=color
        return self
    }
    
    public func setTagShadowRadius(shadowRadius: CGFloat)->YYTagViewBuilder{
        tagView?.shadowRadius=shadowRadius
        return self
    }
    
    public func setTagShadowOffset(shadowOffset: CGSize)->YYTagViewBuilder{
        tagView?.shadowOffset=shadowOffset
        return self
    }
    
    public func setTagShadowOpacity(shadowOpacity: Float)->YYTagViewBuilder{
        tagView?.shadowOpacity=shadowOpacity
        return self
    }
    
    public func setTagTextFont(textFont: UIFont)->YYTagViewBuilder{
        tagView?.textFont=textFont
        return self
    }
    
    public func setTagItem(_ title: String)->YYTagViewBuilder{
        tagView!.addTagView(tagView!.createNewTagView(title))
        return self
    }
    
    public func setTagItems(_ titles: [String])->YYTagViewBuilder{
        tagView!.addTagViews(titles.map(tagView!.createNewTagView))
        return self
    }

    
    //结束语句
    public func buildTagView() ->YYTagVIew{
       return tagView!
    }
    
}
