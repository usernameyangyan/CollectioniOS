//
//  File.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/7.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

@objc protocol CommonCollectionViewLayoutDelegate {
    //waterFall的列数
    func columnOfLayout(_ collectionView: UICollectionView) -> Int
    //每个item的高度
    func itemHeight(_ collectionView: UICollectionView, layout CommonCollectionViewLayout: CommonCollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat
}


class CommonCollectionViewLayout: UICollectionViewFlowLayout {

    
    //代理
    weak var delegate: CommonCollectionViewLayoutDelegate?
    //行间距
    @IBInspectable var lineSpacing: CGFloat   = 0
    //列间距
    @IBInspectable var columnSpacing: CGFloat = 0
    //section的top
    @IBInspectable var sectionTop: CGFloat    = 0 {
        willSet {
            sectionInsets.top = newValue
        }
    }
    //section的Bottom
    @IBInspectable var sectionBottom: CGFloat  = 0 {
        willSet {
            sectionInsets.bottom = newValue
        }
    }
    //section的left
    @IBInspectable var sectionLeft: CGFloat   = 0 {
        willSet {
            sectionInsets.left = newValue
        }
    }
    //section的right
    @IBInspectable var sectionRight: CGFloat  = 0 {
        willSet {
            sectionInsets.right = newValue
        }
    }
    //section的Insets
    @IBInspectable var sectionInsets: UIEdgeInsets      = UIEdgeInsets.zero
    //每行对应的高度
    private var columnHeights: [Int: CGFloat]                  = [Int: CGFloat]()
    private var attributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    //MARK: Initial Methods
    init(lineSpacing: CGFloat, columnSpacing: CGFloat, sectionInsets: UIEdgeInsets) {
        super.init()
        self.lineSpacing      = lineSpacing
        self.columnSpacing    = columnSpacing
        self.sectionInsets    = sectionInsets
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Public Methods
    
    
    //MARK: Override
    override var collectionViewContentSize: CGSize {
        var maxHeight: CGFloat = 0
        for height in columnHeights.values {
            if height > maxHeight {
                maxHeight = height
            }
        }
        return CGSize.init(width: collectionView?.frame.width ?? 0, height: maxHeight + sectionInsets.bottom)
    }
    
    override func prepare() {
        super.prepare()
        guard collectionView != nil else {
            return
        }
        if let columnCount = delegate?.columnOfLayout(collectionView!) {
            for i in 0..<columnCount {
                columnHeights[i] = sectionInsets.top
            }
        }
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        attributes.removeAll()
        for i in 0..<itemCount {
            if let att = layoutAttributesForItem(at: IndexPath.init(row: i, section: 0)) {
                attributes.append(att)
            }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let collectionView = collectionView {
            //根据indexPath获取item的attributes
            let att = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            //获取collectionView的宽度
            let width = collectionView.frame.width
            if let columnCount = delegate?.columnOfLayout(collectionView) {
                guard columnCount > 0 else {
                    return nil
                }
                //item的宽度 = (collectionView的宽度 - 内边距与列间距) / 列数
                let totalWidth  = (width - sectionInsets.left - sectionInsets.right - (CGFloat(columnCount) - 1) * columnSpacing)
                let itemWidth   = totalWidth / CGFloat(columnCount)
                //获取item的高度，由外界计算得到
                let itemHeight  = delegate?.itemHeight(collectionView, layout: self, heightForItemAt: indexPath) ?? 0
                //找出最短的那一列
                var minIndex = 0
                for column in columnHeights {
                    if column.value < columnHeights[minIndex] ?? 0 {
                        minIndex = column.key
                    }
                }
                //根据最短列的列数计算item的x值
                let itemX  = sectionInsets.left + (columnSpacing + itemWidth) * CGFloat(minIndex)
                //item的y值 = 最短列的最大y值 + 行间距
                
                let itemY = indexPath.row > (columnCount-1) ? (columnHeights[minIndex] ?? 0) + lineSpacing:(columnHeights[minIndex] ?? 0)
              
              
                //设置attributes的frame
                att.frame  = CGRect.init(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
                //更新字典中的最大y值
                columnHeights[minIndex] = att.frame.maxY
            }
            return att
        }
        return nil
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
}

