//
//  YYAutoLayout.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/18.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

extension UIView {
    //结束语句
    open func build() {}
    //约束点属性
    //MARK: **********************************************************************************************
    open var yy_width: NSLayoutDimension  { get {return widthAnchor} }
    
    open var yy_height: NSLayoutDimension  { get {return heightAnchor} }
    
    open var yy_top: NSLayoutYAxisAnchor { get {return topAnchor} }
    
    open var yy_bottom: NSLayoutYAxisAnchor { get {return bottomAnchor} }
    
    open var yy_right: NSLayoutXAxisAnchor { get {return rightAnchor} }
    
    open var yy_left: NSLayoutXAxisAnchor { get {return leftAnchor} }
    
    open var yy_centerX: NSLayoutXAxisAnchor { get {return centerXAnchor} }
    
    open var yy_centerY: NSLayoutYAxisAnchor { get {return centerYAnchor} }
    
    open var yy_leading: NSLayoutXAxisAnchor { get {return leadingAnchor} }
    
    open var yy_trailing: NSLayoutXAxisAnchor { get {return trailingAnchor} }
    
    open var yy_firstBaseline: NSLayoutYAxisAnchor { get {return firstBaselineAnchor} }
    
    open var yy_lastBaseline: NSLayoutYAxisAnchor { get {return lastBaselineAnchor} }
    
