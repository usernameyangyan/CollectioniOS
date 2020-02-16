//
//  DownLoadRequestViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/20.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class DownLoadRequestViewController:AutoHeightUIViewController{
    
    
    var arrayM:NSMutableArray?
    
    var tableView: UITableView!
    var manager: YYTableViewManager!
    var tableViewStyle: UITableView.Style = UITableView.Style.plain
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.bounds, style: self.tableViewStyle)
        self.view.addSubview(self.tableView);
        self.manager = YYTableViewManager(tableView: self.tableView)
        
        self.view.backgroundColor=UIColor.white
    
        manager.register(ShowCell.self, ContentInfo.self)
        tableView.separatorStyle = .none
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"文件下载")
            .build()
        
        //数据组装
        self.arrayM=NSMutableArray()
    arrayM?.add("https://hyjj-chatm.oss-cn-beijing.aliyuncs.com/looktm-eye-report/2018%20%E6%AF%8D%E5%A9%B4%20App%20%E8%A1%8C%E4%B8%9A%E5%88%86%E6%9E%90%E6%8A%A5%E5%91%8A.pdf")
    
        arrayM?.add("http://www.vicorpower.cn/documents/whitepapers/art-ecn201903-dl.pdf")
        
        tableView.separatorStyle = .none
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(DownloadCell.self, DownloadItem.self)
        
        for str in arrayM!{
            let item = DownloadItem()
            item.downloadUrl=str as? String
            section.add(item: item)
        }
        
        manager.reloadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DataManager.DataForHttp.HttpOfDownload.Download.downloadCancelAll()
    }
    
}
