//
//  YYPageMeun.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/2.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

public struct YYPageMenuStyle {
    
    
    /// 计算 遮罩 与 文字
    public var indicatorPendingHorizontal: CGFloat  = 16
    
    // 只在 cover 时用
    public var indicatorPendingVertical: CGFloat    = 10
    
    /// 计算 Label 与 文字
    public var titlePendingHorizontal: CGFloat      = 20
    public var titlePendingVertical: CGFloat        = 10
    
    /// 指示器颜色
    public var indicatorColor = UIColor(white: 0.9, alpha: 1)
    
    /// 指示器风格
    public var indicatorStyle: YYPageMenuIndicatorStyle = .cover(widthType:.sizeToFit(minWidth: 10))
    
    /// 指示器圆角
    public var indicatorCorner: YYPageMenuIndicatorCornerStyle = .semicircle
    
    /// label 宽度类型 固定宽度 或 随文字适应宽度
    public var labelWidthType: YYPageMenuItemWidthType = .sizeToFit(minWidth: 50)
    
    /// 指示器 宽度类型 固定宽度 或 随文字适应宽度
    public var indicatorWidthType: YYPageMenuItemWidthType {
        get { return indicatorStyle.widthType }
    }
    
    /// 标题字体
    public var titleFont = UIFont.boldSystemFont(ofSize: 14)
    /// 正常标题颜色
    public var normalTitleColor = UIColor.lightGray
    
    /// 选中标题颜色
    public var selectedTitleColor = UIColor.darkGray
    
    public init() {}
    
}


@IBDesignable public class YYPageMenu: UIControl {
    
    public typealias PageMeunIndexChangeCallBack = ((Int) -> Void)

    
    public var page: YYPagingViewController?
    var vc: UIViewController?
    
    
    public var style: YYPageMenuStyle {
        didSet {
            reloadData()
        }
    }
    @IBInspectable public var titles:[String] {
        didSet {
            guard oldValue != titles else { return }
            reloadData()
            setSelectIndex(index: 0, animated: true)
        }
    }
    public var valueChange: PageMeunIndexChangeCallBack?
    
    public var isScrollEnable: Bool {
        set {
            self.scrollView.isScrollEnabled = newValue
        }
        get {
            return self.scrollView.isScrollEnabled
        }
    }
    
    fileprivate var titleLabels: [UILabel] = []
    
    public private(set) var selectIndex = 0
    
