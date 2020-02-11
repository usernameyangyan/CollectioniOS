//
//  HttpUseListViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation


class HttpUseListViewController:YYIBaseTableViewController{
    
    
    var arrayM:NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title: InternationalUtils.getInstance.getString("httputil"))
            .build()
        
        
        tableView.separatorStyle = .none
        
        // Add main section
        let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(CommonTableViewCell.self, CommonTableItem.self)
        
        //数据组装
        self.arrayM=NSMutableArray()
        arrayM?.add("请求网络数据(可设置请求超时时间、缓存优先、设定清除缓存时间、设定请求参数方式以及请求方式、链式增加请求参数、打开请求输出日志、手动清除缓存以及取消请求)")
        arrayM?.add("文件下载")
        arrayM?.add("图片上传(文件上传后续需要再扩展、设定清除缓存时间、设定请求参数方式以及请求方式、链式增加请求参数)")
        
        for str in arrayM!{
            let item = CommonTableItem()
            item.desc=str as? String
            item.autoHeight(manager)
            section.add(item: item)
            
            item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                self?.cellTapEvent(item: selectItem as! CommonTableItem )
            })
        }
        manager.reloadData()
    }
    
    
    func cellTapEvent(item: CommonTableItem) {
        switch item.indexPath.row {
        case 0:
            navigationController?.pushViewController(NormalHttpRequestViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(DownLoadRequestViewController(), animated: true)
        default:
            
//            let url="xxxxx"
//            let httpParams=HttpUploadRequestParams()
//            httpParams
//                .setParam(key: "type", param: "addroadblock")//设置请求参数也可通过setParams()设置Array
//                .setReqUrl(requestUrl: url) //设置请求链接
//                .setFileSuffixName(fileSuffixName: ".jpg") //设置文件后缀名，后续上传其它文件扩展也可使用
//                .setImages(images: [UIImage(named: "d")!,UIImage(named: "e")!])//设置上传图片列表
//                .setMultiparName(multipartName: "imgList") //设置对应后台服务器上传文件字段
//                .build()
//            
//            /**
//             通过泛型设置结果转换的been类，可返回上传进度
//             */
//            YYHttpUploadUtils<UserInfo>.upload(httpRequestParams: httpParams, requestSuccessResult: {
//                result in
//            }, requestFailureResult: {
//                error in
//                print(error)
//            }, requestProgress: {
//                progress in
//            })
            
            
            YYDialog.createToast().show(view: self.view, text: "demo没有设置真实的上传测试，可通过查看代码设置")
        }
    }
}
