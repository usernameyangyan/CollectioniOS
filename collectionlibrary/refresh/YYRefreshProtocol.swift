//
//  YYRefreshProtocol.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/5.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import UIKit

public enum YYRefreshViewState {
    case pullToRefresh
    case releaseToRefresh
    case refreshing
    case autoRefreshing
    case noMoreData
}



public protocol YYRefreshProtocol {
    
    /**
     Refresh operation begins execution method
     You can refresh your animation logic here, it will need to start the animation each time a refresh
    */
    mutating func refreshAnimationBegin(view: YYRefreshComponent)
    
    /**
     Refresh operation stop execution method
     Here you can reset your refresh control UI, such as a Stop UIImageView animations or some opened Timer refresh, etc., it will be executed once each time the need to end the animation
     */
    mutating func refreshAnimationEnd(view: YYRefreshComponent)
    
    /**
     Pulling status callback , progress is the percentage of the current offset with trigger, and avoid doing too many tasks in this process so as not to affect the fluency.
     */
    mutating func refresh(view: YYRefreshComponent, progressDidChange progress: CGFloat)
    
    mutating func refresh(view: YYRefreshComponent, stateDidChange state: YYRefreshViewState)
}


public protocol YYRefreshAnimatorProtocol {
    
    // The view that called when component refresh, returns a custom view or self if 'self' is the customized views.
    var view: UIView {get}
    
    // Customized inset.
    var insets: UIEdgeInsets {set get}
    
    // Refresh event is executed threshold required y offset, set a value greater than 0.0, the default is 60.0
    var trigger: CGFloat {set get}
    
    // Offset y refresh event executed by this parameter you can customize the animation to perform when you refresh the view of reservations height
    var executeIncremental: CGFloat {set get}
    
    // Current refresh state, default is .pullToRefresh
    var state: YYRefreshViewState {set get}
    
}

/**
 *  YYRefreshImpacter
 *  Support iPhone7/iPhone7 Plus or later feedback impact
 *  You can confirm the YYRefreshImpactProtocol
 */
fileprivate class YYRefreshImpacter {
    static private var impacter: AnyObject? = {
        if #available(iOS 10.0, *) {
            if NSClassFromString("UIFeedbackGenerator") != nil {
                let generator = UIImpactFeedbackGenerator.init(style: .light)
                generator.prepare()
                return generator
            }
        }
        return nil
    }()
    
    static public func impact() -> Void {
        if #available(iOS 10.0, *) {
            if let impacter = impacter as? UIImpactFeedbackGenerator {
                impacter.impactOccurred()
            }
        }
    }
}
