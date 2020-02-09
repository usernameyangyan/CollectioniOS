//
//  YYStretchyHeaderView+Protected.h
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/7.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

@interface YYStretchyHeaderView (Protected)

@property (nonatomic, readonly) CGFloat verticalInset;
@property (nonatomic, readonly) CGFloat horizontalInset;
@property (nonatomic, readonly) CGFloat maximumHeight;
@property (nonatomic, readonly) CGFloat minimumHeight;

- (void)setNeedsLayoutContentView;
- (void)layoutContentViewIfNeeded;

@end