     let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.bounces = true
        view.isPagingEnabled = false
        view.scrollsToTop = false
        view.isScrollEnabled = true
        view.contentInset = UIEdgeInsets.zero
        view.contentOffset = CGPoint.zero
        view.scrollsToTop = false
        return view
    }()
    
    private let selectContent =  UIView()
    
    private var indicator: UIView = {
        let ind = UIView()
        ind.layer.masksToBounds = true
        return ind
    }()
    private let selectedLabelsMaskView: UIView = {
        let cover = UIView()
        cover.layer.masksToBounds = true
        return cover
    }()
    
    private var indicatorFrames: [CGRect] = []
    private var titleLabelFrames: [CGRect] = []
    
    
    //MARK:- 初始化
    public convenience init(frame:CGRect,vc: UIViewController,titles: [String]) {
        self.init(frame:frame,vc: vc,segmentStyle: YYPageMenuStyle(), titles:  titles)
    }
    
    public init(frame:CGRect, vc: UIViewController,segmentStyle: YYPageMenuStyle, titles: [String]) {
        self.style = segmentStyle
        self.titles = titles
        self.vc=vc
        super.init(frame:frame)
        shareInit()
        
    }

    
    required public init?(coder aDecoder: NSCoder) {
        self.style = YYPageMenuStyle()
        self.titles = []
        
        super.init(coder: aDecoder)
        shareInit()
    }
    
    
    private func shareInit() {
        
        page = YYPagingViewController()
        page!.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        vc!.addChild(page!)
        page!.didMove(toParent: vc!)
        vc!.view.addSubview(page!.view)
        
        self.valueChange = { [weak self] index in
            self?.page!.pagingToViewController(at: index)
        }
        
        addSubview(UIView())
        addSubview(scrollView)
        reloadData()
    }
    
    /// 点击手势
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let x = gesture.location(in: self).x + scrollView.contentOffset.x
        for (i, label) in titleLabels.enumerated() {
            if x >= label.frame.minX && x <= label.frame.maxX {
                setSelectIndex(index: i, animated: true)
                break
            }
        }
        
    }
    
    
    /// 清除
    private func clearData() {
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        selectContent.subviews.forEach { $0.removeFromSuperview() }
        if let gescs = gestureRecognizers {
            for gesc in gescs {
                removeGestureRecognizer(gesc)
            }
        }
        titleLabels.removeAll()
    }
    
    private func reloadData() {
        clearData()
        guard self.titles.count > 0  else {
            return
        }
        UIView.animate(withDuration: 0.2) {
            // 设置 每个标题的大小
            self.setupItems()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(YYPageMenu.handleTapGesture(_:)))
        
        addGestureRecognizer(tapGesture)
        applySelected(index: 0, animated: true)
    }
    
    private func setupItems() {
        
        // 这里颜色 随便取 目的是让 layer不透明 layer默认是透明的
        selectedLabelsMaskView.backgroundColor = UIColor.white
        scrollView.frame = bounds
        selectContent.frame = bounds
        selectContent.layer.mask = selectedLabelsMaskView.layer
        selectedLabelsMaskView.isUserInteractionEnabled = true
        
        createLabels()
        
        indicator.backgroundColor = style.indicatorColor
        scrollView.addSubview(indicator)
        scrollView.addSubview(selectContent)
        
    }
    
    
    /// 创建标题
    private func createLabels() {
        
        // 移除所有
        indicatorFrames.removeAll()
        titleLabelFrames.removeAll()
        
        let font  = style.titleFont
        var labelX: CGFloat = 0
        let labelH = bounds.height
        let labelY: CGFloat = 0
        var labelW: CGFloat = 0
        
        // label 是否固定宽度
        let labelWidthIsFixed = style.labelWidthType.isFixed
        
        for (index, title) in titles.enumerated() {
            
            /// Label文字大小
            let titleSize = title.size(with: font)
            
            // 根据Label文字大小 设置 Label Frame
            if labelWidthIsFixed {
                labelW = style.labelWidthType.width
            }else {
                
                labelW = titleSize.width + titlePendingHorizontal
                let minWidth = style.labelWidthType.width
                if labelW < minWidth { labelW = minWidth }
            }
            
            labelX = (titleLabels.last?.frame.maxX ?? 0 )
            
            let rect = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            let backLabel = UILabel(frame: CGRect.zero)
            backLabel.tag = index
            backLabel.text = title
            backLabel.textColor = style.normalTitleColor
            backLabel.font = style.titleFont
            backLabel.textAlignment = .center
            backLabel.frame = rect
            
            let frontLabel = UILabel(frame: CGRect.zero)
            frontLabel.tag = index
            frontLabel.text = title
            frontLabel.textColor = style.selectedTitleColor
            frontLabel.font = style.titleFont
            frontLabel.textAlignment = .center
            frontLabel.frame = rect
            
            titleLabelFrames.append(rect)
            titleLabels.append(backLabel)
            scrollView.addSubview(backLabel)
            selectContent.addSubview(frontLabel)
            
            createIndicatorFrame(with: index, textSize: titleSize, label: frontLabel)
        }
        scrollView.contentSize.width = titleLabelFrames.last!.maxX
        selectContent.frame.size.width = titleLabelFrames.last!.maxX
    }
    
    //创建 指示器Frame
    private func createIndicatorFrame(with index: Int, textSize: CGSize, label: UILabel) {
        
        // indicator 是否固定宽度
        let indicatorWidthIsFixed = style.indicatorWidthType.isFixed
        
        switch style.indicatorStyle {
        //遮罩类型指示器
        case .cover:
            var coverW: CGFloat = 0
            var coverH: CGFloat = 0
            
            if indicatorWidthIsFixed {
                coverW = style.indicatorWidthType.width
                coverH = textSize.height + self.style.indicatorPendingVertical
            }else {
                coverW = textSize.width + self.style.indicatorPendingHorizontal
                coverH = textSize.height + self.style.indicatorPendingVertical
                
                let coverMinWidth = style.indicatorWidthType.width
                if coverW < coverMinWidth { coverW = coverMinWidth }
            }
            
            let coverSize = CGSize(width: coverW, height: coverH)
            let indicatorFrame = CGRect(center: label.center, size: coverSize)
            indicatorFrames.append(indicatorFrame)
            
        // 横线类型指示器
        case let .line(widthType, position):
            var lineW: CGFloat = 0
            let lineH: CGFloat = position.height
            
            if indicatorWidthIsFixed {
                lineW = widthType.width
            }else {
                lineW = textSize.width + self.style.indicatorPendingHorizontal
                
                let lineMinWidth = widthType.width
                if lineW < lineMinWidth { lineW = lineMinWidth }
            }
            
            let lineSize = CGSize(width: lineW, height: lineH)
            
            var lineCenterY: CGFloat = 0
            switch position {
            case .top:
                lineCenterY = 0 + position.margin + lineH/2
            case .bottom:
                lineCenterY = label.frame.maxY - position.margin - (lineH/2.0)
            }
            
            let lineFrame = CGRect(center: CGPoint.init(x: label.center.x, y: lineCenterY), size: lineSize)
            indicatorFrames.append(lineFrame)
        }
    }
    
    /// 设置 指示器Frame
    private func applyIndicatorFrame(at index: Int, animated: Bool = true) {
        let indicatorFrame = self.indicatorFrames[index]
        let labelFrame = self.titleLabelFrames[index]
        
        let applyFrame = {
            self.indicator.frame = indicatorFrame
            self.selectedLabelsMaskView.frame = labelFrame
            self.applyIndicatorCorner()
        }
        
        if animated == true {
            UIView.animate(withDuration: 0.2) { applyFrame() }
        }else {
            applyFrame()
        }
    }
    
    
    /// 设置 指示器圆角
    private func applyIndicatorCorner() {
        switch style.indicatorCorner {
        case .none:
            indicator.layer.cornerRadius = 0
        case .semicircle:
            indicator.layer.cornerRadius = indicator.bounds.height / 2
        case .corner(let value):
            indicator.layer.cornerRadius = value
        }
    }
    
    /// 设置选中
    fileprivate func applySelected(index: Int, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            let currentLabel = self.titleLabels[index]
            let offSetX = min(max(0, currentLabel.center.x - self.bounds.width / 2),
                              max(0, self.scrollView.contentSize.width - self.bounds.width))
            self.scrollView.setContentOffset(CGPoint(x:offSetX, y: 0), animated: true)
            
            self.applyIndicatorFrame(at: index, animated: animated)
            
            self.selectIndex = index
            self.valueChange?(index)
            self.sendActions(for: UIControl.Event.valueChanged)
        }
    }
}


