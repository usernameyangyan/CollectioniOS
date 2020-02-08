//
//  CategoryController1.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/20.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class CategoryController:UIViewController{
    
    var categoryTableView: UITableView!
    var productTableView: UITableView!
    
    //是否在向上滚动
    var isScrollUp:Bool = false
    var lastOffsetY:CGFloat = 0
    
    var categoryManager: YYTableViewManager!
    var productManager: YYTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("tableview_complex"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        self.view.backgroundColor=UIColor.colorWithHexString("#D2D3D5")
        
        
        categoryTableView=UITableView.init()
        productTableView=UITableView.init()
        self.view.addSubview(categoryTableView)
        self.view.addSubview(productTableView)
        
        categoryTableView
            .left(equalTo: view.yy_left)
            .width(100)
            .top(equalTo: view.yy_top,constant: IPhoneUtils.BAR_HEIGHT)
            .height(UIScreen.main.bounds.height-IPhoneUtils.BAR_HEIGHT)
            .build()
        
        
        productTableView
            .left(equalTo: categoryTableView.yy_right, constant: 10)
            .top(equalTo: view.yy_top,constant: IPhoneUtils.BAR_HEIGHT)
            .height(UIScreen.main.bounds.height-IPhoneUtils.BAR_HEIGHT)
            .right(equalTo: view.yy_right)
            .build()
        
        
        self.categoryManager = YYTableViewManager(tableView: self.categoryTableView)
        categoryManager.register(CategoryCell.self, CategoryItem.self)
        self.productManager = YYTableViewManager(tableView: self.productTableView)
        self.productManager.delegate = self
        
        //假数据
        let arrCategory = ["品种1","品种2","品种3","品种4","品种5","品种6"]
        let arrProduct = ["金毛", "拉布拉多", "柴犬", "泰迪", "比熊", "秋田"]
        
        //添加分类数据
        let categorySection = YYTableViewSection()
        self.categoryManager?.add(section: categorySection)
        for category in arrCategory {
            let categoryItem = CategoryItem()
            categoryItem.title = category
            categoryItem.isAutoDeselect = false
            categorySection.add(item: categoryItem)
            //分类的点击事件
            categoryItem.setSelectionHandler(selectHandler: {[weak self] (item) in
                self?.productManager.tableView.scrollToRow(at: IndexPath(row: 0, section: item.indexPath.row), at: .top, animated: true)
            })
        }
        
        
        
        //tableView添数据
        for category in arrCategory {
            //添加分区标题
            let sectionHeader = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
            sectionHeader.text = category
            sectionHeader.backgroundColor = UIColor.gray
            let section = YYTableViewSection(headerView: sectionHeader)
            self.productManager.add(section: section)
            //商品列表滑动时与分类列表联动
            //商品列表section header显示的回调
            section.setHeaderWillDisplayHandler({[weak self] (currentSection) in
                //手动拖拽事件结束并且是向下滚动，说明马上要显示的section就是当前的section，所以左边要选中对应的section
                if ((self?.productManager.tableView.isDragging)! && !(self?.isScrollUp)!){
                    let currentSection = self?.productTableView.indexPathsForVisibleRows?.first?.section ?? 0
                    self?.categoryTableView.selectRow(at: IndexPath(item: currentSection, section: 0), animated: false, scrollPosition: .middle)
                }
            })
            //商品列表section header消失的回调
            section.setHeaderDidEndDisplayHandler {[weak self] (currentSection) in//手动拖拽事件结束并且是向上滚动，说明现在消失的section的下一个section出现了，所以左边要选中下一个section
                if ((self?.productManager.tableView.isDragging)! && (self?.isScrollUp)!){
                    self?.categoryTableView.selectRow(at: IndexPath(item: currentSection.index + 1, section: 0), animated: false, scrollPosition: .middle)
                }
            }
            for product in arrProduct {
                let item = YYTableViewItem(title: product)
                item.cellHeight = 80
                section.add(item: item)
            }
        }
        //先默认选中categoryTableView分类的第一个cell
        self.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.top)
        
    }
    
}


extension CategoryController:YYTableViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isScrollUp = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

