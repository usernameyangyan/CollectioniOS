//
//  CommonWithoutNavController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CommonWithoutNavController:UIViewController{
    let str="因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。曾经你是我的理想，可是后来我终于发现，我自己的理想原来不过如此，和所有人的一样没什么了不起，和所有人的一样不堪一击。但是你依然是你，你还在那儿，你绽放着，你比任何一种理想都要有血有肉，都要生机勃勃。"
    
    lazy var centerLabel:UILabel={
        let centerLabel=UILabel.init()
        centerLabel.text=str
        centerLabel.textAlignment = .center
        centerLabel.numberOfLines=0
        centerLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        return centerLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setHidden(isHidden: true)
            .build()
        
        self.view.addSubview(centerLabel)
        
        centerLabel
            .centerX(equalTo: view.yy_centerX)
            .centerY(equalTo: view.yy_centerY)
            .width(UIScreen.main.bounds.width-20)
            .height(500)
            .build()
        
    }
    
    
    
}
