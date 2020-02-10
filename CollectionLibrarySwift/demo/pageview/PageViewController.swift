//
//  PageViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/30.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit


class PageViewController:UIViewController,YYPagerViewDataSource,YYPagerViewDelegate{
    
    var tableView: UITableView!
    var manager: YYTableViewManager!
    let imageNames = ["d","e","f","g"]
    let sectionTitles = ["基础样式","Item大小","Item间距","其它样式","是否循环显示","是否自动轮播","控制器样式","控制器大小","控制器间距","控制器位置"]
    let typeTitles = ["Defalut"]
    let otherTiles = ["CrossFading","ZoomOut","Depth","Overlap","Linear","Cubic"]
    let isInfinite = ["isInfinite"]
    let isLoop = ["isLoop"]
    let controllStyle = ["Default","自定义颜色","自定义图片"]
    let location = ["Right","Center","Left"]
    
    let pageView:YYPageView={
        let pageView:YYPageView=YYPageView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        pageView.register(YYDefaltPageViewCell.self, forCellWithReuseIdentifier: "cell")
        pageView.transformer = YYPageViewTransformer(type:.none)
        pageView.pageControl.interitemSpacing=10
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("pageview"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        PositionSettingUtils.position(aboveView: self.navigation.bar, childView: pageView, style: .adaptive)
        
        
        pageView.delegate=self
        pageView.dataSource=self        
        self.view.addSubview(pageView)
        
        
        tableView = UITableView(frame: view.bounds, style:.grouped)
        self.view.addSubview(tableView)
        tableView
            .top(equalTo: pageView.yy_bottom)
            .left(equalTo: self.view.yy_left)
            .right(equalTo: self.view.yy_right)
            .bottom(equalTo: self.view.yy_bottom)
            .build()
        
        
        
        manager = YYTableViewManager(tableView: tableView)
        manager.register(PageViewItemSliderCell.self, PageViewItemSliderItem.self)
        
        for i in 0...sectionTitles.count-1 {
            let headerView:SelectionHeader=SelectionHeader.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
            headerView.setContent(con: sectionTitles[i])
            headerView.titleLab.font=UIFont.systemFont(ofSize: 17)
            headerView.titleLab.textColor=UIColor.red
            let section = YYTableViewSection.init(headerView: headerView)
            manager.add(section: section)
            
            
            switch i {
            case 0:
                for typeIndex in 0...typeTitles.count-1{
                    let item=YYTableViewItem(title: typeTitles[typeIndex])
                    if(typeIndex==0){
                        item.accessoryType = .checkmark
                    }
                    section.add(item: item)
                    item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                        self?.cellTapEvent(item: selectItem )
                    })
                }
                
                
            case 1:
                section.add(item: setItem(index: 0))
            case 2:
                section.add(item: setItem(index: 1))
            case 3:
                for typeIndex in 0...otherTiles.count-1{
                    let item=YYTableViewItem(title: otherTiles[typeIndex])
                    section.add(item: item)
                    item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                        self?.cellTapEvent(item: selectItem )
                    })
                }
            case 4:
                for typeIndex in 0...isInfinite.count-1{
                    let item=YYTableViewItem(title: isInfinite[typeIndex])
                    section.add(item: item)
                    item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                        self?.cellTapEvent(item: selectItem )
                    })
                }
                
            case 5:
                for typeIndex in 0...isLoop.count-1{
                    let item=YYTableViewItem(title: isLoop[typeIndex])
                    section.add(item: item)
                    item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                        self?.cellTapEvent(item: selectItem )
                    })
                }
            case 6:
                for controll in 0...controllStyle.count-1{
                    
                    
                    let item=YYTableViewItem(title: controllStyle[controll])
                    
                    if(controll==0){
                        item.accessoryType = .checkmark
                    }
                    
                    section.add(item: item)
                    item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                        self?.cellTapEvent(item: selectItem )
                    })
                }
            case 7:
                section.add(item: setItem(index: 2))
            case 8:
                section.add(item: setItem(index: 3))
            case 9:
                for loc in 0...location.count-1{
                    let item=YYTableViewItem(title: location[loc])
                    
                    if(loc==0){
                        item.accessoryType = .checkmark
                    }
                    
                    section.add(item: item)
                    item.setSelectionHandler(selectHandler: {[weak self](selectItem) in
                        self?.cellTapEvent(item: selectItem )
                    })
                }
            default:
                break
            }
            
        }
        manager.reloadData()
        
    }
    
    
    var isSelect:Bool=false
    var isSelectLoop:Bool=false
    func cellTapEvent(item: YYTableViewItem) {
        
        switch item.indexPath.section {
        case 0:
            switch item.indexPath.row {
            case 0:
                pageView.transformer = YYPageViewTransformer(type:.none)
                pageView.itemSize = pageView.frame.size.applying(CGAffineTransform(scaleX: 1.0, y: 1.0))
            default:
                break
                
            }
            
            setItemSelectStatus(index: -1, sectionIndex: 3)
            setItemSelectStatus(index: item.indexPath.row, sectionIndex: item.indexPath.section)
            
            
        case 3:
            switch item.indexPath.row {
            case 0:
                pageView.transformer = YYPageViewTransformer(type:.crossFading)
                pageView.itemSize = pageView.frame.size.applying(CGAffineTransform(scaleX: 1.0, y: 1.0))
            case 1:
                pageView.transformer = YYPageViewTransformer(type:.zoomOut)
                pageView.itemSize = pageView.frame.size.applying(CGAffineTransform(scaleX: 1.0, y: 1.0))
            case 2:
                pageView.transformer = YYPageViewTransformer(type:.depth)
                pageView.itemSize = pageView.frame.size.applying(CGAffineTransform(scaleX: 1.0, y: 1.0))
            case 3:
                pageView.transformer = YYPageViewTransformer(type:.overlap)
                let transform = CGAffineTransform(scaleX: 0.8, y: 0.75)
                pageView.itemSize = pageView.frame.size.applying(transform)
            case 4:
                pageView.transformer = YYPageViewTransformer(type:.linear)
                let transform = CGAffineTransform(scaleX: 0.8, y: 0.75)
                pageView.itemSize = pageView.frame.size.applying(transform)
            case 5:
                pageView.transformer = YYPageViewTransformer(type:.cubic)
                pageView.itemSize = pageView.frame.size.applying(CGAffineTransform(scaleX: 1.0, y: 1.0))
            default:
                break
                
            }
            
          
            setItemSelectStatus(index: -1, sectionIndex: 0)
            setItemSelectStatus(index: item.indexPath.row, sectionIndex: item.indexPath.section)
        case 4:
            if(!isSelect){
                pageView.isInfinite=true
                manager.sections[item.indexPath.section].items[0].accessoryType = .checkmark
                isSelect=true
            }else{
                pageView.isInfinite=false
                manager.sections[item.indexPath.section].items[0].accessoryType = UITableViewCell.AccessoryType.none
                isSelect=false
            }
            tableView.reloadSections([item.indexPath.section], with: .none)
            
        case 5:
            if(!isSelectLoop){
                pageView.automaticSlidingInterval=2
                manager.sections[item.indexPath.section].items[0].accessoryType = .checkmark
                isSelectLoop=true
            }else{
                pageView.automaticSlidingInterval=0
                manager.sections[item.indexPath.section].items[0].accessoryType = UITableViewCell.AccessoryType.none
                isSelectLoop=false
            }
            tableView.reloadSections([item.indexPath.section], with: .none)
            
            
        case 6:
            pageView.pageControl.cleanUp()
            switch item.indexPath.row {
                
            case 0:
                break
            case 1:
                pageView.pageControl.setStrokeColor(.blue, for: .normal)
                pageView.pageControl.setStrokeColor(.blue, for: .selected)
                pageView.pageControl.setFillColor(.blue, for: .selected)
            case 2:
                pageView.pageControl.setImage(UIImage(named:"point"), for: .normal)
                pageView.pageControl.setImage(UIImage(named:"selectpoint"), for: .selected)
                
            default:
                break
            }
            
            
            setItemSelectStatus(index: item.indexPath.row, sectionIndex: item.indexPath.section)
        case 9:
            switch item.indexPath.row {
                
            case 0:
                pageView.pageControl.contentHorizontalAlignment = .right
                break
            case 1:
                pageView.pageControl.contentHorizontalAlignment = .center
            case 2:
                pageView.pageControl.contentHorizontalAlignment = .left
            default:
                break
            }
            
        
            setItemSelectStatus(index: item.indexPath.row, sectionIndex: item.indexPath.section)
        default:
            break
        }
        
    }
    
    //MARK:改变item选择的状态
    func setItemSelectStatus(index:Int,sectionIndex:Int) {
        
        for i in 0...manager.sections[sectionIndex].items.count-1{
            if(index==i){
                manager.sections[sectionIndex].items[i].accessoryType = .checkmark
            }else{
                manager.sections[sectionIndex].items[i].accessoryType = UITableViewCell.AccessoryType.none
            }
        }
        
        tableView.reloadSections([sectionIndex], with: .none)
        
        
    }
    
    
    func setItem(index:Int) -> PageViewItemSliderItem {
        let item=PageViewItemSliderItem()
        item.index=index
        item.pageView=pageView
        return item
    }
    
    
    
    
    //MARK:pageview设置
    func numberOfItems(in pagerView: YYPageView) -> Int {
        return imageNames.count
    }
    
    func pagerView(_ pagerView: YYPageView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! YYDefaltPageViewCell
        cell.imageView?.image=UIImage(named:imageNames[index] )
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = String.init(format: "第%d张图片", index)
        return cell
    }
    
}
