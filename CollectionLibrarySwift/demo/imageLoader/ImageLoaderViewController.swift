//
//  ImageLoaderViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/8.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

class ImageLoaderViewController:UIViewController{
    
    
    let oneTip:UILabel={
        let oneTip:UILabel=UILabel.init()
        oneTip.textColor=UIColor.red
        oneTip.text="加载普通网络图片"
        oneTip.font=UIFont.systemFont(ofSize: 18)
        return oneTip
    }()
    
    
    let onImageView:UIImageView={
        let onImageView=UIImageView.init()
        onImageView.layer.cornerRadius = 75
        onImageView.layer.masksToBounds = true
        onImageView.loadImage(urlString: "http://file02.16sucai.com/d/file/2014/0704/e53c868ee9e8e7b28c424b56afe2066d.jpg")
        return onImageView
    }()
    
    let twoTip:UILabel={
        let twoTip:UILabel=UILabel.init()
        twoTip.textColor=UIColor.red
        twoTip.text="加载gif图片"
        twoTip.font=UIFont.systemFont(ofSize: 18)
        return twoTip
    }()
    
    
    let twoImageView:UIImageView={
        let twoImageView=UIImageView.init()
        twoImageView.layer.cornerRadius = 75
        twoImageView.layer.masksToBounds = true
        twoImageView.loadImage(urlString: "https://n.sinaimg.cn/tech/transform/8/w334h474/20200107/57f4-imvsvyz4459804.gif",placeholder: UIImage.init(named: "b"))
        return twoImageView
    }()
    
    
    let threeTip:UILabel={
        let threeTip:UILabel=UILabel.init()
        threeTip.textColor=UIColor.red
        threeTip.text="自定义加载图片参数(不设置缓存)"
        threeTip.font=UIFont.systemFont(ofSize: 18)
        return threeTip
    }()
    
    
    let threeImageView:UIImageView={
        let threeImageView=UIImageView.init()
        threeImageView.layer.cornerRadius = 75
        threeImageView.layer.masksToBounds = true
        
        
        //自定义占位图、请求超时(现在是局部设置，也可以通过YYImageCache.shared全局设置)
        
        let urlRequest:URLRequest=URLRequest(url: URL.init(string: "https://f.sinaimg.cn/tech/transform/244/w430h614/20200107/98dc-imvsvyz4458741.gif")!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60)
        
        threeImageView.loadImage(request: urlRequest, placeholder: UIImage.init(named: "b"), completion: nil)
        
        return threeImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: InternationalUtils.getInstance.getString("imageLoader"))
            .build()
        
        let scrollView=UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(scrollView)
        
        PositionSettingUtils.position(aboveView: self.navigation.bar, childView: scrollView, style: .fixed)
        
        scrollView.addSubview(oneTip)
        scrollView.addSubview(onImageView)
        scrollView.addSubview(twoTip)
        scrollView.addSubview(twoImageView)
        scrollView.addSubview(threeTip)
        scrollView.addSubview(threeImageView)
        
        oneTip
            .top(equalTo: scrollView.yy_top,constant: 30)
            .centerX(equalTo: scrollView.yy_centerX)
            .height(40)
            .build()
        
        onImageView
            .top(equalTo: oneTip.yy_bottom,constant: 10)
            .centerX(equalTo: scrollView.yy_centerX)
            .height(150)
            .width(150)
            .build()
        
        twoTip
            .top(equalTo: self.onImageView.yy_bottom,constant: 10)
            .centerX(equalTo: scrollView.yy_centerX)
            .height(40)
            .build()
        
        twoImageView
            .top(equalTo: twoTip.yy_bottom,constant: 10)
            .centerX(equalTo: scrollView.yy_centerX)
            .height(150)
            .width(150)
            .build()
        
        
        threeTip
            .top(equalTo: self.twoImageView.yy_bottom,constant: 10)
            .centerX(equalTo: scrollView.yy_centerX)
            .height(40)
            .build()
        
        threeImageView
            .top(equalTo: threeTip.yy_bottom,constant: 10)
            .centerX(equalTo: scrollView.yy_centerX)
            .height(150)
            .width(150)
            .build()
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollView.frame.origin.y+620)
    }
}
