//
//  DataShowViewDemoViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/6.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class DataShowViewDemoViewController:YYIBaseTableViewController{
    
    let section:YYTableViewSection = YYTableViewSection()
    var dataShowView:YYDataShowView?
    var dataLoadingView:YYDataShowView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"使用demo")
            .build()
        
        
        
        manager.add(section: section)
        manager.register(ShowCell.self, ContentInfo.self)
        tableView.separatorStyle = .none
        
        dataShowView=YYDataShowView(defaultDataShowViewParams:DefaultDataShowViewParams() ,aboveView: navigation.bar,reloadHandler: {
            self.dataShowView?.hide()
            self.dataLoadingView?.show(parentView: self)
            self.refreshData()
        })
        dataShowView!.show(parentView: self)
        
        let defaultDataShowViewParams=DefaultDataShowViewParams()
        defaultDataShowViewParams
            .setDefaultDataShowViewType(showViewType: .loading)
            .build()
        dataLoadingView=YYDataShowView(defaultDataShowViewParams:defaultDataShowViewParams,aboveView:navigation.bar)
    }
    
    
    fileprivate func refreshData(){
        
        let urlStr = "https://api.apiopen.top/getJoke?page=1&count=20&type=video"
        
        let httpParams:HttpRequestParams=HttpRequestParams()
        httpParams
            .setRequestType(requestType: .reqStringUrl)
            .setReqUrl(requestUrl: urlStr)
            .setReponseType(responseType: .netWork)
            .setHttpTypeAndReqParamType(httpTypeAndReqParamType: .get)
            .build()
        
        YYHttpRequestUtils<Result<Array<ContentInfo>>>.request(httpRequestParams: httpParams, requestSuccessResult: {
            value in
            
            
            for content in value.result!{
                self.section.add(item: content)
            }
            
            self.manager.reloadData()
            self.dataLoadingView?.hide()
            
        }, requestFailureResult: {
            error in
        })
    }
}
