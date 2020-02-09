//
//  YYPageView.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

@objc
public protocol YYPagerViewDataSource: NSObjectProtocol {
    
    /// Asks your data source object for the number of items in the pager view.
    @objc(numberOfItemsInPagerView:)
    func numberOfItems(in pagerView: YYPageView) -> Int
    
    /// Asks your data source object for the cell that corresponds to the specified item in the pager view.
    @objc(pagerView:cellForItemAtIndex:)
    func pagerView(_ pagerView: YYPageView, cellForItemAt index: Int) -> UICollectionViewCell
    
}

@objc
public protocol YYPagerViewDelegate: NSObjectProtocol {
    
    /// Asks the delegate if the item should be highlighted during tracking.
    @objc(pagerView:shouldHighlightItemAtIndex:)
    optional func pagerView(_ pagerView: YYPageView, shouldHighlightItemAt index: Int) -> Bool
    
    /// Tells the delegate that the item at the specified index was highlighted.
    @objc(pagerView:didHighlightItemAtIndex:)
    optional func pagerView(_ pagerView: YYPageView, didHighlightItemAt index: Int)
    
    /// Asks the delegate if the specified item should be selected.
    @objc(pagerView:shouldSelectItemAtIndex:)
    optional func pagerView(_ pagerView: YYPageView, shouldSelectItemAt index: Int) -> Bool
    
    /// Tells the delegate that the item at the specified index was selected.
    @objc(pagerView:didSelectItemAtIndex:)
    optional func pagerView(_ pagerView: YYPageView, didSelectItemAt index: Int)
    
    /// Tells the delegate that the specified cell is about to be displayed in the pager view.
    @objc(pagerView:willDisplayCell:forItemAtIndex:)
    optional func pagerView(_ pagerView: YYPageView, willDisplay cell: UICollectionViewCell, forItemAt index: Int)
    
    /// Tells the delegate that the specified cell was removed from the pager view.
    @objc(pagerView:didEndDisplayingCell:forItemAtIndex:)
    optional func pagerView(_ pagerView: YYPageView, didEndDisplaying cell: UICollectionViewCell, forItemAt index: Int)
    
    /// Tells the delegate when the pager view is about to start scrolling the content.
    @objc(pagerViewWillBeginDragging:)
    optional func pagerViewWillBeginDragging(_ pagerView: YYPageView)
    
    /// Tells the delegate when the user finishes scrolling the content.
    @objc(pagerViewWillEndDragging:targetIndex:)
    optional func pagerViewWillEndDragging(_ pagerView: YYPageView, targetIndex: Int)
    
    /// Tells the delegate when the user scrolls the content view within the receiver.
    @objc(pagerViewDidScroll:)
    optional func pagerViewDidScroll(_ pagerView: YYPageView)
    
    /// Tells the delegate when a scrolling animation in the pager view concludes.
    @objc(pagerViewDidEndScrollAnimation:)
    optional func pagerViewDidEndScrollAnimation(_ pagerView: YYPageView)
    
    /// Tells the delegate that the pager view has ended decelerating the scrolling movement.
    @objc(pagerViewDidEndDecelerating:)
    optional func pagerViewDidEndDecelerating(_ pagerView: YYPageView)
    
}

