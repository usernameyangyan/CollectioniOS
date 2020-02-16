//
//  SQLiteUseControllerView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/14.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class SQLiteUseControllerView:UIViewController{
    
    lazy var btn1:UIButton={
        
        let btn = UIButton(type: .custom)
        btn.setTitle("保存数据", for: .normal)
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
        btn.setTitle("查询数据", for: .normal)
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
        btn.setTitle("修改数据", for: .normal)
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
        btn.setTitle("删除数据", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.backgroundColor=UIColor.systemBlue
        btn.layer.cornerRadius=5
        btn.contentEdgeInsets=UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.tag=3
        btn.addTarget(self, action: #selector(submitBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var btn5:UIButton={
        
        let btn = UIButton(type: .custom)
        btn.setTitle("异步批量插入数据", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.backgroundColor=UIColor.systemBlue
        btn.layer.cornerRadius=5
        btn.contentEdgeInsets=UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.tag=4
        btn.addTarget(self, action: #selector(submitBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    var commonSqliteData:SqliteData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(btn4)
        self.view.addSubview(btn5)
        
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: "SQLite的使用")
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
        
        btn5
            .top(equalTo: btn4.yy_bottom,constant: 20)
            .centerX(equalTo: view.yy_centerX)
            .build()
        
        
        commonSqliteData=SqliteData()
        commonSqliteData?.id=0
        commonSqliteData?.des="SQLite测试使用"
        
        
        SQLiteVersionMigrate.setDbVersion(dbName:"collectionDB",dbVersion: 0,migrate: {
            oldVersion,newVersion in
            
            for i in oldVersion...newVersion{
                if(i == 1){
                    SQLiteVersionMigrate
                        .with(cls: SqliteData.self)
                        .addAttribute(attribute: "a1", dataType: String.self)
                        .addAttribute(attribute: "a2", dataType: String.self)
                        .build()
                }
            }
            
        })
        
        
    }
    
    
    @objc func submitBtn(sender:UIButton){
        switch sender.tag {
        case 0:
            DataManager.DataForSQLiteDB.Share.insertData(object: commonSqliteData!)
            YYDialog.createToast().show(view: self.view, text: "保存成功")
        case 1:
            
            let result=DataManager.DataForSQLiteDB.QueryData<SqliteData>.queryDataByFirst()
            
            if(result.result == nil){
                YYDialog.createToast().show(view: self.view, text: "没查询到数据")
            }else{
                YYDialog.createToast().show(view: self.view, text: "\(result.result!.des)")
            }
            
            
        case 2:
            commonSqliteData?.des="这是一条更新的内容"
            DataManager.DataForSQLiteDB.Share.updateData(object: commonSqliteData!)
            let result=DataManager.DataForSQLiteDB.QueryData<SqliteData>.queryDataByFirst()
            
            if(result.result == nil){
                YYDialog.createToast().show(view: self.view, text: "没查询到数据")
            }else{
                YYDialog.createToast().show(view: self.view, text: "\(result.result!.des)")
            }
            
        case 3:
            DataManager.DataForSQLiteDB.Share.deleteAllData(cls: SqliteData.self)
            YYDialog.createToast().show(view: self.view, text: "删除成功")
            
        case 4:
            
            DataManager.DataForSQLiteDB.Share.deleteAllData(cls: SqliteData.self)
            
            
            var list:[SqliteData]=[SqliteData]()
            for i in 0...10000{
                let data=SqliteData()
                data.id=i
                data.des="第\(i)条数据已经更新"
                list.append(data)
            }
            
            let loadingView=YYDialog.createLoadingDialog().defalutDialog()
            loadingView.show(message: "正在插入10000条数据")
            
            DataManager.DataForSQLiteDB.Share.insertDataListByAsync(cls: SqliteData.self, objectList: list, insertCompleteBlock: {
                let result=DataManager.DataForSQLiteDB.QueryData<SqliteData>.queryAllData()
                loadingView.dismiss()
                if(result.result == nil){
                    YYDialog.createToast().show(view: self.view, text: "没查询到数据")
                }else{
                    YYDialog.createToast().show(view: self.view, text: "数据数据为：\(result.result!.count)条")
                    
                }
            })
            
        default:
            break
        }
    }
}
