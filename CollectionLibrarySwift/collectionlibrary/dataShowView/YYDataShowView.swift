//
//  YYDataShowView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

class YYDataShowView:UIView{
    typealias YYReloadAction = () -> Void
    fileprivate var reloadHandler: YYReloadAction?
    
    convenience init(defaultDataShowViewParams:DefaultDataShowViewParams,visibileHeight:CGFloat?=UIScreen.main.bounds.height,aboveView:UIView?=nil,reloadHandler: YYReloadAction? = nil){
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let centerView=UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        self.addSubview(centerView)
        if(reloadHandler != nil){
            self.reloadHandler=reloadHandler
        }
        
        
        let showText:UILabel = UILabel()
        showText.textAlignment = .center
        showText.numberOfLines = 0
        showText.textColor = defaultDataShowViewParams.getDefaultShowTextColor()
        showText.preferredMaxLayoutWidth = UIScreen.main.bounds.width-40
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 10
        
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:defaultDataShowViewParams.getDefaultShowTextSize()),NSAttributedString.Key.paragraphStyle: paraph]
        
        
        var text=""
        var imgHeight:CGFloat=0
        var centerHeight:CGFloat=0
        imgHeight=defaultDataShowViewParams.getDefaultShowImgHeight()
        
        if(defaultDataShowViewParams.getDefaultDataShowViewType() == DefaultDataShowViewParams.ShowViewType.noData ||
            defaultDataShowViewParams.getDefaultDataShowViewType() == DefaultDataShowViewParams.ShowViewType.noNetWork){
            
            let showImg=UIImageView.init()
            centerView.addSubview(showImg)
            
            if(defaultDataShowViewParams.getDefaultDataShowViewType() == DefaultDataShowViewParams.ShowViewType.noData){
                if(defaultDataShowViewParams.getDefaultNoDataShowImg()==""){
                    showImg.isHidden=true
                    imgHeight=0
                }else{
                    showImg.isHidden=false
                    showImg.image=UIImage(named: defaultDataShowViewParams.getDefaultNoDataShowImg())
                    
                }
                
                text=defaultDataShowViewParams.getDefaultShowNoDataText()
            }else if(defaultDataShowViewParams.getDefaultDataShowViewType() == DefaultDataShowViewParams.ShowViewType.noNetWork){
                if(defaultDataShowViewParams.getDefaultNoNetworkShowImg()==""){
                    showImg.isHidden=true
                    imgHeight=0
                }else{
                    showImg.isHidden=false
                    showImg.image=UIImage(named: defaultDataShowViewParams.getDefaultNoNetworkShowImg())
                    
                }
                
                text=defaultDataShowViewParams.getDefaultShowNoNetWorkText()
            }
            
            
            showImg
                .centerX(equalTo: centerView.yy_centerX)
                .top(equalTo: centerView.yy_top)
                .height(imgHeight)
                .width(defaultDataShowViewParams.getDefaultShowImgWidth())
                .build()
            
            
            
            showText.attributedText = NSAttributedString(string: text, attributes: attributes)
            let height=UILabelUtils.getLabHeigh(labelStr: text, font: UIFont.systemFont(ofSize: defaultDataShowViewParams.getDefaultShowTextSize()), width: UIScreen.main.bounds.width-40,lineSpacing: 10)
            centerView.addSubview(showText)
            
            showText
                .centerX(equalTo: centerView.yy_centerX)
                .top(equalTo: showImg.yy_bottom,constant: 10)
                .height(height)
                .build()
            
            let reloadButton=UILabelPadding(withInsets: defaultDataShowViewParams.getDefaultSHowButtonPadding(),
                                            defaultDataShowViewParams.getDefaultSHowButtonPadding(),
                                            defaultDataShowViewParams.getDefaultSHowButtonPadding(),
                                            defaultDataShowViewParams.getDefaultSHowButtonPadding())
            
            reloadButton.layer.cornerRadius=(defaultDataShowViewParams.getDefaultShowButtonCornerRadius())
            reloadButton.layer.masksToBounds = true
            reloadButton.layer.borderColor=defaultDataShowViewParams.getDefaultShowButtonBorderColor().cgColor
            reloadButton.layer.borderWidth=(defaultDataShowViewParams.getDefaultShowButtonBorderWidth())
            reloadButton.textAlignment = .center
            reloadButton.numberOfLines = 0
            reloadButton.textColor = defaultDataShowViewParams.getDefaultShowButtonTextColor()
            reloadButton.backgroundColor = defaultDataShowViewParams.getDefaultShowButtonBackgroundColor()
            
            let par = NSMutableParagraphStyle()
            par.lineSpacing = 10
            let attr = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:(defaultDataShowViewParams.getDefaultShowButtonTextSize())),NSAttributedString.Key.paragraphStyle: par]
            reloadButton.attributedText = NSAttributedString(string: defaultDataShowViewParams.getDefaultShowButtonText(), attributes: attr)
            
            centerView.addSubview(reloadButton)
            
            reloadButton
                .centerX(equalTo: centerView.yy_centerX)
                .top(equalTo: showText.yy_bottom,constant: 15)
                .build()
            
            reloadButton.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target:self,action:#selector(clikButtons(tap:)))
            //绑定tap
            reloadButton.addGestureRecognizer(tap)
            reloadButton.isHidden=(defaultDataShowViewParams.getHiddenShowButton())
            reloadButton.sizeToFit()
            
            centerHeight=imgHeight+25+height+reloadButton.frame.height+defaultDataShowViewParams.getDefaultSHowButtonPadding()*2
            
        }else if(defaultDataShowViewParams.getDefaultDataShowViewType() == DefaultDataShowViewParams.ShowViewType.loading){
            
            let showImg=UIImageView.init()
            centerView.addSubview(showImg)
            
            showImg
                .centerX(equalTo: centerView.yy_centerX)
                .top(equalTo: centerView.yy_top)
                .height(imgHeight)
                .width(defaultDataShowViewParams.getDefaultShowImgWidth())
                .build()
            
            showImg.animationDuration = defaultDataShowViewParams.getDefaulutShowLoadingImgsTimeInterval()
            
            
            var animationImages:[UIImage]=[UIImage]()
            
            for i in 0...(defaultDataShowViewParams.getDefaultLoadingImags().count-1){
                animationImages.append(UIImage(named: defaultDataShowViewParams.getDefaultLoadingImags()[i])!)
            }
            
            showImg.animationImages = animationImages
            showImg.startAnimating()
            
            
            text=defaultDataShowViewParams.getDefaultShowLoadingText()
            
            showText.attributedText = NSAttributedString(string: text, attributes: attributes)
            let height=UILabelUtils.getLabHeigh(labelStr: text, font: UIFont.systemFont(ofSize: defaultDataShowViewParams.getDefaultShowTextSize()), width: UIScreen.main.bounds.width-40,lineSpacing: 10)
            centerView.addSubview(showText)
            
            showText
                .centerX(equalTo: centerView.yy_centerX)
                .top(equalTo: showImg.yy_bottom,constant: 10)
                .height(height)
                .build()
            
            centerHeight=imgHeight+10+height
            
        }
        
        
        if(aboveView != nil){
            PositionSettingUtils.position(visibileHeight: visibileHeight, aboveView:aboveView! , childView: self, style: .fixed)
        }
        
        let y = self.frame.height/2 - centerHeight/2
        
        centerView.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height:centerHeight)
    }
    
    
    
    convenience init(custom:BaseDataShowContentView,visibileHeight:CGFloat?=UIScreen.main.bounds.height,aboveView:UIView?=nil){
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        if(aboveView != nil){
            PositionSettingUtils.position(visibileHeight: visibileHeight, aboveView:aboveView! , childView: self, style: .fixed)
        }
        
        
        let y = self.frame.height/2 - (custom._contentHeight)/2
        custom.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height:custom._contentHeight)
        self.addSubview(custom)
    }
    
    
    func show(parentView:UIViewController){
        parentView.view.addSubview(self)
    }
    
    func hide(){
        self.isHidden=true
        self.removeFromSuperview()
    }
    
    
    @objc func clikButtons(tap:UITapGestureRecognizer) {
        if(reloadHandler != nil){
            reloadHandler!()
        }
    }
}