@IBDesignable
open class YYPageView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    // MARK: - Public properties
    
    /// The object that acts as the data source of the pager view.
    @IBOutlet open weak var dataSource: YYPagerViewDataSource?
    
    /// The object that acts as the delegate of the pager view.
    @IBOutlet open weak var delegate: YYPagerViewDelegate?
    
    /// The scroll direction of the pager view. Default is horizontal.
    @objc
    open var scrollDirection: YYPageView.ScrollDirection = .horizontal {
        didSet {
            self.collectionViewLayout.forceInvalidate()
        }
    }
    
    /// The time interval of automatic sliding. 0 means disabling automatic sliding. Default is 0.
    @IBInspectable
    open var automaticSlidingInterval: CGFloat = 0.0 {
        didSet {
            self.cancelTimer()
            if self.automaticSlidingInterval > 0 {
                self.startTimer()
            }
        }
    }
    
    /// The spacing to use between items in the pager view. Default is 0.
    @IBInspectable
    open var interitemSpacing: CGFloat = 0 {
        didSet {
            self.collectionViewLayout.forceInvalidate()
        }
    }
    
    /// The item size of the pager view. When the value of this property is FSPagerView.automaticSize, the items fill the entire visible area of the pager view. Default is FSPagerView.automaticSize.
    @IBInspectable
    open var itemSize: CGSize = automaticSize {
        didSet {
            self.collectionViewLayout.forceInvalidate()
        }
    }
    
    /// A Boolean value indicates that whether the pager view has infinite items. Default is false.
    @IBInspectable
    open var isInfinite: Bool = false {
        didSet {
            self.collectionViewLayout.needsReprepare = true
            self.collectionView.reloadData()
        }
    }
    
    /// An unsigned integer value that determines the deceleration distance of the pager view, which indicates the number of passing items during the deceleration. When the value of this property is FSPagerView.automaticDistance, the actual 'distance' is automatically calculated according to the scrolling speed of the pager view. Default is 1.
    @IBInspectable
    open var decelerationDistance: UInt = 1
    
    /// A Boolean value that determines whether scrolling is enabled.
    @IBInspectable
    open var isScrollEnabled: Bool {
        set { self.collectionView.isScrollEnabled = newValue }
        get { return self.collectionView.isScrollEnabled }
    }
    
    /// A Boolean value that controls whether the pager view bounces past the edge of content and back again.
    @IBInspectable
    open var bounces: Bool {
        set { self.collectionView.bounces = newValue }
        get { return self.collectionView.bounces }
    }
    
    /// A Boolean value that determines whether bouncing always occurs when horizontal scrolling reaches the end of the content view.
    @IBInspectable
    open var alwaysBounceHorizontal: Bool {
        set { self.collectionView.alwaysBounceHorizontal = newValue }
        get { return self.collectionView.alwaysBounceHorizontal }
    }
    
    /// A Boolean value that determines whether bouncing always occurs when vertical scrolling reaches the end of the content view.
    @IBInspectable
    open var alwaysBounceVertical: Bool {
        set { self.collectionView.alwaysBounceVertical = newValue }
        get { return self.collectionView.alwaysBounceVertical }
    }
    
    /// A Boolean value that controls whether the infinite loop is removed if there is only one item. Default is false.
    @IBInspectable
    open var removesInfiniteLoopForSingleItem: Bool = false {
        didSet {
            self.reloadData()
        }
    }
    
    /// The background view of the pager view.
    @IBInspectable
    open var backgroundView: UIView? {
        didSet {
            if let backgroundView = self.backgroundView {
                if backgroundView.superview != nil {
                    backgroundView.removeFromSuperview()
                }
                self.insertSubview(backgroundView, at: 0)
                self.setNeedsLayout()
            }
        }
    }
    
    /// The transformer of the pager view.
    @objc
    open var transformer: YYPageViewTransformer? {
        didSet {
            self.transformer?.pagerView = self
            self.collectionViewLayout.forceInvalidate()
        }
    }
    
    // MARK: - Public readonly-properties
    
    /// Returns whether the user has touched the content to initiate scrolling.
    @objc
    open var isTracking: Bool {
        return self.collectionView.isTracking
    }
    
    /// The percentage of x position at which the origin of the content view is offset from the origin of the pagerView view.
    @objc
    open var scrollOffset: CGFloat {
        let contentOffset = max(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y)
        let scrollOffset = Double(contentOffset/self.collectionViewLayout.itemSpacing)
        return fmod(CGFloat(scrollOffset), CGFloat(self.numberOfItems))
    }
    
    /// The underlying gesture recognizer for pan gestures.
    @objc
    open var panGestureRecognizer: UIPanGestureRecognizer {
        return self.collectionView.panGestureRecognizer
    }
    
    @objc open fileprivate(set) dynamic var currentIndex: Int = 0
    
    // MARK: - Private properties
    
    internal weak var collectionViewLayout: YYPageViewLayout!
    internal weak var collectionView: YYPageCollectionView!
    internal weak var contentView: UIView!
    internal var timer: Timer?
    internal var numberOfItems: Int = 0
    internal var numberOfSections: Int = 0
    
    fileprivate var dequeingSection = 0
    fileprivate var centermostIndexPath: IndexPath {
        guard self.numberOfItems > 0, self.collectionView.contentSize != .zero else {
            return IndexPath(item: 0, section: 0)
        }
        let sortedIndexPaths = self.collectionView.indexPathsForVisibleItems.sorted { (l, r) -> Bool in
            let leftFrame = self.collectionViewLayout.frame(for: l)
            let rightFrame = self.collectionViewLayout.frame(for: r)
            var leftCenter: CGFloat,rightCenter: CGFloat,ruler: CGFloat
            switch self.scrollDirection {
            case .horizontal:
                leftCenter = leftFrame.midX
                rightCenter = rightFrame.midX
                ruler = self.collectionView.bounds.midX
            case .vertical:
                leftCenter = leftFrame.midY
                rightCenter = rightFrame.midY
                ruler = self.collectionView.bounds.midY
            }
            return abs(ruler-leftCenter) < abs(ruler-rightCenter)
        }
        let indexPath = sortedIndexPaths.first
        if let indexPath = indexPath {
            return indexPath
        }
        return IndexPath(item: 0, section: 0)
    }
    fileprivate var isPossiblyRotating: Bool {
        guard let animationKeys = self.contentView.layer.animationKeys() else {
            return false
        }
        let rotationAnimationKeys = ["position", "bounds.origin", "bounds.size"]
        return animationKeys.contains(where: { rotationAnimationKeys.contains($0) })
    }
    fileprivate var possibleTargetingIndexPath: IndexPath?
    
    // MARK: - Overriden functions
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundView?.frame = self.bounds
        self.contentView.frame = self.bounds
        self.collectionView.frame = self.contentView.bounds
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil {
            self.startTimer()
        } else {
            self.cancelTimer()
        }
    }
    
    #if TARGET_INTERFACE_BUILDER
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.frame = self.bounds
        let label = UILabel(frame: self.contentView.bounds)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "FSPagerView"
        self.contentView.addSubview(label)
    }
    
    #endif
    
    deinit {
        self.collectionView.dataSource = nil
        self.collectionView.delegate = nil
    }

    // MARK: - UICollectionViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let dataSource = self.dataSource else {
            return 1
        }
       
        self.numberOfItems = dataSource.numberOfItems(in: self)
        self.pageControl.numberOfPages=numberOfItems
        guard self.numberOfItems > 0 else {
            return 0;
        }
        self.numberOfSections = self.isInfinite && (self.numberOfItems > 1 || !self.removesInfiniteLoopForSingleItem) ? Int(Int16.max)/self.numberOfItems : 1
        return self.numberOfSections
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItems
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        self.dequeingSection = indexPath.section
        let cell = self.dataSource!.pagerView(self, cellForItemAt: index)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        guard let function = self.delegate?.pagerView(_:shouldHighlightItemAt:) else {
            return true
        }
        let index = indexPath.item % self.numberOfItems
        return function(self,index)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let function = self.delegate?.pagerView(_:didHighlightItemAt:) else {
            return
        }
        let index = indexPath.item % self.numberOfItems
        function(self,index)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let function = self.delegate?.pagerView(_:shouldSelectItemAt:) else {
            return true
        }
        let index = indexPath.item % self.numberOfItems
        return function(self,index)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let function = self.delegate?.pagerView(_:didSelectItemAt:) else {
            return
        }
        self.possibleTargetingIndexPath = indexPath
        defer {
            self.possibleTargetingIndexPath = nil
        }
        let index = indexPath.item % self.numberOfItems
        function(self,index)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let function = self.delegate?.pagerView(_:willDisplay:forItemAt:) else {
            return
        }
        let index = indexPath.item % self.numberOfItems
        function(self,cell,index)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let function = self.delegate?.pagerView(_:didEndDisplaying:forItemAt:) else {
            return
        }
        let index = indexPath.item % self.numberOfItems
        function(self,cell,index)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.isPossiblyRotating && self.numberOfItems > 0 {
            // In case someone is using KVO
            let currentIndex = lround(Double(self.scrollOffset)) % self.numberOfItems
            if (currentIndex != self.currentIndex) {
                self.currentIndex = currentIndex
            }
        }
        guard let function = self.delegate?.pagerViewDidScroll else {
            return
        }
        function(self)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let function = self.delegate?.pagerViewWillBeginDragging(_:) {
            function(self)
        }
        if self.automaticSlidingInterval > 0 {
            self.cancelTimer()
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        //MARK:
        let contentOffset = self.scrollDirection == .horizontal ? targetContentOffset.pointee.x : targetContentOffset.pointee.y
        let targetItem = lround(Double(contentOffset/self.collectionViewLayout.itemSpacing))
        pageControl.currentPage=targetItem % self.numberOfItems
        
    
        if let function = self.delegate?.pagerViewWillEndDragging(_:targetIndex:) {
            let contentOffset = self.scrollDirection == .horizontal ? targetContentOffset.pointee.x : targetContentOffset.pointee.y
            let targetItem = lround(Double(contentOffset/self.collectionViewLayout.itemSpacing))
        
            function(self, targetItem % self.numberOfItems)
        }
        if self.automaticSlidingInterval > 0 {
            self.startTimer()
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let function = self.delegate?.pagerViewDidEndDecelerating {
            function(self)
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl.currentPage=self.currentIndex
        if let function = self.delegate?.pagerViewDidEndScrollAnimation {
            function(self)
        }
    }
    
    
    @objc(registerClass:forCellWithReuseIdentifier:)
    open func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) {
        self.collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    @objc(registerNib:forCellWithReuseIdentifier:)
    open func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        self.collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    
    @objc(dequeueReusableCellWithReuseIdentifier:atIndex:)
    open func dequeueReusableCell(withReuseIdentifier identifier: String, at index: Int) -> UICollectionViewCell {
        let indexPath = IndexPath(item: index, section: self.dequeingSection)
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        //        guard cell.isKind(of: UICollectionViewCell.self) else {
        //            fatalError("Cell class must be subclass of YYPagerViewCell")
        //        }
        return cell
    }
    
    /// Reloads all of the data for the collection view.
    @objc(reloadData)
    open func reloadData() {
        self.collectionViewLayout.needsReprepare = true;
        self.collectionView.reloadData()
    }
    
    
    @objc(selectItemAtIndex:animated:)
    open func selectItem(at index: Int, animated: Bool) {
        let indexPath = self.nearbyIndexPath(for: index)
        let scrollPosition: UICollectionView.ScrollPosition = self.scrollDirection == .horizontal ? .centeredHorizontally : .centeredVertically
        self.collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    
    @objc(deselectItemAtIndex:animated:)
    open func deselectItem(at index: Int, animated: Bool) {
        let indexPath = self.nearbyIndexPath(for: index)
        self.collectionView.deselectItem(at: indexPath, animated: animated)
    }
    
    /// Scrolls the pager view contents until the specified item is visible.
    ///
    /// - Parameters:
    ///   - index: The index of the item to scroll into view.
    ///   - animated: Specify true to animate the scrolling behavior or false to adjust the pager view’s visible content immediately.
    @objc(scrollToItemAtIndex:animated:)
    open func scrollToItem(at index: Int, animated: Bool) {
        guard index < self.numberOfItems else {
            fatalError("index \(index) is out of range [0...\(self.numberOfItems-1)]")
        }
        let indexPath = { () -> IndexPath in
            if let indexPath = self.possibleTargetingIndexPath, indexPath.item == index {
                defer {
                    self.possibleTargetingIndexPath = nil
                }
                return indexPath
            }
            return self.numberOfSections > 1 ? self.nearbyIndexPath(for: index) : IndexPath(item: index, section: 0)
        }()
        let contentOffset = self.collectionViewLayout.contentOffset(for: indexPath)
        self.collectionView.setContentOffset(contentOffset, animated: animated)
    }
    
    
    @objc(indexForCell:)
    open func index(for cell: UICollectionViewCell) -> Int {
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return NSNotFound
        }
        return indexPath.item
    }
    
    
    @objc(cellForItemAtIndex:)
    open func cellForItem(at index: Int) -> UICollectionViewCell? {
        let indexPath = self.nearbyIndexPath(for: index)
        return self.collectionView.cellForItem(at: indexPath)
    }
    // MARK: - Private functions
    
    
    public var pageControl:YYPageViewControl={
        let pageControl:YYPageViewControl=YYPageViewControl.init()
        //        pageControl.itemSpacing=
        pageControl.contentHorizontalAlignment = .right
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 5, right: 20)
        return pageControl
    }()
    
    fileprivate func commonInit() {
        
        // Content View
        let contentView = UIView(frame:CGRect.zero)
        contentView.backgroundColor = UIColor.clear
        
        
        self.addSubview(contentView)
        self.addSubview(pageControl)
        
        contentView
            .right(equalTo: self.yy_right)
            .left(equalTo: self.yy_left)
            .top(equalTo: self.yy_top)
            .bottom(equalTo: self.yy_bottom)
            .build()
        
        pageControl
            .right(equalTo: contentView.yy_right)
            .left(equalTo: contentView.yy_left)
            .bottom(equalTo: contentView.yy_bottom, constant: 10)
            .height(.zero)
            .build()
        
        
        
        self.contentView = contentView
        
        // UICollectionView
        let collectionViewLayout = YYPageViewLayout()
        let collectionView = YYPageCollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        self.contentView.addSubview(collectionView)
        self.collectionView = collectionView
        self.collectionViewLayout = collectionViewLayout
        
    }
    
    fileprivate func startTimer() {
        guard self.automaticSlidingInterval > 0 && self.timer == nil else {
            return
        }
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.automaticSlidingInterval), target: self, selector: #selector(self.flipNext(sender:)), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: .common)
    }
    
    @objc
    fileprivate func flipNext(sender: Timer?) {
        guard let _ = self.superview, let _ = self.window, self.numberOfItems > 0, !self.isTracking else {
            return
        }
        let contentOffset: CGPoint = {
            let indexPath = self.centermostIndexPath
            let section = self.numberOfSections > 1 ? (indexPath.section+(indexPath.item+1)/self.numberOfItems) : 0
            let item = (indexPath.item+1) % self.numberOfItems
            return self.collectionViewLayout.contentOffset(for: IndexPath(item: item, section: section))
        }()
        self.collectionView.setContentOffset(contentOffset, animated: true)
    }
    
    fileprivate func cancelTimer() {
        guard self.timer != nil else {
            return
        }
        self.timer!.invalidate()
        self.timer = nil
    }
    
    fileprivate func nearbyIndexPath(for index: Int) -> IndexPath {
        // Is there a better algorithm?
        let currentIndex = self.currentIndex
        let currentSection = self.centermostIndexPath.section
        if abs(currentIndex-index) <= self.numberOfItems/2 {
            return IndexPath(item: index, section: currentSection)
        } else if (index-currentIndex >= 0) {
            return IndexPath(item: index, section: currentSection-1)
        } else {
            return IndexPath(item: index, section: currentSection+1)
        }
    }
    
}

extension YYPageView {
    
    @objc
    public enum ScrollDirection: Int {
        case horizontal
        case vertical
    }
    
    public static let automaticDistance: UInt = 0
    
    public static let automaticSize: CGSize = .zero
    
}

