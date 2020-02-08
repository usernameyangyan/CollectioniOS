//
//  TabBarIrregularityController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class TabBarIrregularityController:YYTabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let normalImgs=["home","find","photo_verybig","message","me"]
        let selectImgs=["home_1","find_1","photo_verybig","message_1","me_1"]
        let titles=["首页","搜索","拍照","消息","我的"]
        let chidVC=[CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController()]
        
        
        let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .defultStyle()
            .irregularity()
            .setIrregularityIndex(irregularIndex: 2)
            .setIrregularityBorderColor(borderColor: UIColor.white)
            .setIrregularityBackgroundColor(backgroundColor: UIColor.systemGreen)
            .retunDefaultStyle()
            .setSelectTextColor(selectTxtColor: UIColor.red)
            .setSelectImgColor(selectImageColor: UIColor.red)
            .build()
        
        let tab:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)
        tab.setTabBarBackgroundImage(backgroundImage: UIImage(named: "background_dark"))
        tab.setShouldHijackHandler(shouldHijackHandler:{
            tabBarController,viewController,index in
            
            if(index==2){
                return true
            }else{
                return false
            }
            
        })
        
        tab.setDidHijackhHandler(didHijackHandler: {
            tabBarController,viewController,index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                alertController.addAction(takePhotoAction)
                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                alertController.addAction(selectFromAlbumAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
        
    }
    
    
}
