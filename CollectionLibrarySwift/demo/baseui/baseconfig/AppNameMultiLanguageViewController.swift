//
//  AppNameMultiLanguageViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/11/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class AppNameMultiLanguageViewController: UIViewController {
    
    
    lazy var tipLanguageLabel:UILabel={
        let tipLanguageLabel=UILabel(frame: CGRect(x: 20, y:IPhoneUtils.BAR_HEIGHT, width:UIScreen.main.bounds.width-40 , height: 200))
        tipLanguageLabel.numberOfLines=0
        tipLanguageLabel.text=InternationalUtils.getInstance.getString("app_name_change_tip")
        tipLanguageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        tipLanguageLabel.font=UIFont.systemFont(ofSize: 15)
        tipLanguageLabel.textColor=UIColor.orange
        
        return tipLanguageLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("app_language_setting"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        
        self.view.addSubview(tipLanguageLabel)
        
    }
    
}

