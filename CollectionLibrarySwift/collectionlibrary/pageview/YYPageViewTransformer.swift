//
//  YYPageViewTransformer.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

@objc
public enum YYPageViewTransformerType: Int {
    case crossFading
    case zoomOut
    case depth
    case overlap
    case linear
    case none
    case cubic
}

open class YYPageViewTransformer: NSObject {
    
    open internal(set) weak var pagerView: YYPageView?
    open internal(set) var type: YYPageViewTransformerType
    
    open var minimumScale: CGFloat = 0.65
    open var minimumAlpha: CGFloat = 0.6
    
    @objc
    public init(type: YYPageViewTransformerType) {
        self.type = type
        switch type {
        case .zoomOut:
            self.minimumScale = 0.85
        case .depth:
            self.minimumScale = 0.5
        default:
            break
        }
    }
    
    // Apply transform to attributes - zIndex: Int, frame: CGRect, alpha: CGFloat, transform: CGAffineTransform or transform3D: CATransform3D.
    open func applyTransform(to attributes: YYPageViewLayoutAttributes) {
        guard let pagerView = self.pagerView else {
            return
        }
        let position = attributes.position
        let scrollDirection = pagerView.scrollDirection
        let itemSpacing = (scrollDirection == .horizontal ? attributes.bounds.width : attributes.bounds.height) + self.proposedInteritemSpacing()
        switch self.type {
        case .crossFading:
            var zIndex = 0
            var alpha: CGFloat = 0
            var transform = CGAffineTransform.identity
            switch scrollDirection {
            case .horizontal:
                transform.tx = -itemSpacing * position
            case .vertical:
                transform.ty = -itemSpacing * position
            }
            if (abs(position) < 1) { // [-1,1]
                // Use the default slide transition when moving to the left page
                alpha = 1 - abs(position)
                zIndex = 1
            } else { // (1,+Infinity]
                // This page is way off-screen to the right.
                alpha = 0
                zIndex = Int.min
            }
            attributes.alpha = alpha
            attributes.transform = transform
            attributes.zIndex = zIndex
        case .zoomOut:
            var alpha: CGFloat = 0
            var transform = CGAffineTransform.identity
            switch position {
            case -CGFloat.greatestFiniteMagnitude ..< -1 : // [-Infinity,-1)
                // This page is way off-screen to the left.
                alpha = 0
            case -1 ... 1 :  // [-1,1]
                // Modify the default slide transition to shrink the page as well
                let scaleFactor = max(self.minimumScale, 1 - abs(position))
                transform.a = scaleFactor
                transform.d = scaleFactor
                switch scrollDirection {
                case .horizontal:
                    let vertMargin = attributes.bounds.height * (1 - scaleFactor) / 2;
                    let horzMargin = itemSpacing * (1 - scaleFactor) / 2;
                    transform.tx = position < 0 ? (horzMargin - vertMargin*2) : (-horzMargin + vertMargin*2)
                case .vertical:
                    let horzMargin = attributes.bounds.width * (1 - scaleFactor) / 2;
                    let vertMargin = itemSpacing * (1 - scaleFactor) / 2;
                    transform.ty = position < 0 ? (vertMargin - horzMargin*2) : (-vertMargin + horzMargin*2)
                }
                // Fade the page relative to its size.
                alpha = self.minimumAlpha + (scaleFactor-self.minimumScale)/(1-self.minimumScale)*(1-self.minimumAlpha)
            case 1 ... CGFloat.greatestFiniteMagnitude :  // (1,+Infinity]
                // This page is way off-screen to the right.
                alpha = 0
            default:
                break
            }
            attributes.alpha = alpha
            attributes.transform = transform
        case .depth:
            var transform = CGAffineTransform.identity
            var zIndex = 0
            var alpha: CGFloat = 0.0
            switch position {
            case -CGFloat.greatestFiniteMagnitude ..< -1: // [-Infinity,-1)
                // This page is way off-screen to the left.
                alpha = 0
                zIndex = 0
            case -1 ... 0:  // [-1,0]
                // Use the default slide transition when moving to the left page
                alpha = 1
                transform.tx = 0
                transform.a = 1
                transform.d = 1
                zIndex = 1
            case 0 ..< 1: // (0,1)
                // Fade the page out.
                alpha = CGFloat(1.0) - position
                // Counteract the default slide transition
                switch scrollDirection {
                case .horizontal:
                    transform.tx = itemSpacing * -position
                case .vertical:
                    transform.ty = itemSpacing * -position
                }
                // Scale the page down (between minimumScale and 1)
                let scaleFactor = self.minimumScale
                    + (1.0 - self.minimumScale) * (1.0 - abs(position));
                transform.a = scaleFactor
                transform.d = scaleFactor
                zIndex = 0
            case 1 ... CGFloat.greatestFiniteMagnitude: // [1,+Infinity)
                // This page is way off-screen to the right.
                alpha = 0
                zIndex = 0
            default:
                break
            }
            attributes.alpha = alpha
            attributes.transform = transform
            attributes.zIndex = zIndex
        case .overlap,.linear:
            guard scrollDirection == .horizontal else {
                // This type doesn't support vertical mode
                return
            }
            let scale = max(1 - (1-self.minimumScale) * abs(position), self.minimumScale)
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            attributes.transform = transform
            let alpha = (self.minimumAlpha + (1-abs(position))*(1-self.minimumAlpha))
            attributes.alpha = alpha
            let zIndex = (1-abs(position)) * 10
            attributes.zIndex = Int(zIndex)
        case .none:
            break
        case .cubic:
            switch position {
            case -CGFloat.greatestFiniteMagnitude ... -1:
                attributes.alpha = 0
            case -1 ..< 1:
                attributes.alpha = 1
                attributes.zIndex = Int((1-position) * CGFloat(10))
                let direction: CGFloat = position < 0 ? 1 : -1
                let theta = position * .pi * 0.5 * (scrollDirection == .horizontal ? 1 : -1)
                let radius = scrollDirection == .horizontal ? attributes.bounds.width : attributes.bounds.height
                var transform3D = CATransform3DIdentity
                transform3D.m34 = -0.002
                switch scrollDirection {
                case .horizontal:
                    // ForwardX -> RotateY -> BackwardX
                    attributes.center.x += direction*radius*0.5 // ForwardX
                    transform3D = CATransform3DRotate(transform3D, theta, 0, 1, 0) // RotateY
                    transform3D = CATransform3DTranslate(transform3D,-direction*radius*0.5, 0, 0) // BackwardX
                case .vertical:
                    // ForwardY -> RotateX -> BackwardY
                    attributes.center.y += direction*radius*0.5 // ForwardY
                    transform3D = CATransform3DRotate(transform3D, theta, 1, 0, 0) // RotateX
                    transform3D = CATransform3DTranslate(transform3D,0, -direction*radius*0.5, 0) // BackwardY
                }
                attributes.transform3D = transform3D
            case 1 ... CGFloat.greatestFiniteMagnitude:
                attributes.alpha = 0
            default:
                attributes.alpha = 0
                attributes.zIndex = 0
            }
        }
    }
    
    // An interitem spacing proposed by transformer class. This will override the default interitemSpacing provided by the pager view.
    open func proposedInteritemSpacing() -> CGFloat {
        guard let pagerView = self.pagerView else {
            return 0
        }
        let scrollDirection = pagerView.scrollDirection
        switch self.type {
        case .overlap:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.itemSize.width * -self.minimumScale * 0.6
        case .linear:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.itemSize.width * -self.minimumScale * 0.2
        case .cubic:
            return 0
        case .none:
            break
        default:
            break
        }
        return pagerView.interitemSpacing
    }
    
}


