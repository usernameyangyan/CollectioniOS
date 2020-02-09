//
//  UIScrollView+YYStretchyHeaderView.m
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/7.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

#import "UIScrollView+YYStretchyHeaderView.h"
#import "YYStretchyHeaderView.h"
#import "YYStretchyHeaderView+Protected.h"

@interface UIView (YYStretchyHeaderViewArrangement)
- (BOOL)yy_shouldBeBelowStretchyHeaderView;
@end

@implementation UIScrollView (YYStretchyHeaderView)

- (void)yy_fixZPositionsForStretchyHeaderView:(YYStretchyHeaderView *)headerView {
    headerView.layer.zPosition = 1;
    for (UIView *subview in self.subviews) {
        if (![subview yy_shouldBeBelowStretchyHeaderView] && (subview.layer.zPosition == 0 || subview.layer.zPosition == 1)) {
            subview.layer.zPosition = 2;
        }
    }
}

- (void)yy_arrangeStretchyHeaderView:(YYStretchyHeaderView *)headerView {
    NSAssert(headerView.superview == self, @"The provided header view must be a subview of %@", self);
    NSUInteger stretchyHeaderViewIndex = [self.subviews indexOfObjectIdenticalTo:headerView];
    NSUInteger stretchyHeaderViewNewIndex = stretchyHeaderViewIndex;
    for (NSUInteger i = stretchyHeaderViewIndex + 1; i < self.subviews.count; ++i) {
        UIView *subview = self.subviews[i];
        if ([subview yy_shouldBeBelowStretchyHeaderView]) {
            stretchyHeaderViewNewIndex = i;
        }
    }
    
    
    if (stretchyHeaderViewIndex != stretchyHeaderViewNewIndex) {
        [self exchangeSubviewAtIndex:stretchyHeaderViewIndex
                  withSubviewAtIndex:stretchyHeaderViewNewIndex];
    }
}

- (void)yy_layoutStretchyHeaderView:(YYStretchyHeaderView *)headerView
                       contentOffset:(CGPoint)contentOffset
               previousContentOffset:(CGPoint)previousContentOffset {
    // First of all, move the header view to the top of the visible part of the scroll view,
    // update its width if needed
    CGRect headerFrame = headerView.frame;
    headerFrame.origin.y = contentOffset.y;
    if (CGRectGetWidth(headerFrame) != CGRectGetWidth(self.bounds)) {
        headerFrame.size.width = CGRectGetWidth(self.bounds);
    }
    
    if (!headerView.manageScrollViewInsets) {
        CGFloat offsetAdjustment = headerView.maximumHeight - headerView.minimumHeight;
        contentOffset.y -= offsetAdjustment;
        previousContentOffset.y -= offsetAdjustment;
    }
    
    CGFloat headerViewHeight = CGRectGetHeight(headerView.bounds);
    switch (headerView.expansionMode) {
        case YYStretchyHeaderViewExpansionModeTopOnly: {
            if (contentOffset.y + headerView.maximumHeight <= 0) { // bigger than default
                headerViewHeight = -contentOffset.y;
            } else {
                headerViewHeight = MIN(headerView.maximumHeight, MAX(-contentOffset.y, headerView.minimumHeight));
            }
            break;
        }
        case YYStretchyHeaderViewExpansionModeImmediate: {
            CGFloat scrollDelta = contentOffset.y - previousContentOffset.y;
            if (contentOffset.y + headerView.maximumHeight <= 0) { // bigger than default
                headerViewHeight = -contentOffset.y;
            } else {
                headerViewHeight -= scrollDelta;
                headerViewHeight = MIN(headerView.maximumHeight, MAX(headerViewHeight, headerView.minimumHeight));
            }
            break;
        }
    }
    headerFrame.size.height = headerViewHeight;
    
    // Adjust the height of the header view depending on the content offset
    
    // If the size of the header view changes, we will need to adjust its content view
    if (!CGSizeEqualToSize(headerView.frame.size, headerFrame.size)) {
        [headerView setNeedsLayoutContentView];
    }
    headerView.frame = headerFrame;
    
    [headerView layoutContentViewIfNeeded];
}

@end

@implementation UIView (YYStretchyHeaderViewArrangement)

- (BOOL)yy_shouldBeBelowStretchyHeaderView {
    return [self isKindOfClass:[UITableViewCell class]] ||
           [self isKindOfClass:[UITableViewHeaderFooterView class]] ||
           [self isKindOfClass:[UICollectionReusableView class]];
}

@end

