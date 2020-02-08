//
//  ViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/9/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//I

import UIKit

class ViewController: IBaseViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        navBar.setBackBtnHidden(hidden: true)
        navBar.title="导航栏"
        navBar.titleColor=UIColor.white
        navBar.onRightNavItemClick={(position)->Void in
            print("dainji")
            
        }
        navBar.barBackgroundImage=UIImage(named: "bg")
        navBar.setRightNavItemBtns(imgs: ["back_btn"], spaceing: 0)
        statusBarStyle = .lightContent
    
    }

}