    //MARK: **********************************************************************************************
    //与一个视图上下左右重叠
    open func edges(with aView: UIView) -> UIView {
        top(equalTo: aView.yy_top).left(equalTo: aView.yy_leading).right(equalTo: aView.yy_trailing).bottom(equalTo: aView.yy_bottom).build()
        return self
    }
    //与一个视图约束并带insets
    open func edges(with aView: UIView, and insets: UIEdgeInsets) -> UIView {
        top(equalTo: aView.yy_top, constant: insets.top).trailing(equalTo: aView.yy_trailing, constant: -insets.right).leading(equalTo: aView.yy_leading, constant: insets.left).bottom(equalTo: aView.yy_bottom, constant: -insets.bottom).build()
        return self
    }
    //MARK: ****************************************UIView************************************************
    //MARK: 赋值宽高一个固定数值
    open func width(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).active()
        return self
    }
    open func height(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).active()
        return self
    }
    //MARK: 约束一个Anchor
    open func width(equalTo aAnchor: NSLayoutDimension) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func height(equalTo aAnchor: NSLayoutDimension) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func top(equalTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func bottom(equalTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func left(equalTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func right(equalTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func leading(equalTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func trailing(equalTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func centerX(equalTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func centerY(equalTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func firstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        firstBaselineAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    open func lastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        lastBaselineAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    //MARK: 约束一个Anchor和constant
    open func width(equalTo aAnchor: NSLayoutDimension, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    open func height(equalTo aAnchor: NSLayoutDimension, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    open func top(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    
    open func bottom(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: aAnchor, constant: -constant).active()
        return self
    }
    open func left(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    open func right(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(equalTo: aAnchor, constant: -constant).active()
        return self
    }
    open func leading(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    open func trailing(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: aAnchor, constant: -constant).active()
        return self
    }
    open func centerX(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    open func centerY(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    open func firstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        firstBaselineAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    open func lastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        lastBaselineAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    //MARK: lessThanOrEqualTo
    open func width(lessThanOrEqualTo aAnchor: NSLayoutDimension) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func height(lessThanOrEqualTo aAnchor: NSLayoutDimension) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func top(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func bottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func left(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func right(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func leading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func trailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func centerX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func centerY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func firstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    open func lastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    //MARK: lessThanOrEqualTo 和 constant
    open func width(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func height(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func top(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func bottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: -constant).active()
        return self
    }
    open func left(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func right(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: -constant).active()
        return self
    }
    open func leading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func trailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: -constant).active()
        return self
    }
    open func centerX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func centerY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func firstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func lastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    
    
    
    //MARK: greaterThanOrEqualTo
    open func width(greaterThanOrEqualTo aAnchor: NSLayoutDimension) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func height(greaterThanOrEqualTo aAnchor: NSLayoutDimension) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func top(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func bottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func left(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func right(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func leading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func trailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func centerX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func centerY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func firstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    open func lastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    //MARK: lessThanOrEqualTo 和 constant
    open func width(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func height(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func top(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func bottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: -constant).active()
        return self
    }
    open func left(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func right(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: -constant).active()
        return self
    }
    open func leading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func trailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: -constant).active()
        return self
    }
    open func centerX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func centerY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func firstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    open func lastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    //MARK: width 和 height 约束的倍数
    open func width(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier).active()
        return self
    }
    open func height(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier).active()
        return self
    }
    //MARK: width 和 height 约束的倍数 以及常量
    open func width(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant).active()
        return self
    }
    open func height(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant).active()
        return self
    }
    //MARK: **********************************************************************************************
    //MARK: ****************************************NSLayoutConstraint************************************
    private func setLayout(constraint: NSLayoutConstraint, with priority: UILayoutPriority) {
        constraint.priority = priority
        constraint.active()
    }
    //MARK:NSLayoutConstraint赋值一个固定数值
    open func setWidth(_ width: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(equalToConstant: width), with: priority)
        return self
    }
    open func setHeight(_ height: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(equalToConstant: height), with: priority)
        return self
    }
    //MARK:NSLayoutConstraint约束一个Anchor
    open func setWidth(equalTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setHeight(equalTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setTop(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: topAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setBottom(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: bottomAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setLeft(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leftAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setRight(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: rightAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setLeading(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leadingAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setTrailing(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: trailingAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setCenterX(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerXAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setCenterY(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerYAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setFirstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: firstBaselineAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    open func setLastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: lastBaselineAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint约束一个Anchor和constant
    open func setWidth(equalTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setHeight(equalTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setTop(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: topAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setBottom(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: bottomAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLeft(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leftAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setRight(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: rightAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLeading(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leadingAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setTrailing(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: trailingAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setCenterX(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerXAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setCenterY(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerYAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setFirstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: firstBaselineAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: lastBaselineAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint lessThanOrEqualTo
    open func setWidth(lessThanOrEqualTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setHeight(lessThanOrEqualTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setTop(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: topAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setBottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: bottomAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setLeft(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leftAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setRight(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: rightAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setLeading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leadingAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setTrailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: trailingAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setCenterX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerXAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setCenterY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerYAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setFirstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setLastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint lessThanOrEqualTo 和 constant
    open func setWidth(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setHeight(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setTop(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: topAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setBottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: bottomAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLeft(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leftAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setRight(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: rightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLeading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leadingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setTrailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: trailingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setCenterX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerXAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setCenterY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerYAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setFirstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    
    //MARK: NSLayoutConstraint greaterThanOrEqualTo
    open func setWidth(greaterThanOrEqualTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setHeight(greaterThanOrEqualTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setTop(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: topAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setBottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setLeft(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leftAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setRight(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: rightAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setLeading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setTrailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setCenterX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setCenterY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setFirstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    open func setLastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint lessThanOrEqualTo 和 constant
    open func setWidth(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setHeight(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setTop(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: topAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setBottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLeft(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leftAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setRight(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: rightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLeading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setTrailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setCenterX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setCenterY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setFirstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    open func setLastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint width 和 height 约束的倍数
    open func setWidth(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier), with: priority)
        return self
    }
    open func setHeight(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint width 和 height 约束的倍数 以及常量
    open func setWidth(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant), with: priority)
        return self
    }
    open func setHeight(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> UIView {
        setLayout(constraint: heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant), with: priority)
        return self
    }

}
extension NSLayoutConstraint {
    func active() {
        isActive = true
    }
}