public extension YYPageMenu {
    /// 设置 选中下标
    ///
    /// - Parameters:
    ///   - index: 下标
    ///   - animated: 是否动画
    func setSelectIndex(index: Int, animated: Bool = true) {
        
        guard   index != selectIndex,
            index >= 0 ,
            index < titleLabels.count
            else    { return }
        
        applySelected(index: index, animated: animated)
    }
    
    
    
    
    
}

fileprivate extension YYPageMenu {
    func textSizeWithLabel(_ label: UILabel) -> CGSize {
        return label.text?.size(with: label.font) ?? .zero
    }
}

extension YYPageMenu {
    
    public var titleFont: UIFont {
        get {
            return style.titleFont
        }
        set {
            style.titleFont = newValue
        }
    }
    
    @IBInspectable public var indicatorColor: UIColor {
        get {
            return style.indicatorColor
        }
        set {
            style.indicatorColor = newValue
        }
    }
    
    @IBInspectable public var titlePendingHorizontal: CGFloat {
        get {
            return style.titlePendingHorizontal
        }
        set {
            style.titlePendingHorizontal = newValue
        }
    }
    
    @IBInspectable public var titlePendingVertical: CGFloat  {
        get {
            return style.titlePendingVertical
        }
        set {
            style.titlePendingVertical = newValue
        }
    }
    
    @IBInspectable public var indicatorPendingHorizontal: CGFloat {
        get {
            return style.indicatorPendingHorizontal
        }
        set {
            style.indicatorPendingHorizontal = newValue
        }
    }
    
    @IBInspectable public var indicatorPendingVertical: CGFloat {
        get {
            return style.indicatorPendingVertical
        }
        set {
            style.indicatorPendingVertical = newValue
        }
    }
    
    
    @IBInspectable public var normalTitleColor: UIColor {
        get {
            return style.normalTitleColor
        }
        set {
            style.normalTitleColor = newValue
        }
    }
    
    @IBInspectable public var selectedTitleColor: UIColor {
        get {
            return style.selectedTitleColor
        }
        set {
            style.selectedTitleColor = newValue
        }
    }
}

fileprivate extension String {
    func size(with font: UIFont) -> CGSize {
        let aSize = CGSize(width: CGFloat(MAXFLOAT), height: 0.0)
        let rect = (self as NSString).boundingRect(with: aSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size
    }
}

fileprivate extension CGRect {
    init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width/2,
                  y: center.y - size.height/2,
                  width: size.width,
                  height: size.height)
    }
}
