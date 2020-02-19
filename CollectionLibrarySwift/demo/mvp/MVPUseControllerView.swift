//
//  MVPUseControllerView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation

class MVPUseControllerView:IBaseControllerView<MvpPresenter>,MvpView{
    
    
    var tableView: UITableView!
    var manager: YYTableViewManager!
    var tableViewStyle: UITableView.Style = UITableView.Style.plain
    
    let section:YYTableViewSection = YYTableViewSection()
    var dataLoadingView:YYDataShowView?
    
    
    func refreshUI(value:Result<Array<ContentInfo>>) {
        for content in value.result!{
            self.section.add(item: content)
        }
        
        self.manager.reloadData()
        self.dataLoadingView?.hide()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        self.tableView = UITableView(frame: self.view.bounds, style: self.tableViewStyle)
        self.view.addSubview(self.tableView);
        self.manager = YYTableViewManager(tableView: self.tableView)
        
        NavigationUtils
            .with(controller: self)
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .setTitle(title:"MVP")
            .build()
        
        
        manager.add(section: section)
        manager.register(ShowCell.self, ContentInfo.self)
        tableView.separatorStyle = .none
        
    
        
        let loadingDataShowViewParams=DefaultDataShowViewParams()
        loadingDataShowViewParams
            .setDefaultDataShowViewType(showViewType: .loading)
            .build()
        dataLoadingView=YYDataShowView(defaultDataShowViewParams:loadingDataShowViewParams,aboveView:navigation.bar)
        
        self.dataLoadingView?.show(parentView: self)
        
        mPresenter?.requestData()
        
    }
}
