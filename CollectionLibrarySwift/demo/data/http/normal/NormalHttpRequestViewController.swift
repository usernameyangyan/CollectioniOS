//
//  NormalHttpRequestViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/20.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class NormalHttpRequestViewController:YYIBaseTableViewController{
    
    let dialog = YYDialog
        .createLoadingDialog()
        .defalutDialog()
    
    
    var pageNow:Int=1
    let section:YYTableViewSection = YYTableViewSection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"普通网络请求")
            .build()
        
        manager.add(section: section)
        manager.register(ShowCell.self, ContentInfo.self)
        tableView.separatorStyle = .none
        
        
        dialog.show(message: "正在请求数据...")
        
        let refreshView:YYDefaultRefreshHeaderAnimator=YYDefaultRefreshHeaderAnimator.init(frame: .zero)
        let footView:YYDefaultRefreshFooterAnimator=YYDefaultRefreshFooterAnimator.init(frame: .zero)
        
        self.tableView.yy.addPullToRefreshListener(animator: refreshView, handler: {
            [weak self] in
            self!.pageNow=1
            self!.refreshData()
            }, aboveView: navigation.bar, childView: self.tableView)
        
        self.tableView.yy.addLoadMoreListener(animator: footView){
            [weak self] in
            self!.pageNow+=1
            self!.refreshData()
        }
        
        //打开请求输出日志
        DataManager.DataForHttp.GlobalSetting.showHttpRequestLog=true
        
        refreshData()
        
    }
    
    
    fileprivate func refreshData(){
        
        let urlStr = "https://api.apiopen.top/getJoke?page="+String(format: "%1d", pageNow)+"&count=20&type=video"
        
        let httpParams:HttpRequestParams=HttpRequestParams()
        httpParams
            .setRequestType(requestType: .reqStringUrl)
            .setReqUrl(requestUrl: urlStr)
            .setReponseType(responseType: .netWork)
            .setHttpTypeAndReqParamType(httpTypeAndReqParamType: .get)
            .build()
        
        DataManager.DataForHttp.HttpOfNormal.Request<Result<Array<ContentInfo>>>.request(httpRequestParams: httpParams, requestSuccessResult: {
            value in
            
            if(self.pageNow==1){
                self.section.removeAllItems()
            }
            
            for content in value.result!{
                self.section.add(item: content)
            }
            
            self.manager.reloadData()
            
            
            if(self.pageNow==1){
                self.tableView.yy.stopPullToRefresh()
            }else{
                if(value.result!.count>0){
                    self.tableView.yy.stopLoadingMore()
                }else{
                    self.tableView.yy.noticeNoMoreData()
                }
                
            }
            
            self.dialog.dismiss()
        }, requestFailureResult: {
            error in
            self.dialog.dismiss()
            
        })
        
        
    }
}
