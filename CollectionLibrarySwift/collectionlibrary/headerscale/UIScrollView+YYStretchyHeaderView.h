//
//  UIScrollView+YYStretchyHeaderView.h
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/7.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYStretchyHeaderView;

@interface UIScrollView (YYStretchyHeaderView)

- (void)yy_fixZPositionsForStretchyHeaderView:(YYStretchyHeaderView *)headerView;

- (void)yy_arrangeStretchyHeaderView:(YYStretchyHeaderView *)headerView;
- (void)yy_layoutStretchyHeaderView:(YYStretchyHeaderView *)headerView
                       contentOffset:(CGPoint)contentOffset
               previousContentOffset:(CGPoint)previousContentOffset;

@end

