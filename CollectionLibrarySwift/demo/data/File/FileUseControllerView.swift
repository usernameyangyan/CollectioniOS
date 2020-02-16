//
//  FileUseControllerView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/14.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class FileUseControllerView:UIViewController{
    lazy var btn1:UIButton={
        
        let btn = UIButton(type: .custom)
        btn.setTitle("保存字符串", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.backgroundColor=UIColor.systemBlue
        btn.layer.cornerRadius=5
        btn.contentEdgeInsets=UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.tag=0
        btn.addTarget(self, action: #selector(submitBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var btn2:UIButton={
        
        let btn = UIButton(type: .custom)
        btn.setTitle("获取字符串", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.backgroundColor=UIColor.systemBlue
        btn.layer.cornerRadius=5
        btn.contentEdgeInsets=UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.tag=1
        btn.addTarget(self, action: #selector(submitBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    
    
    lazy var btn3:UIButton={
        
        let btn = UIButton(type: .custom)
        btn.setTitle("保存bean类", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.backgroundColor=UIColor.systemBlue
        btn.layer.cornerRadius=5
        btn.contentEdgeInsets=UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.tag=2
        btn.addTarget(self, action: #selector(submitBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var btn4:UIButton={
        
        let btn = UIButton(type: .custom)
        btn.setTitle("获取bean类", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.backgroundColor=UIColor.systemBlue
        btn.layer.cornerRadius=5
        btn.contentEdgeInsets=UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.tag=3
        btn.addTarget(self, action: #selector(submitBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(btn4)
        
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: "UserDefaults的使用")
            .build()
        
        btn1
            .top(equalTo: navigation.bar.yy_bottom,constant: 50)
            .centerX(equalTo: view.yy_centerX)
            .build()
        
        btn2
            .top(equalTo: btn1.yy_bottom,constant: 20)
            .centerX(equalTo: view.yy_centerX)
            .build()
        
        btn3
            .top(equalTo: btn2.yy_bottom,constant: 20)
            .centerX(equalTo: view.yy_centerX)
            .build()
        
        btn4
            .top(equalTo: btn3.yy_bottom,constant: 20)
            .centerX(equalTo: view.yy_centerX)
            .build()
        
    }
    
    let appendPath="collection/test.txt"
    let appendBeanPath="collection/test1.txt"
    
    @objc func submitBtn(sender:UIButton){
        switch sender.tag {
        case 0:
            DataManager.DataForFile<String>.saveObjectForFile(appendFolderPathAndFileName:appendPath , object: "123")
            YYDialog.createToast().show(view: self.view, text: "保存成功")
        case 1:
            
        
            let result=DataManager.DataForFile<String>.queryObjectForFile(appendFolderPathAndFileName: appendPath)
            
            if(result.result == nil){
                YYDialog.createToast().show(view: self.view, text: "没有数据")
            }else{
                YYDialog.createToast().show(view: self.view, text: result.result!)
            }
            
            
            
        case 2:
            
            let userDefault=UserDeBean()
            userDefault.name="张三"
            userDefault.age=26
            
            DataManager.DataForFile<UserDeBean>.saveObjectForFile(appendFolderPathAndFileName: appendBeanPath, object: userDefault)
            YYDialog.createToast().show(view: self.view, text: "保存成功")
        case 3:
            
            let result=DataManager.DataForFile<UserDeBean>.queryObjectForFile(appendFolderPathAndFileName: appendBeanPath)
            
            
            if(result.result == nil){
                YYDialog.createToast().show(view: self.view, text: "没有数据")
            }else{
                let str="姓名：\(result.result!.name)"+"   "+"年龄：\(result.result!.age)"
                YYDialog.createToast().show(view: self.view, text: str)
            }
        default:
            break
        }
    }
}
