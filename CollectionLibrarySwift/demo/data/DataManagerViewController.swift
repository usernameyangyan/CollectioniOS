//
//  DataManagerViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/14.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class DataManagerViewController:UIViewController{
    var tableView: UITableView!
    var manager: YYTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: InternationalUtils.getInstance.getString("httputil"))
            .build()
        
        
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        
        
        let sections=["Http","SQLite","UserDefults","File"]
        let items=[["请求网络数据(可设置请求超时时间、缓存优先、设定清除缓存时间、设定请求参数方式以及请求方式、链式增加请求参数、打开请求输出日志、手动清除缓存以及取消请求)","文件下载","图片上传(文件上传后续需要再扩展、设定清除缓存时间、设定请求参数方式以及请求方式、链式增加请求参数)"],["SQLite的使用"],["UserDefaults的使用"],["File的使用"]]
        
        
        
        manager = YYTableViewManager(tableView: tableView)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        for i in 0 ... sections.count-1 {
            let headerView:SelectionHeader=SelectionHeader.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
            headerView.setContent(con: sections[i])
            let section = YYTableViewSection.init(headerView: headerView)
            manager.add(section: section)
            
            for j in 0...items[i].count - 1{
                let item = CommonTableItem()
                item.desc=items[i][j]
                item.autoHeight(manager)
                section.add(item: item)
                
                item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                    self?.cellTapEvent(item: selectItem as! CommonTableItem )
                })
            }
            
            
        }
        
    }
    
    
    
    func cellTapEvent(item: CommonTableItem) {
        switch item.section.index {
        case 0:
            switch item.indexPath.row {
            case 0:
                navigationController?.pushViewController(NormalHttpRequestViewController(), animated: true)
            case 1:
                navigationController?.pushViewController(DownLoadRequestViewController(), animated: true)
            default:
//                            let url="xxxxx"
//                            let httpParams=HttpUploadRequestParams()
//                            httpParams
//                                .setParam(key: "type", param: "addroadblock")//设置请求参数也可通过setParams()设置Array
//                                .setReqUrl(requestUrl: url) //设置请求链接
//                                .setFileSuffixName(fileSuffixName: ".jpg") //设置文件后缀名，后续上传其它文件扩展也可使用
//                                .setImages(images: [UIImage(named: "d")!,UIImage(named: "e")!])//设置上传图片列表
//                                .setMultiparName(multipartName: "imgList") //设置对应后台服务器上传文件字段
//                                .build()
//
//                            /**
//                             通过泛型设置结果转换的been类，可返回上传进度
//                             */
//
//                            DataManager.DataForHttp.HttpOfUpload.Upload.upload(httpRequestParams: httpParams, requestSuccessResult: {
//                                result in
//                            }, requestFailureResult: {
//                                error in
//                                print(error)
//                            }, requestProgress: {
//                                progress in
//                            })
                
                
                YYDialog.createToast().show(view: self.view, text: "demo没有设置真实的上传测试，可通过查看代码设置")
            }
        case 1:
            navigationController?.pushViewController(SQLiteUseControllerView(), animated: true)
        case 2:
            navigationController?.pushViewController(UsersDefaultsSaveController(), animated: true)
     
        case 3:
            navigationController?.pushViewController(FileUseControllerView(), animated: true)
        default:
            break
        }
    }
}
