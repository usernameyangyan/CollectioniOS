//
//  MultiLanguageViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/11/17.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class MultiLanguageViewController:UIViewController{
    
    
    let labelWidth:CGFloat=150
    
    
    lazy var simpleLanguageLabel:UILabel={
        let simpleLanguageLabel=UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2 - 150/2, y:20, width:150 , height: 60))
        simpleLanguageLabel.numberOfLines=0
        simpleLanguageLabel.text=InternationalUtils.getInstance.getString("change_language_s")
        simpleLanguageLabel.backgroundColor=UIColor.lightGray
        simpleLanguageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        simpleLanguageLabel.font=UIFont.systemFont(ofSize: 15)
        simpleLanguageLabel.layer.cornerRadius=6.0
        simpleLanguageLabel.clipsToBounds=true
        simpleLanguageLabel.textAlignment = .center
        simpleLanguageLabel.tag=0
        let tap = UITapGestureRecognizer.init(target:self,action:#selector(clikButton(tap:)))
        //绑定tap
        simpleLanguageLabel.addGestureRecognizer(tap)
        simpleLanguageLabel.isUserInteractionEnabled=true
        
        return simpleLanguageLabel
    }()
    
    
    lazy var trLanguageLabel:UILabel={
        let trLanguageLabel=UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2 - 150/2, y:simpleLanguageLabel.frame.origin.y+80, width:150 , height: 60))
        trLanguageLabel.numberOfLines=0
        trLanguageLabel.text=InternationalUtils.getInstance.getString("change_language_t")
        trLanguageLabel.backgroundColor=UIColor.lightGray
        trLanguageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        trLanguageLabel.font=UIFont.systemFont(ofSize: 15)
        trLanguageLabel.layer.cornerRadius=6.0
        trLanguageLabel.clipsToBounds=true
        trLanguageLabel.textAlignment = .center
        trLanguageLabel.tag=1
        
        let tap = UITapGestureRecognizer.init(target:self,action:#selector(clikButton(tap:)))
        //绑定tap
        trLanguageLabel.addGestureRecognizer(tap)
        trLanguageLabel.isUserInteractionEnabled=true
        
        return trLanguageLabel
    }()
    
    
    
    lazy var enLanguageLabel:UILabel={
        let enLanguageLabel=UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2 - 150/2, y:trLanguageLabel.frame.origin.y+80, width:150 , height: 60))
        enLanguageLabel.numberOfLines=0
        enLanguageLabel.text=InternationalUtils.getInstance.getString("change_language_e")
        enLanguageLabel.backgroundColor=UIColor.lightGray
        enLanguageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        enLanguageLabel.font=UIFont.systemFont(ofSize: 15)
        enLanguageLabel.layer.cornerRadius=6.0
        enLanguageLabel.clipsToBounds=true
        enLanguageLabel.textAlignment = .center
        enLanguageLabel.tag=2
        
        
        let tap = UITapGestureRecognizer.init(target:self,action:#selector(clikButton(tap:)))
        //绑定tap
        enLanguageLabel.addGestureRecognizer(tap)
        enLanguageLabel.isUserInteractionEnabled=true
        
        
        
        return enLanguageLabel
    }()
    
    
    lazy var useTip:UILabel={
        //行间隔
        let useTip = UILabel()
        
        useTip.textColor=UIColor.orange
        
        
        let str:String=InternationalUtils.getInstance.getString("switch_language_tip")
        
        //开启自动换行
        useTip.numberOfLines = 0
        useTip.lineBreakMode = NSLineBreakMode.byWordWrapping
        useTip.text=str
        
        
        useTip.frame = CGRect(x: 20, y: enLanguageLabel.frame.origin.y+100, width: self.view.frame.width - 40, height: UILabelUtils.getLabHeigh(labelStr: str, font: useTip.font, width: self.view.frame.width - 40,lineSpacing: 0))
        
        
        return useTip
        
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("language_setting"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        
        let scrollView=UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(simpleLanguageLabel)
        scrollView.addSubview(trLanguageLabel)
        scrollView.addSubview(enLanguageLabel)
        scrollView.addSubview(useTip)
        
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+useTip.frame.height)
        
    }
    
    
    
    @objc func clikButton(tap:UITapGestureRecognizer) {
        ColorUtils.clickSelectBgChange(view: tap.view!, selectColor: UIColor.colorWithHexString("#E5E5E5"), unSelectColor: UIColor.lightGray)
        
        
        let pos=tap.view?.tag
        switch pos {
        case 0:
            InternationalUtils.getInstance.setLanguage(.Chinese,MainViewController())
        case 1:
            InternationalUtils.getInstance.setLanguage(.Traditional,MainViewController())
        case 2:
            InternationalUtils.getInstance.setLanguage(.English,MainViewController())
        default:
            break
        }
    }
    
}





