//
//  YYPageMeunEnum.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/2.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit
/// 宽度类型
///
/// - fixed: 固定宽度
/// - sizeToFit: 自适应宽度
public enum YYPageMenuItemWidthType {
    case fixed(width: CGFloat)
    case sizeToFit(minWidth: CGFloat)
    
    public var width: CGFloat {
        switch self {
        case let .fixed(width): return width
        case let .sizeToFit(minWidth): return minWidth
        }
    }
    
    /// 是否固定宽度
    public var isFixed: Bool {
        switch self {
        case .fixed:
            return true
        default:
            return false
        }
    }
}


/// 指示器圆角类型
///
/// - none: 无
/// - semicircle: 半圆
/// - corner: 具体数值
public enum YYPageMenuIndicatorCornerStyle {
    case none
    case semicircle
    case corner(value: CGFloat)
    
    public var corner: CGFloat {
        switch self {
        case .none, .semicircle:
            return 0
        case let .corner(value):
            return value
        }
    }
}

/// 指示器类型
///
/// - line: 横线
/// - cover: 遮罩
public enum YYPageMenuIndicatorStyle {
    case line(widthType: YYPageMenuItemWidthType, position: YYPageMenulinePosition)
    case cover(widthType: YYPageMenuItemWidthType)
    
    public var widthType: YYPageMenuItemWidthType {
        get {
            switch self {
            case let .cover(width):
                return width
            case let .line(width, _):
                return width
            }
        }
    }
}


/// 横线位置类型
public enum YYPageMenulinePosition {
    public typealias linePosition = (margin: CGFloat, height: CGFloat)
    case top(linePosition)
    case bottom(linePosition)
    
    public var margin: CGFloat {
        get {
            switch self {
            case let .top(m, _):
                return m
            case let .bottom(m, _):
                return m
            }
        }
    }
    public var height: CGFloat {
        get {
            switch self {
            case let .top(_, h):
                return h
            case let .bottom(_, h):
                return h
            }
        }
    }
}

