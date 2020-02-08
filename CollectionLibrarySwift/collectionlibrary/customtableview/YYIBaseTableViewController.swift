//
//  YYIBaseTableViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

open class YYIBaseTableViewController: AutoHeightUIViewController  {
    public var tableView: UITableView!
    public var manager: YYTableViewManager!
    public var tableViewStyle: UITableView.Style = UITableView.Style.plain
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: self.view.bounds, style: self.tableViewStyle)
        self.view.addSubview(self.tableView);
        self.manager = YYTableViewManager(tableView: self.tableView)
        
    }
    
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
