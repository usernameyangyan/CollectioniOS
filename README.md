## CollectioniOS

![版本](https://img.shields.io/badge/release-1.0.8-green.svg)
![Travis](https://img.shields.io/badge/llicense-MIT-green.svg)
![Travis](https://img.shields.io/badge/build-passing-green.svg)

CollectioniOS聚合了项目搭建的一些基本模块，节约开发者时间，协助项目的快速搭建,能够满足一个项目的基本实现。


>###### 简书地址：https://www.jianshu.com/p/a445521e70eb

>###### 掘金地址：https://juejin.im/post/5e423d4ef265da572a0cec9f

## 框架的引入
- pod 'CollectioniOS','~>1.0.9'

### 更新说明

####  v1.0.9
> 1.增加DataManager，对Http数据请求、UserDefaults、File、SQLite的整合使用，移除YYHttpUtils
> 2.增加YYTagView
> 3.增加MVP

####  v1.0.8（增加以下功能）
> 1.应用基本配置：应用内国际化语言配置、应用名称国际化。  
> 2.UTTableView/UICollectionView的封装以及通用用法。  
> 3.YYNavigationBar：顶部导航栏的封装以及使用。  
> 4.YYAutoLayout：自动布局的使用。    
> 5.YYTabBar：底部分页导航栏的封装以及使用。  
> 6.YYPageView的封装以及使用。  
> 7.YYPageMenu：滑动菜单的封装以及使用。  
> 8.YYRefresh:下拉刷新/上拉加载更多控件的封装以及使用。  
> 9.YYImageLoader:网络图片加载（可加载普通网络图片、gif,可设置缓存时间、缓存大小）。  
> 10.YYDialog:通用提示框的封装、Toast的封装  
> 11.YYHttpUtils:网络请求的封装（普通的网络请求、文件下载、图片上传）  
> 12.YYDataShowView:数据加载显示样式（没有数据、网络错误、正在加载）


## 项目介绍
### 文章目录
**1.应用基本配置** 

- 应用内国际化语言配置  
- 应用名称国际化

**2.UTTableView的封装使用**

- 通过YYTableViewManager对UITableView进行统一管理使用
- 自定义分割线
- 列表增加头部视图
- 实现ExpandableList的效果
- Cell实现自适应高度
- UITableView增加可伸缩头部
- 实现Cell滑动删除
- 多布局的实现
- UITableView实现分类效果

**3.UICollectionView/UIScrollView的基础使用** 

- UICollectionView通用布局，可快速设置行数、高度
- UICollectionView增加可伸缩头部
- UIScrollView增加可伸缩头部

**4.YYNavigationBar：顶部导航栏** 

- YYNavigationBar的封装使用

**5.YYAutoLayout：自动布局** 

- YYAutoLayout的简单使用

**6.YYTabBar：底部分页导航栏** 

- TabBar的基本样、自定义选中颜色、默认TabBar下标、点击弹簧效果
- TabBar和NavigationBar结合使用
- TabBar不规则排序以及自定义点击事件
- 背景颜色效果(不带title)、背景颜色带有弹簧选中效果(不带title)、背景颜色突出显示（不带title）、暗示用户点击
- TabBar默认提示框(TabBarBadgeValue内容设置、提示颜色、隐藏)
- 自定义TabBarItemView，可设置字体颜色、图片颜色、设置自定义提示框、提示动作

**7.YYPageView：图片轮播** 

- YYPageView的封装使用

**8.YYPageMenu：滑动菜单** 

- YYPageMenu的封装使用

**9.YYRefresh:下拉刷新/上拉加载更多** 

- 默认下拉刷新/上拉加载更多样式
- 自定义下拉刷新/上拉加载更多样式

**10.YYImageLoader:网络图片加载** 

- 加载普通图片
- 加载gif图
- 自定义加载图片的参数

**11.YYDialog:通用提示框** 

- 提示框的使用
- 加载框的使用
- Toast提示

**12.YYHttpUtils:网络请求** 

- 基本网络请求
- 文件下载
- 图片上传
- 网络请求的参数设置（包含请求超时、缓存时间等）

**13.YYDataShowView:数据加载显示页面** 

- 通用数据加载提示框的使用

**14.通用工具类** 

- 通用工具的使用


### 具体使用

#### 一、应用基本配置

##### 1.应用内国际化语言配置 
![效果图](https://github.com/usernameyangyan/CollectioniOS/blob/master/ScreenShots/1.gif)

######  实现流程：

    1.在项目创建一个Strings File 命名为 Localizable.strings
    2.选择Localizable.strings文件 点击localizaiton,选择所需语种
    3.其中第2点显示的语种如果没有所需的可以点击项目->PROJECT下面的文件->info->找到Localizations添加
    4.使用InternationalUtils类进行内容获取和系统语言切换：
      (1)在AppDelegate中通过InternationalUtils.getInstance.initUserLanguage()进行初始化
      (2)通过InternationalUtils.getInstance.getString(name)获取Localizable.string字符串对应的内容       
      (3)通过InternationalUtils.getInstance.setLanguage(LanguageType,rootViewController)进行语言切换，其中注意的是需要传入根Controller
      (4)通过InternationalUtils.getCurrentLanguage()获取当前语言

##### 2.应用名称国际化
    (1)创建Strings File文件，并命名为InfoPlist.strings
    (2)选中创建好的文件，点击右侧Localize,勾选所需语言
    (3)配置InfoPlist.strings：CFBundleDisplayName = 

#### 二、UTTableView的封装使用

![效果图](https://upload-images.jianshu.io/upload_images/4361802-ebd358766adae311.gif?imageMogr2/auto-orient/strip)

##### 1.YYTableViewManager使用

- 通过YYTableViewManager管理UITableView：

      //把UITableView设置给YYTableViewManager进行管理使用
      let manager = YYTableViewManager(tableView: self.tableView)


- YYTableViewManager使用组成，基本包含YYTableViewSection(UITabView每组item的头部)、Cell的构成：YYTableViewItem、YYTableViewCell

- YYTableViewManager

| 属性 | 作用 | 
| :-----| :---- | 
|register(_ nibClass: AnyClass, _ item: AnyClass, _ bundle: Bundle = Bundle.main | 注册YYTabViewCell和YYTabViewItem|
| numberOfSections(in _: UITableView) |当前Section的下标 | 
| numberOfSections(in _: UITableView) |当前Section的下标 | 
| add(section: YYTableViewSection)|增加Section头部视图 | 
| remove(section: Any)|移除Section头部视图 | 
| removeAllSections()|移除所有Section头部视图 | 
| reloadData()|重新加载UITabView数据 | 


   - YYTableViewSection

| 属性 | 作用 | 
| :-----| :---- | 
|headerHeight | 头部视图高度|
| footerHeight |尾部视图高度 | 
| init() |使用默认的头部视图，如果不设定头部任何参数就默认是不显示的 | 
| init(headerView: UIView!) |增加自定义头部视图 | 
| init(footerView: UIView?)  |增加自定义尾部视图 | 
| init(headerView: UIView?, footerView: UIView?) |增加自定义头部视图和尾部视图 | 
|add(item: YYTableViewItem) | 增加头视图下面的item|
|remove(item: YYTableViewItem)  | 移除头部视图下面的item|
|removeAllItems() | 移除头视图下面的所有item|
|replaceItemsFrom(array: [YYTableViewItem]!) | 替换头部视图下面的所有item|
|insert(_ item: YYTableViewItem!, afterItem: YYTableViewItem, animate: UITableView.RowAnimation = .automatic) |在某个item后面插入新的item|
|insert(_ items: [YYTableViewItem], afterItem: YYTableViewItem, animate: UITableView.RowAnimation = .automatic) | 在某个item后面插入item数组|
|delete(_ itemsToDelete: [YYTableViewItem], animate: UITableView.RowAnimation = .automatic) | 删除头部视图中某个item|
|reload(_ animation: UITableView.RowAnimation)| 重新加载Section组下的数据|

- YYTableViewCell

| 属性 | 作用 | 
| :-----| :---- | 
|item | 在register时和Cell绑定的YYTableItem,主要是数据的传递|
|cellWillAppear()  | Cell显示的时候会调用这个回调|
|cellDidDisappear() | Cell消失时会调用这个回调|
|setSelected() |Cell设置选择状态 |

- YYTableViewItem

| 属性 | 作用 | 
| :-----| :---- | 
|tableViewManager | 绑定的YYTableViewManager|
|section | 绑定的YYTableViewSection|
|cellTitle | 设定默认Cell标题的字段|
|cellHeight | Cell的高度|
|cellStyle | Cell的样式|
|func setSelectionHandler(selectHandler: YYTableViewItemBlock?) | Item的点击事件回调|  
| setDeletionHandler(deletionHandler: YYTableViewItemBlock?) | Item的删除事件回调|
|separatorInset | 分割线内边距|
|editingStyle | Item的编辑状态|
|isHideSeparator | Item是否隐藏分割线|
|separatorLeftMargin | 分割线外边距|
|indexPath | Item的下标|
|reload(_ animation: UITableView.RowAnimation) | Item数据重新加载|
|delete(_ animation: UITableView.RowAnimation = .automatic) | Item数据的删除|
|updateHeight() | 更新高度|
|autoHeight() | 自动计算高度|


- 基本用法：
       
       //初始化Manager
       let manager = YYTableViewManager(tableView: self.tableView)
       //增加一个头部视图
       let section = YYTableViewSection()
       manager.add(section: section)
       //注册YYTableViewCell以及YYTableViewItem
       manager.register(CommonTableViewCell.self, CommonTableItem.self)
      //Section增加item
      section.add(item: item)
      manager.reloadData()

- 自定义YYTableViewCell和YYTableViewItem

      class CommonTableItem:YYTableViewItem{
            //自定义一些数据结构
            var desc: String!
            //自定义高度
            override init() {
                super.init()
                cellHeight=30
            }
      }


      class CommonTableViewCell:YYTableViewCell{
    
          override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
              super.init(style: style, reuseIdentifier: reuseIdentifier)
          }
    
          required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
          }
          // cell即将出现在屏幕中的回调方法 在这个方法里面赋值
          override func cellWillAppear() {
               let item = self.item as! CommonTableItem
          }
      }


- 自定义分割线

      在自定义YYTableViewCell中重写以下方法
      override func draw(_ rect: CGRect) {
            //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
           return
        }
         //#FF4500
        context.setStrokeColor(UIColor.colorWithHexString("#D2D3D5").cgColor)
        context.stroke(CGRect(x:0, y: rect.size.height, width: rect.size.width, height:1))
      }

- 列表增加头部视图

      for i in 0 ... 8 {
            let headerView:SelectionHeader=SelectionHeader.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
            headerView.setContent(con: "Header " + String(i))
            let section = YYTableViewSection.init(headerView: headerView)
            manager.add(section: section)
            for j in 0 ... 4 {
                section.add(item: YYTableViewItem(title: "Header " + String(i) + " Row " + String(j)))
            }
        }

- 实现ExpandableList的效果

      1.实现YYExpandTreeCellItem
      2.代码实现
      // level 0
        let item0 = ExpanableListItem1()
        item0.level = 0
        section.add(item: item0)
        // 如果isExpand为true，则下一级的item（也就是item1）必须加入section
        item0.isExpand = true
        // level 1
        for _ in 0 ..< 3 {
            let item1 = ExpanableListItem2()
            // level仅用于记录层级，可以不赋值
            item1.level = 1
            item1.isExpand = false
            section.add(item: item1)
            item0.arrNextLevel.append(item1)

            // level 2
            for _ in 0 ..< 3 {
                let item2 = ExpanableListItem3()
                // 如果isExpand为false，则后面就不用把item加入section
                item2.isExpand = false
                item1.arrNextLevel.append(item2)
            }
        }

- Cell实现自适应高度

       let item = CommonTableItem()
       item.desc=str as? String
       item.autoHeight(manager)//自适应高度设置语句
       section.add(item: item)

- UITableView增加可伸缩头部

      1.实现YYStretchyHeaderView（在自定义头部的时候使用约束布局需要特别注意，如果约束布局出现问题会导致伸缩出现问题）
      2.tableView.addSubview(ScaleHeaderView(frame: self.view.bounds))

- 实现Cell滑动删除

       for _ in 0 ..< 20 {
            let item = CommonTableItem()
            item.desc="左滑可删除item"
            item.editingStyle = .delete//设置编辑状态为删除
            section.add(item: item)
            //设置删除监听
            item.setDeletionHandler(deletionHandler: { [weak self] (item) in
                self?.deleteConfirm(item: item as! CommonTableItem)
            })
        }

- 多布局的实现

      let section = YYTableViewSection()
        manager.add(section: section)
        manager.register(PictureCell.self, PictureItem.self)
        manager.register(TextCell.self, TextItem.self)
        for index in 0...30{
            if(index%2==0){
                let picture = PictureItem()
                picture.content=""
                picture.autoHeight(manager)
                section.add(item: picture)
            }else{
                let textItem = TextItem()
                textItem.content=""
                textItem.autoHeight(manager)
                section.add(item: textItem)
            }
        }

- UITableView实现分类效果
具体实现请看demo代码实现


#### 三、UICollectionView/UIScrollView的基础使用

![效果图](https://upload-images.jianshu.io/upload_images/4361802-d3e8ba56eb97be91.gif?imageMogr2/auto-orient/strip)


##### 1. UICollectionView的快速使用

- CommonCollectionViewLayout

| 属性 | 作用 | 
| :-----| :---- | 
|init(lineSpacing: CGFloat, columnSpacing: CGFloat, sectionInsets: UIEdgeInsets) | 布局初始化，可设置行间距、列间距、外框边距|

- CommonCollectionViewLayoutDelegate

| 属性 | 作用 | 
| :-----| :---- | 
|columnOfLayout(_ collectionView: UICollectionView) | 设置UICollectionView的列数|
|itemHeight(_ collectionView: UICollectionView, layout commonCollectionViewLayout: CommonCollectionViewLayout, heightForItemAt indexPath: IndexPath) | 设置item的高度|

###### 使用步骤
 -  (1)设置CommonCollectionViewLayout

        let flowLayout = CommonCollectionViewLayout.init(lineSpacing: 10, columnSpacing:10, sectionInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        flowLayout!.delegate=self

        collectionView=UICollectionView(frame: self.view.frame, collectionViewLayout: self.flowLayout!)
        collectionView!.dataSource=self
        self.collectionView!.delegate=self
        //注册cell

        self.collectionView!.register(CommonUICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseidentifier)

 -  (1)实现CommonCollectionViewLayoutDelegate

        extension CommonUICollectionViewController:CommonCollectionViewLayoutDelegate,UICollectionViewDelegate, UICollectionViewDataSource{
          func columnOfLayout(_ collectionView: UICollectionView) -> Int {
            code
          }
          func itemHeight(_ collectionView: UICollectionView, layout commonCollectionViewLayout: CommonCollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
            code
          }
        }

##### 2. UICollectionView/UIScrollView增加可伸缩头部
请参照上面UITableView的用法

#### 四、YYNavigationBar：顶部导航栏

![效果图](https://upload-images.jianshu.io/upload_images/4361802-47ad022c3768ae48.gif?imageMogr2/auto-orient/strip)



##### 1.YYNavigationBar基本属性

| 属性| 作用 | 
| :-----| :---- | 
|setHidden(...)| 隐藏NavigationBar|
|setAlpha(...) | 设置NavigationBar的透明度|
|setBarBackgroundColor(...)| 设置NavigationBar的背景颜色|
|setTitleColor(...) | 设置NavigationBar的标题颜色|
|setTitleSize(...)| 设置NavigationBar的标题大小|
|setShadowImage(...)| 设置NavigationBar的阴影图片|
|setShadowHidden(...)| 设置NavigationBar的阴影是否隐藏|
|setShadow(...)| 设置NavigationBar的阴影|
|setTitleTextAttributes(...)| 设置NavigationBar的标题的Attributes|
|setTranslucent(...)| 设置NavigationBar是否透明|
|setBarStyle(...)| 设置NavigationBar是样式|
|setBackgroundImage(...)| 设置NavigationBar背景图片，如果设置图片会覆盖背景颜色|
|setTitle(...)| 设置NavigationBar标题|
|setBackBarButtonItem(...)| 设置NavigationBar返回Item|
|setBackBarButtonItem(...)| 设置NavigationBar返回Item|
|setLeftButtonItem(...)| 设置NavigationBar左边菜单Item|
|setLeftButtonItems(...)| 设置NavigationBar左边菜单Item|
|setRightButtonItem(...)| 设置NavigationBar右边菜单Item|
|setRightButtonItems(...)| 设置NavigationBar左边菜单Item数组|

##### 2.YYNavigationBar全局设置Configuration
| 属性| 作用 | 
| :-----| :---- | 
|isHidden| 隐藏NavigationBar|
|alpha| NavigationBar的透明度|
|tintColor| NavigationBar的标题颜色|
|shadowImage| 设置NavigationBar的阴影图片|
|isShadowHidden| 隐藏NavigationBar的阴影|
|titleTextAttributes| NavigationBar的Attributes|
|isTranslucent| 设置NavigationBar透明|
|setBackgroundImage| 设置NavigationBar的背景图片|

##### 3.链式使用

    NavigationUtils
            .with(controller: self)
            .setBarBackgroundColor(barTintColor: UIColor.red)
            .setTitle(title: InternationalUtils.getInstance.getString("nav_use"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build(

#### 五、YYAutoLayout：自动布局

![效果图](https://upload-images.jianshu.io/upload_images/4361802-56dd37ec3cec2341.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


##### 链式使用

    centerLabel
            .centerX(equalTo: view.yy_centerX)
            .centerY(equalTo: view.yy_centerY)
            .width(80)
            .height(40)
            .build()

#### 六、YYTabBar：底部分页导航栏

![效果图](https://upload-images.jianshu.io/upload_images/4361802-59a45307d66a014b.gif?imageMogr2/auto-orient/strip)



##### 1.TabBarBasicParamBuilder基本属性

| 属性| 作用 | 
| :-----| :---- | 
|with(...)| TabBarBasicParamBuilder的初始方法，可设置TabBar的图片、标题|
|defultStyle()| 获取默认样式设置，下面属性归属defaultStyle()|
|setTextColor(...)| 设置未选择标题的颜色|
|setSelectTextColor(...)| 设置选择标题的颜色|
|setImgColor(...)| 设置未选择图片颜色|
|setSelectImgColor(...)| 设置选择图片颜色|
|bouncesAnimationStyle()|设置弹簧动画|
|setRemindUseClickIndex(...)| 设置用户提醒点击下标|
|irregularity()| 不规则TabBarItem显示，归属defultStyle(),下面属性归属irregularity()|
|setIrregularityIndex(...)| 设置不规则TabBarItem下标|
|setIrregularityBorderColor(...) |设置不规则图标BorderColor|
|setIrregularityBorderWidth(...)| 设置不规则TabBarItem外框宽度|
|setIrregularityBackgroundColor(...)| 设置不规则TabBarItem背景颜色|
|retunDefaultStyle()| 返回defuletStyle|
|backgroundColorWithoutTitlesAnimationStyle()| 设置TarBarItem背景颜色不带title，归属defultStyle(),下面属性归属backgroundColorWithoutTitlesAnimationStyle()|
|irregularity()| 不规则TabBarItem显示，归属defultStyle(),下面属性归属irregularity()|
|setItemBgColor(...)|设置未选择TabBarItem背景颜色|
|setSelectItemBgColor(...)| 设置选择TabBarItem背景颜色|
|retunDefaultStyle()| 返回defuletStyle|
|cumstomStyle()|获取自定义样式设置，下面属性归属cumstomStyle() |
|setCumstonTabBarItemView(...) | 设置自定义TarBarItem数组|

##### 2.TabBarSetting基本属性

| 属性| 作用 | 
| :-----| :---- | 
|init(...)| 根据TabBarBasicParamBuilder初始化TabBarItem|
|setTabBarBackgroundColor(...)| 设置TarBar背景颜色|
|setTabBarBackgroundImage(...)| 设置TarBar背景图片|
|setShouldHijackHandler(...)| 设置TarBarItem点击回调，返回true代表拦截自行处理，false代表不进行拦截处理|
|setDidHijackhHandler(...)| 点击回调处理|
|setDefaultTabIndex(...)| 设置默认选择下标|
|setTabBarBadgeValue(...)| 设置某个TarBarItem的消息气泡内容|
|hideTabBadgeValue(...)| 隐藏某个TarBarItem的消息气泡|
|setTabBarBadgeValueColor(...) | 设置某个TarBarItem的消息气泡颜色|

##### 3.YYTabBar的使用
-  基本样式使用

        let chidVC=[CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController()]
        
        
        let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .defultStyle()
            .setTextColor(txtColor: UIColor.black)
            .setSelectTextColor(selectTxtColor: UIColor.red)
            .setImgColor(imageColor: UIColor.black)
            .setSelectImgColor(selectImageColor: UIColor.red)
            .build()
        
        
        let _:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)

-  TarBarItem不规则样式使用

        let chidVC=[CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController()]
        
        
        let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .defultStyle()
            .irregularity()
            .setIrregularityIndex(irregularIndex: 2)
            .setIrregularityBorderColor(borderColor: UIColor.white)
            .setIrregularityBackgroundColor(backgroundColor: UIColor.systemGreen)
            .retunDefaultStyle()
            .setSelectTextColor(selectTxtColor: UIColor.red)
            .setSelectImgColor(selectImageColor: UIColor.red)
            .build()

        let tab:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)
        tab.setTabBarBackgroundImage(backgroundImage: UIImage(named: "background_dark"))
        tab.setShouldHijackHandler(shouldHijackHandler:{
            tabBarController,viewController,index in
            
            if(index==2){
                return true
            }else{
                return false
            }
            
        })
        
        tab.setDidHijackhHandler(didHijackHandler: {
            tabBarController,viewController,index in
        })

-  设置背景颜色显示(不带title)

        let chidVC=[CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController(),CommonWithoutNavController()]
        
        
        let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .defultStyle()
            .backgroundColorWithoutTitlesAnimationStyle()//设置背景颜色显示(不带title)
            .setSwithcBouncesAnimation(switchBgAnimation: true)//开启弹簧动画
            .setSpecialIndexAndColor(bgColorIndex: 2)//设置背景颜色突出显示
            .retunDefaultStyle()
            .setRemindUseClickIndex(remindUseClickIndex: 2)//设置暗示用户点击
            .build()
        
        
        let _:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)

 - YYTabBar和YYNavigationBar结合使用

###### 两者结合使用需要注意的是如果内容ControllerView按照原来的高度设置底部会被TabBar遮挡，为了解决这个问题需要设置两步
- 第一步
在创建内容ControllerView之前需要计算出内容View的高度（UIViewController.autoHeight=UIScreen.main.bounds.height - self.tabBar.frame.height）


        let chidVC: [UIViewController] = titles.map { _ in
            UIViewController.autoHeight=UIScreen.main.bounds.height - self.tabBar.frame.height
            let vc: CommonWithNavController = CommonWithNavController()
            return vc
        }
        
        
        let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .defultStyle()
            .build()
        
        
        let _:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)

- 第二步
内容ControllerView需要实现AutoHeightUIViewController


-  YYTabBar默认消息气泡使用

        let tabBar:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)
        tabBar.setTabBarBadgeValue(index: 0, badgeValue: "99+")
        tabBar.setTabBarBadgeValue(index: 1, badgeValue: " ")
        tabBar.setTabBarBadgeValue(index: 2, badgeValue: "")
        tabBar.setTabBarBadgeValue(index: 3, badgeValue: "New")
        tabBar.setTabBarBadgeValue(index:4, badgeValue: "1")
        tabBar.setTabBarBadgeValueColor(index: 4, color: UIColor.blue)
        tabBar.setShouldHijackHandler(shouldHijackHandler: {
            tabBarController,viewController,index in
            
            if(index==2){
                tabBar.hideTabBadgeValue(index: 2)
            }else if(index==4){
                tabBar.setTabBarBadgeValueColor(index: 4, color: UIColor.red)
            }
            return false
        })

-  YYTabBar自定义TabBarItemView

######  1.YYTabBarItemContentView的介绍

| 属性| 作用 | 
| :-----| :---- | 
|insets| 设置contentView的偏移|
|selected| 是否被选中|
|insets| 设置contentView的偏移|
|highlighted| 是否处于高亮状态|
| highlightEnabled| 是否支持高亮|
|textColor|文字颜色|
|highlightTextColor| 高亮时文字颜色|
|iconColor|  icon颜色|
|backdropColor| 背景颜色|
|highlightBackdropColor| 高亮时背景颜色|
|title| 标题|
|badgeValue| 消息气泡内容|
|badgeColor| 消息气泡颜色|
|badgeView| 获取消息气泡View|
|selectAnimation(animated: Bool, completion: (() -> ())?)|设置选择时动画|
|reselectAnimation(animated: Bool, completion: (() -> ())?)|设置释放时动画|
|highlightAnimation(animated: Bool, completion: (() -> ())?)|设置高亮时动画|
|dehighlightAnimation(animated: Bool, completion: (() -> ())?)|设置释放高亮时动画|
|badgeChangedAnimation(animated: Bool, completion: (() -> ())?)|设置消息动画改变时动画|
###### 2.实现YYTabBarItemContentView，自定义相关参数
###### 3.设置自定义TabBarItemView

     let cumstonItemView=[CumstonSettingItemView(),CumstonAnimateWithTipsContentView(),CumstonAnimateWithNumContentView(),CumstonAnimateWithImgContentView(),cumstonRemindItemView]
        
     let builder:TabBarBasicParamBuilder=TabBarBasicParamBuilder
            .with(childVCs: chidVC, normalImgs: normalImgs, selectImgs: selectImgs, titles: titles)
            .cumstomStyle()
            .setCumstonTabBarItemView(cumstomItemView: cumstonItemView)
            .build()
        
     let tab:TabBarSetting=TabBarSetting(vc:self,tabBarBuilder: builder)


#### 七、YYPageView：图片轮播

![效果图](https://upload-images.jianshu.io/upload_images/4361802-d0a295c35e3bfa1c.gif?imageMogr2/auto-orient/strip)



- 创建PageView


        let pageView:YYPageView={
        let pageView:YYPageView=YYPageView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        pageView.register(YYDefaltPageViewCell.self, forCellWithReuseIdentifier: "cell")
        pageView.transformer = YYPageViewTransformer(type:.none)
        pageView.pageControl.interitemSpacing=10
        return pageView
        }()

- 实现YYPagerViewDataSource,YYPagerViewDelegate


        //设置轮滚图片的数量
        func numberOfItems(in pagerView: YYPageView) -> Int {
        return imageNames.count
        }
        //每个轮滚内容的设定
        func pagerView(_ pagerView: YYPageView, cellForItemAt index: Int) -> UICollectionViewCell {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! YYDefaltPageViewCell
            cell.imageView?.image=UIImage(named:imageNames[index] )
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            cell.textLabel?.text = String.init(format: "第%d张图片", index)
            return cell
        }

-  其它用法参照demo


#### 八、YYPageMenu：滑动菜单

![效果图](https://upload-images.jianshu.io/upload_images/4361802-7e7caf6ca38cae80.gif?imageMogr2/auto-orient/strip)



###### 1.YYPageMenu的基本使用(需要特别注意下面注释说明部分)


      let menu = YYPageMenu.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50),vc: self, titles: titles)
       //设置menu在NavigationBar下面
      PositionSettingUtils.position(aboveView: self.navigation.bar, childView: menu!, style: .adaptive)
      //设置内容View在menu下面
      PositionSettingUtils.position(aboveView: menu!, childView: menu!.page!.view, style: .fixed)
        
      self.view.addSubview(menu!)
        
        //为了解决遮挡问题，需要在初始化内容View之前计算出高度，并且内容View需要实现AutoHeightUIViewController
       let viewControllers: [UIViewController] = self.titles.map { _ in
            UIViewController.autoHeight=menu!.page!.view.frame.height
            let vc: ChildPageViewController = ChildPageViewController(pageMenuVc: self)
            return vc
        }
        //初始化内容View
        menu!.page?.initController(viewControllers: viewControllers)
        var style:YYPageMenuStyle=YYPageMenuStyle()
        style.indicatorColor = .red
        style.indicatorCorner = .corner(value: 3)
        style.indicatorStyle = .line(widthType: .sizeToFit(minWidth: 20), position: .bottom((margin: 1, height: 2)))
        style.titleFont = UIFont.systemFont(ofSize: 18)
        style.selectedTitleColor=UIColor.red
        menu!.style=style
        menu!.backgroundColor=UIColor.yellow
        //menu选择回调
        menu!.page!.didFinishPagingCallBack={
            currentViewController,currentIndex in
            self.menu!.setSelectIndex(index: currentIndex)
        }

###### 2.YYPageMenuStyle的基本属性

| 属性| 作用 | 
| :-----| :---- | 
|indicatorColor| 指示器颜色|
|indicatorStyle| 指示器风格,类型为YYPageMenuIndicatorStyle:横线类型，line(widthType: YYPageMenuItemWidthType, position: YYPageMenulinePosition)/覆盖类型，cover(widthType: YYPageMenuItemWidthType) |
|indicatorCorner| 指示器圆角|
|labelWidthType| label 宽度类型 固定宽度 或 随文字适应宽度 ,类型主要为YYPageMenuItemWidthType：铺满，fixed(width: CGFloat)/自适应，sizeToFit(minWidth: CGFloat)|
| titleFont| 标题字体|
|normalTitleColor|normalTitleColor|
|selectedTitleColor| 选中标题颜色|
|iconColor|  icon颜色|
|backdropColor| 背景颜色|
|highlightBackdropColor| 高亮时背景颜色|
|title| 标题|
|badgeValue| 消息气泡内容|
|badgeColor| 消息气泡颜色|

#### 九、YYRefresh:下拉刷新/上拉加载更多

![效果图](https://user-gold-cdn.xitu.io/2020/2/11/17033382db40c96f?w=235&h=420&f=gif&s=1239377)

-  使用默认下拉刷新/上拉加载更多样式

        let refreshView:YYDefaultRefreshHeaderAnimator=YYDefaultRefreshHeaderAnimator.init(frame: .zero)
        let footView:YYDefaultRefreshFooterAnimator=YYDefaultRefreshFooterAnimator.init(frame: .zero)
        
        self.tableView.yy.addPullToRefreshListener(animator: refreshView, handler: {
            [weak self] in
            self?.refresh()
            },aboveView: navigation.bar,childView: self.tableView)
        
        self.tableView.yy.addLoadMoreListener(animator: footView){
            [weak self] in
            self?.loadMore()
        }

- 默认控件YYDefaultRefreshHeaderAnimator/YDefaultRefreshFooterAnimator修改提示文本

| 属性| 作用 | 
| :-----| :---- | 
| YYDefaultRefreshHeaderAnimator| | 
| pullToRefreshDescription| 刷新提示文本 | 
| releaseToRefreshDescription| 释放提示文本 | 
| loadingDescription| 正在加载提示文本 | 
| YDefaultRefreshFooterAnimator| | 
| loadingMoreDescription| 上拉加载提示文本 | 
| noMoreDataDescription| 没有数据提示文本 | 
| loadingDescription| 正在加载提示文本 | 
   

- 常用的方法

| 方法| 作用 | 
| :-----| :---- | 
|addPullToRefreshListener(animator: YYRefreshProtocol & YYRefreshAnimatorProtocol, handler: @escaping YYRefreshHandler,aboveView:UIView,childView:UIView)| 添加下拉刷新样式、刷新回调、以及在某个控件下面|
|addLoadMoreListener(animator: YYRefreshProtocol & YYRefreshAnimatorProtocol, handler: @escaping YYRefreshHandler) | 添加上拉加载更多样式、刷新回调 |
|removeRefreshHeader()| 移除下拉刷新控件|
|removeRefreshFooter()| 移除上拉刷新控件|
|startPullToRefresh()| 开始下拉刷新|
|autoPullToRefresh()| 自动下拉刷新|
|stopPullToRefresh()| 停止下拉刷新|
|noticeNoMoreData()| 通知已经没数据可加载|
|resetNoMoreData()| 重新设置没有数据|
|stopLoadingMore()| 停止上拉加载刷新|

- 自定义加载控件
实现UIView,YYRefreshAnimatorProtocol,YYRefreshProtocol即可根据里面提供的参数进行自定义，具体可以参考demo

#### 十、YYImageLoader:网络图片加载

![效果图](https://upload-images.jianshu.io/upload_images/4361802-835a2427319bd920.gif?imageMogr2/auto-orient/strip)

- 常用的方法

| 方法| 作用 | 
| :-----| :---- | 
|loadImage(urlString: String,placeholder: UIImage? = nil,completion: ((_ success: Bool, _ error: Error?) -> Void)? = nil)| 加载网络图片|
|loadImage(url: URL, placeholder: UIImage? = nil,completion: ((_ success: Bool, _ error: Error?) -> Void)? = nil)| 加载网络图片 |
|loadImage(request: URLRequest,placeholder: UIImage? = nil,completion: ((_ success: Bool, _ error: Error?) -> Void)? = nil)| 加载网络图片|

- 全局的方法YYImageCache

| 方法| 作用 | 
| :-----| :---- | 
|diskCacheMaxAge| 设置最大缓存时间|
|timeoutIntervalForRequest| 请求超时|
|requestCachePolicy| 图片加载策略|


- 基本使用代码

       imageView.loadImage(urlString: "https://n.sinaimg.cn/tech/transform/8/w334h474/20200107/57f4-imvsvyz4459804.gif",placeholder: UIImage.init(named: "b"))

#### 十一、YYDialog:通用提示框

![效果图](https://upload-images.jianshu.io/upload_images/4361802-a1c845c4338c08af.gif?imageMogr2/auto-orient/strip)

- 默认提示框使用

AlertDialog

    YYDialog
                .createAlertDialog()
                .defalutDialog()
                .setTitleColor(color: UIColor.red)
                .setTitleSize(ofSize: 20)
                .setContentColor(color: UIColor.gray)
                .setSubmitBtnSize(ofSize: 20)
                .setSubmitBtnContentColor(color: UIColor.green)
                .setAnimationOption(animationOption: .zoom)
                .setSubmitButtonListener(clickSubmitBlock: {
                    _ in
                    YYDialog
                        .createToast()
                        .show(view: self.view, text: "点击了确定按钮")
                })
                .setButtonType(btnType: .both)
                .show(title: "提示", message: "因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。")

Toast

    YYDialog
                .createToast()
                .show(view: self.view, text: "因为你是这个世界上最干净的，最温暖的，最柔软的，我不能用那些通用的所谓聪明来解释你，来对待你，来敷衍你。")


LoadingDialog



    let dialog = YYDialog
                .createLoadingDialog()
                .defalutDialog()
            
     dialog
             .setMessageSize(fontSize: 16)
              .setContentViewCornerRadius(radius: 5)
              .setMaskLayer(showMaskLayer: true)
              .setAnimationOption(animationOption: .zoom)
              .show(message: "请稍后...")
           
- 自定义提示框

###### 1.实现BaseDialogContentView

| 属性| 作用 | 
| :-----| :---- | 
|_contentWidth| 提示框宽度，BaseDialogContentView已设置默认值|
|_contentHeight| 提示框高度，必设值|
|animationOption| 提示框动画，BaseDialogContentView已设置默认值|

###### 2.自定义使用方法

    let dialog=YYDialog
                .createLoadingDialog()
                .customDialog(custom: CustomLoadingDialog())
            
     dialog.show()


- 其它属性修改请参照demo



#### 十二、DataManager的使用(Http、UserDefaults、File、SQLite)

![](https://user-gold-cdn.xitu.io/2020/2/16/1704e62f5d167b47?w=235&h=420&f=gif&s=968776)

######  DataManager的属性

- DataForHttp(DataManager里的Http模块)

| 属性| 作用 | 
| :-----| :---- | 
|GlobalSetting(Http全局参数设定模块)||
|showHttpRequestLog| Http请求日志输出|
|cacheTimeOutWithClear| 缓存过期时间|
|timeoutIntervalForRequest| 超时时间|
|HttpOfNormal(Http的基本网络请求模块)||
|Request<T:Convertible>.request(...)| Http通用请求方法，直接转化成Bean类，Bean类需要继承Convertible|
|Share.cancel(...)| 取消请求|
|Share.removeAllCache(...)| 清除所有缓存|
|Share.removeObjectCache(...)| 根据url和params清除缓存|
|HttpOfUpload(Http的图片上传模块)| |
|Upload<T:Convertible>.upload(...)| Http通用上传方法，直接转化成Bean类，Bean类需要继承Convertible|
|HttpOfDownload(Http的文件下载模块)| |
|Download.download(...)| Http通用下载方法|
|Download.resume(...)| 每次进入下载页面需要进行下载初始化|
|Download.downloadCancel(...)|取消下载|
|Download.downloadCancelAll()|取消全部下载|
|Download.downloadPercent(...)|下载百分比|
|Download.downloadDelete(...)|删除某个下载|
|Download.downloadStatus(...)|取消状态|
|Download.downloadFilePath(...)|下载完成后，文件所在位置|

- DataForSQLiteDB(DataManager里的SQLite模块)

| 属性| 作用 | 
| :-----| :---- | 
|QueryData<T:Convertible>.queryAllData()|查询bean类所有的数据,T代表bean类型，需要继承Convertible以及SQLiteModel|
|QueryData<T:Convertible>.queryAllDataByAsnyc(...)| 异步查询bean类所有数据，T代表bean类型，需要继承Convertible以及SQLiteModel|
|QueryData<T:Convertible>.queryDataByWhere(...)| 根据sql条件查询数据|
|QueryData<T:Convertible>.queryDataWithWhereByAsync(...)| 异步根据sql条件查询数据|
|QueryData<T:Convertible>.queryDataByFirst(...)| 查询第一条数据|
|Share.insertData(...)| 插入数据|
|Share.insertDataList(...)| 插入列表数据|
|Share.insertDataListByAsync(...)| 异步插入列表数据|
|Share.deleteDataByWhere(...)| 根据sql条件删除数据|
|Share.deleteAllData(...)| 删除所有数据|
|Share.deleteAllDataByAsync(...)| 异步删除所有数据|
|Share.updateData(...)| 更新数据|
|Share.updateDataList(...)| 更新数据列表|
|Share.updateDataListByAsync(...)| 异步更新数据列表|
|Share.drop(...)| 删除表|

- DataForFile(DataManager里的File模块)

| 属性| 作用 | 
| :-----| :---- | 
|saveObjectForFile(...)|保存字段内容，其中参数appendFolderPathAndFileName代表文件路径，这里只需设定补充路径(/test/test.txt)|
|queryObjectForFile(...)|根据路径获取内容|

- DataForUserDefaults(DataManager里的UserDefaults模块)

| 属性| 作用 | 
| :-----| :---- | 
|saveObjectForKey(...)|  保存内容|
|queryObjectForKey(...)|根据Key获取内容|

###### 1.Http

- 基本网络请求

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
        }, requestFailureResult: {
            error in
        })


###### 注意：在请求时候需要传入一个泛型类作为json数据的转换数据结构，bean类需要实现Convertible才能转化

- HttpRequestParams

| 属性| 作用 | 
| :-----| :---- | 
|setReponseType(responseType:ReponseType)| 设置响应方式，cache：返回缓存数据，netWork：返回网络数据，noCacheRetrunNetWork：缓存优先|
|setHttpTypeAndReqParamType(参数)| 设置请求方法以及请求参数类型，post_json：method为post,请求参数为json格式，pos_param：method为post,请求参数为键值对，get：method为get|
|setReqUrl(requestUrl:String)| 设置请求Url|
|setUrlRequest(urlRequest: URLRequestConvertible)| 设置请求URLRequest|
|setRequestType(requestType:RequestType)| 设置请求的类型|
|setParams(params: Parameters)| 设置请求参数集合|
|setParam(key:String,param:Any)| 设置请求参数 |
|setHttpHeaders(headers: HTTPHeaders)| 设置请求头列表|
|setHttpHeader(key:String,header:String)| 设置请求头|

- 文件下载

 ###### 1. 每次进入下载页面需要进行下载初始化

    DataManager.DataForHttp.HttpOfDownload.Download.resume(url: item.downloadUrl, downloadResume: {
            //
     })

 ###### 2. 文件下载

    let downloadParams:HttpDownloadRequestParams=HttpDownloadRequestParams()
                downloadParams
                    .setFileName(fileName: "\(item.indexPath.row)---.pdf")
                    .setReqUrl(requestUrl: url!)
                    .build()
                
    DataManager.DataForHttp.HttpOfDownload.Download.download(httpDownloadRequestParams: downloadParams, requestSuccessResult: {
                    respone in
                   
                },requestFailureResult: {
                    error in
                    
                },downloadProgress: {
                    progress in
                    
                })
- HttpDownloadRequestParams

| 属性| 作用 | 
| :-----| :---- | 
|setFileName(fileName:String)| 设置下载文件名|
setHttpTypeAndReqParamType(参数)| 设置请求方法以及请求参数类型，post_json：method为post,请求参数为json格式，pos_param：method为post,请求参数为键值对，get：method为get|
|setReqUrl(requestUrl:String)| 设置请求Url|
|setParams(params: Parameters)| 设置请求参数列表|
|setParam(key:String,param:Any)| 设置请求参数 |
|setHttpHeaders(headers: HTTPHeaders)| 设置请求头列表|
|setHttpHeader(key:String,header:String)| 设置请求头|


 -  图片上传




         let url="xxxxx"
         let httpParams=HttpUploadRequestParams()
         httpParams
             .setParam(key: "type", param: "addroadblock")//设置请求参数也可通过setParams()设置Array
             .setReqUrl(requestUrl: url) //设置请求链接
             .setFileSuffixName(fileSuffixName: ".jpg") //设置文件后缀名，后续上传其它文件扩展也可使用
             .setImages(images: [UIImage(named: "d")!,UIImage(named: "e")!])//设置上传图片列表
             .setMultiparName(multipartName: "imgList") //设置对应后台服务器上传文件字段
             .build()
                
            /**
            通过泛型设置结果转换的been类，可返回上传进度
            */
                
        DataManager.DataForHttp.HttpOfUpload.Upload.upload(httpRequestParams: httpParams, requestSuccessResult: {
            result in
        }, requestFailureResult: {
            error in
                                
        }, requestProgress: {
            progress in
        })

- HttpUploadRequestParams

| 属性| 作用 | 
| :-----| :---- | 
|setMultiparName(multipartName:String)| 后天接口提供的字段名|
|setImages(images: [UIImage]?) | 设置上传图片|
|setFileSuffixName(fileSuffixName:String)| 设置上传图片后缀名|
|setReqUrl(requestUrl:String) | 设置请求url|
|setParams(params: Parameters)| 设置请求参数|
|setParam(key:String,param:Any)-| 设置请求参数 |
|setHttpHeaders(headers: HTTPHeaders)-| 设置请求头|
|setHttpHeader(key:String,header:String)| 设置请求头|


 ###### 2.SQLite

- 初始化数据库和数据库迁移


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

###### 注意：
######  1.设置数据库名称
######  2.通过SQLiteVersionMigrate可以进行版本迁移
######  3.SQLiteVersionMigrate

| 属性| 作用 | 
| :-----| :---- | 
|setDbVersion(...)| 设置数据名、版本号、版本变化回调|
|with(...)|设置需要变化bean类|
|addAttribute(...)| 表需要增加的字段|



- 保存的bean类



        @objcMembers
        class SqliteData: SQLiteModel,Convertible{

            var des:String=""
            var id:Int=0
    
            override func primaryKey() -> String {
                return "id"
            }
   
        }

###### 注意：bean需要：
######  1.使用@objcMembers  
######  2.实现SQLiteModel
######  3.实现Convertible(Json转化成bean需要)
######  4.实现primaryKey()方法，必须指定主键

- 实例初始化


        let commonSqliteData=SqliteData()
        commonSqliteData?.id=0
        commonSqliteData?.des="SQLite测试使用"

- 插入数据


        DataManager.DataForSQLiteDB.Share.insertData(object: commonSqliteData!)

- 删除所有数据


        DataManager.DataForSQLiteDB.Share.deleteAllData(cls: SqliteData.self)

- 异步插入数据


        DataManager.DataForSQLiteDB.Share.insertDataListByAsync(cls: SqliteData.self, objectList: list, insertCompleteBlock: {
        })

- 更新数据


        DataManager.DataForSQLiteDB.Share.updateData(object: commonSqliteData!)

- 查询数据


        let result=DataManager.DataForSQLiteDB.QueryData<SqliteData>.queryAllData()
        DataManager.DataForSQLiteDB.Share.updateData(object: commonSqliteData!)

- 其它可以查看DataManager


 ###### 3.File

- 查询数据


        let result=DataManager.DataForFile<String>.queryObjectForFile(appendFolderPathAndFileName:"test/test.txt")


- 保存数据


        //保存String类型
        DataManager.DataForFile<String>.saveObjectForFile(appendFolderPathAndFileName:"test/test.txt" , object: "123")
        //保存类型
        DataManager.DataForFile<UserDeBean>.saveObjectForFile(appendFolderPathAndFileName: appendBeanPath, object: userDefault)


 ###### 3.UserDefaults

- 保存数据


        DataManager.DataForUserDefaults<String>.saveObjectForKey(key: "key1", object:"1234")

- 查询数据


        let result=DataManager.DataForUserDefaults<UserDeBean>.queryObjectForKey(key: "key2")




#### 十三、YYDataShowView:数据加载显示页面

![效果图](https://upload-images.jianshu.io/upload_images/4361802-5861316f375b5494.gif?imageMogr2/auto-orient/strip)


- YYDataShowView基本用法

| 属性| 作用 | 
| :-----| :---- | 
|init(defaultDataShowViewParams:DefaultDataShowViewParams,...)| 默认初始化方法|
|init(custom:BaseDataShowContentView,visibileHeight:CGFloat?=UIScreen.main.bounds.height,aboveView:UIView?=nil)) | 自定义展示内容初始化方法|
|show(parentView:UIViewController)| 显示DataShowView|
|hide() | 隐藏DataShowView|

- DefaultDataShowViewParams基本用法

| 属性| 作用 | 
| :-----| :---- | 
|setDefaultDataShowViewType(...)| 设置显示样式：noData、noNetWork、loading|
|setDefaultNoDataShowImg(...)| 设置没有数据时显示的图片|
|setDefaultNoNetworkShowImg(...)| 设置没有网络是显示的图片|
|setDefaultShowImgWidth(...) | 设置显示图片的宽度|
| setDefaultShowImgHeight(...)| 设置显示图片的高度 | 
| setDefaultShowNoDataText(...)| 设置没有数据时显示的文本| 
|setDefaultShowNoNetWorkText(...)| 设置没有网络时显示的文本|
|setDefaultShowTextSize(...)| 设置显示文本的字体大小|
|setDefaultShowTextColor(...)| 设置显示文本的颜色|
|setDefaultShowButtonText(...) | 设置按钮的文本|
|setDefaultShowButtonTextSize(...) | 设置按钮的字体大小|
|setDefaultShowButtonTextColor(...)| 设置按钮的文本颜色|
|setDefaultShowButtonBorderWidth(...) | 设置按钮的外边框宽度|
|setDefaultShowButtonBorderColor(...)| 设置按钮外边框颜色|
|setDefaultSHowButtonPadding(...) | 设置按钮的内边距|
|setDefaultShowButtonCornerRadius(...)| 设置按钮的圆角|
|setHiddenShowButton(i...)  | 设置按钮是否显示|
|setDefaultShowButtonBackgroundColor(...)| 设置按钮背景颜色|
|setDefaultShowLoadingText(...)| 设置加载文本|
|setDefaulutShowLoadingImgsTimeInterval(...)| 设置加载Image的间隔时间|


- 没有数据样式


    let defaultDataShowViewParams=DefaultDataShowViewParams()
    defaultDataShowViewParams
            .setDefaultNoDataShowImg(defaultNoDataShowImg: "nodata")
            .build()
    dataShowView=YYDataShowView(defaultDataShowViewParams:defaultDataShowViewParams,aboveView: navigation.bar,reloadHandler: {
            YYDialog.createToast().show(view: self.view, text: "点击重新加载按钮")
    })
        
    dataShowView!.show(parentView: self)


- 没有网络样式


     let defaultDataShowViewParams=DefaultDataShowViewParams()
     defaultDataShowViewParams
            .setDefaultDataShowViewType(showViewType: .noNetWork)
            .setDefaultNoNetworkShowImg(defaultNoNetworkShowImg: "nonetwork")
            .build()
        
      dataShowView=YYDataShowView(defaultDataShowViewParams: defaultDataShowViewParams,aboveView: navigation.bar,reloadHandler: {
            YYDialog.createToast().show(view: self.view, text: "点击重新加载按钮")
        })
        
       dataShowView!.show(parentView: self)


- 加载数据样式


    let imgs=["default_data_show_loading1","default_data_show_loading2","default_data_show_loading3","default_data_show_loading4","default_data_show_loading5","default_data_show_loading6","default_data_show_loading7","default_data_show_loading8","default_data_show_loading10","default_data_show_loading11","default_data_show_loading12"]
        
    let defaultDataShowViewParams=DefaultDataShowViewParams()
        defaultDataShowViewParams
            .setDefaultDataShowViewType(showViewType: .loading)
            .setDefaultLoadingImags(defaultLoadingImags: imgs)
            .build()
        
     dataShowView=YYDataShowView(defaultDataShowViewParams: defaultDataShowViewParams,aboveView: navigation.bar)
     dataShowView!.show(parentView: self)

- 自定义样式

##### 1.实现BaseDataShowContentView，然后指定_contentHeight(高度)
##### 2.加载自定义View


    let customView=CustomDataShowView()
    YYDataShowView.init(custom: customView,aboveView: navigation.bar).show(parentView: self)
    
    
#### 十四、YYTagView

![效果图](https://upload-images.jianshu.io/upload_images/4361802-352e9468be1ce1aa.gif?imageMogr2/auto-orient/strip)

- 基本用法

| 属性| 作用 | 
| :-----| :---- | 
|YYTagViewBuilder||
|setTagTextColor(...)| 设置Tag的字体颜色|
|setTagSelectedTextColor(...)| 设置Tag点击的字体颜色|
|setTagLineBreakMode(...)| 设置Tag的LineBreakMode|
|setTagBackgroundColor(...)| 设置Tag的背景颜色|
|setTagSelectBackgroundColor(...)| 设置Tag的选择时的背景颜色|
|setTagCornerRadius(...)| 设置Tag圆角|
|setTagBorderWidth(...)| 设置Tag外框宽度|
|setTagBorderColor(...)| 设置Tag的外框颜色|
|setTagSelectedBorderColor(...)| 设置Tag外框选择时颜色|
|setTagHorizontalPadding(...)| 设置Tag的左右内边距|
|setTagVerticalPadding(...)| 设置Tag的上下内边距|
|setTagHorizontalMargin(...)| 设置Tag的左右外边距|
|setTagVerticalMargin(...)| 设置Tag的上下外边距|
|setTagAlignment(...)| 设置TagView的位置|
|setTagShadowColor(...)| 设置Tag的阴影颜色|
|setTagShadowRadius(...)| 设置Tag的阴影圆角|
|setTagTextFont(...)| 设置Tag的字体|
|setTagItem(...)| 增加TagItem|
|setTagItems(...)| 设置TagItem列表|
|setTagVerticalMargin(...)| 设置Tag的上下外边距|
|buildTagView(...)| 返回TagView|
|TagView| |
|removeTag(...)| 移除TagItem|
|removeAllTags()|移除TagItems |
|setTagClick(...)|设置TagItem点击事件 |


- 基本使用代码

      let tags=["测试使用内容","YYTagView","33","西亚","123456","ijklmn","45677","This should be the third tag","人间烟火"]
        
      let tagView=YYTagViewBuilder
            .with()
            .setTagItems(tags)
            .setTagTextFont(textFont: UIFont.systemFont(ofSize: 20))
            .setTagTextColor(color: UIColor.white)
            .setTagAlignment(alignment: .center)
            .setTagBackgroundColor(color: UIColor.systemBlue)
            .setTagSelectedTextColor(color: UIColor.red)
            .setTagSelectedBorderColor(color: UIColor.gray)
            .setTagCornerRadius(cornerRadius: 5)
            .setTagVerticalPadding(padding: 10)
            .setTagHorizontalPadding(padding: 10)
            .setTagVerticalMargin(margin: 10)
            .setTagHorizontalMargin(margin: 10)
            .buildTagView()
        
        
        tagView.setTagClick(tagClick: {
            title,tagView,sender in
            print(title)
        })   
        
        
        
#### 十五、MVP

##### 步骤：
- 1.创建一个Presenter,实现BasePresenter
- 2.创建一个与View关联的协议
- 3.实现IBaseControllerView<T:BasePresenter>和2创建的协议
- 4.通过mPresenter调用Presenter里的方法
- 5.在Presenter里通过mView调用View的方法

##### 代码

- 协议以及Presenter

      protocol MvpView {
          func refreshUI(value:Result<Array<ContentInfo>>)
      }

      class MvpPresenter:BasePresenter{
    
          func requestData() {
        
          let urlStr = "https://api.apiopen.top/getJoke?page=1&count=20&type=video"
        
          let httpParams:HttpRequestParams=HttpRequestParams()
          httpParams
            .setRequestType(requestType: .reqStringUrl)
            .setReqUrl(requestUrl: urlStr)
            .setReponseType(responseType: .netWork)
            .setHttpTypeAndReqParamType(httpTypeAndReqParamType: .get)
            .build()
        
           DataManager.DataForHttp.HttpOfNormal.Request<Result<Array<ContentInfo>>>.request(httpRequestParams: httpParams, requestSuccessResult: {
            value in
            
            
            (self.mView as! MVPUseControllerView).refreshUI(value: value)
            
        }, requestFailureResult: {
            error in
        })
        
        }

      }

- View实现

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
        
        
        let imgs=["default_data_show_loading1","default_data_show_loading2","default_data_show_loading3","default_data_show_loading4","default_data_show_loading5","default_data_show_loading6","default_data_show_loading7","default_data_show_loading8","default_data_show_loading10","default_data_show_loading11","default_data_show_loading12"]
        
        let loadingDataShowViewParams=DefaultDataShowViewParams()
        loadingDataShowViewParams
            .setDefaultDataShowViewType(showViewType: .loading)
            .setDefaultLoadingImags(defaultLoadingImags: imgs)
            .build()
        dataLoadingView=YYDataShowView(defaultDataShowViewParams:loadingDataShowViewParams,aboveView:navigation.bar)
        
        self.dataLoadingView?.show(parentView: self)
        
        mPresenter?.requestData()
        
       }
      }



#### 十六、通用工具类

- IPhoneUtils

| 属性| 作用 | 
| :-----| :---- | 
|getNavBarHeight()|获取NavigationBar高度 |
|isIphoneX()|判断是否是iphoneX以上 |

- ColorUtils

| 属性| 作用 | 
| :-----| :---- | 
|clickSelectBgChange(...)|设置View点击时的背景变化 |
|RGBColor(...)|获取RGB颜色 |
|colorWithHexString()|16进制颜色转化成UIColor|

- InternationalUtils

| 属性| 作用 | 
| :-----| :---- | 
|getString(...) |获取本地Localizable对应的内容 |
|initUserLanguage()|初始化语言 |
|setLanguage(...)|设置当前语言|
|getCurrentLanguage() |获取当前语言|

- UILabelUtils

| 属性| 作用 | 
| :-----| :---- | 
|getLabHeigh(...) |获取UILabel高度 |

- PositionSettingUtils

| 属性| 作用 | 
| :-----| :---- | 
|position(...) |设置View的位置和高度 |

- Logger(日志输出)

- UILabelPadding(可设置内边距的UILabel)

| 属性| 作用 | 
| :-----| :---- | 
|init(...) |初始化UILabel，设置内边距 |
