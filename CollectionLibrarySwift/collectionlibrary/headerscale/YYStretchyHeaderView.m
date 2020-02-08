//
//  YYStretchyHeaderView.m
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/7.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

#import "YYStretchyHeaderView.h"
#import "YYStretchyHeaderView+Protected.h"
#import "UIScrollView+YYStretchyHeaderView.h"


NS_ASSUME_NONNULL_BEGIN

static const CGFloat kNibDefaultMaximumContentHeight = 240;

@interface YYStretchyHeaderView ()

@property (nonatomic) BOOL needsLayoutContentView;
@property (nonatomic) BOOL arrangingSelfInScrollView;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic) BOOL observingScrollView;
@property (nonatomic, weak) id<YYStretchyHeaderViewStretchDelegate> stretchDelegate;
@property (nonatomic) CGFloat stretchFactor;

@end

@interface YYStretchyHeaderContentView : UIView
@end

@implementation YYStretchyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(frame.size.height > 0, @"Initial height MUST be greater than 0");
    self = [super initWithFrame:frame];
    if (self) {
        self.maximumContentHeight = self.frame.size.height;
        [self setupView];
        [self setupContentView];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
        [self setupContentView];
    }
    return self;
}

- (void)setupView {
    self.clipsToBounds = YES;
    self.minimumContentHeight = 0;
    self.contentAnchor = YYStretchyHeaderViewContentAnchorTop;
    self.contentExpands = YES;
    self.contentShrinks = YES;
    self.manageScrollViewInsets = YES;
    self.manageScrollViewSubviewHierarchy = YES;
}

- (void)setupContentView {
    _contentView = [[YYStretchyHeaderContentView alloc] initWithFrame:self.bounds];
    [self yy_transplantSubviewsToView:_contentView];
    [self addSubview:_contentView];
    [self setNeedsLayoutContentView];
}

#pragma mark - Public properties

- (void)setExpansionMode:(YYStretchyHeaderViewExpansionMode)expansionMode {
    _expansionMode = expansionMode;
    [self.scrollView yy_layoutStretchyHeaderView:self
                                    contentOffset:self.scrollView.contentOffset
                            previousContentOffset:self.scrollView.contentOffset];
}

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight {
    if (maximumContentHeight == _maximumContentHeight) {
        return;
    }

    _maximumContentHeight = maximumContentHeight;
    [self setupScrollViewInsetsIfNeeded];
    [self.scrollView yy_layoutStretchyHeaderView:self
                                    contentOffset:self.scrollView.contentOffset
                            previousContentOffset:self.scrollView.contentOffset];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self setupScrollViewInsetsIfNeeded];
}

#pragma mark - Public methods

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight
                  resetAnimated:(BOOL)animated {
    self.maximumContentHeight = maximumContentHeight;
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, -(self.maximumContentHeight + self.contentInset.top));
    }];
}

#pragma mark - Overriden methods

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.maximumContentHeight == 0) {
        NSLog(@"'maximumContentHeight' not defined for %@, setting default (%@)",
              NSStringFromClass(self.class),
              @(kNibDefaultMaximumContentHeight));
        self.maximumContentHeight = kNibDefaultMaximumContentHeight;
    }
}

// we have to stop observing the scroll view before it gets deallocated
// willMoveToSuperview: happens too late
- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        [self observeScrollViewIfPossible];
    } else {
        [self stopObservingScrollView];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (!self.manageScrollViewSubviewHierarchy) {
        return;
    }
    
    if (@available(iOS 11.0, *)) { // it has to be used like this :/
        [self.scrollView yy_fixZPositionsForStretchyHeaderView:self];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (self.superview != self.scrollView) {
        [self stopObservingScrollView];
        self.scrollView = nil;
    }
    
    if (![self.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    self.scrollView = (UIScrollView *)self.superview;
    [self observeScrollViewIfPossible];
    
    [self setupScrollViewInsetsIfNeeded];
}

- (void)observeScrollViewIfPossible {
    if (self.scrollView == nil || self.observingScrollView) {
        return;
    }
    
    [self.scrollView addObserver:self
                      forKeyPath:NSStringFromSelector(@selector(contentOffset))
                         options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.scrollView.layer addObserver:self
                            forKeyPath:NSStringFromSelector(@selector(sublayers))
                               options:NSKeyValueObservingOptionNew
                               context:nil];
    self.observingScrollView = YES;
}

- (void)removeFromSuperview {
    [self stopObservingScrollView];

    [super removeFromSuperview];
}

- (void)stopObservingScrollView {
    if (!self.observingScrollView) {
        return;
    }
    
    [self.scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
    [self.scrollView.layer removeObserver:self forKeyPath:NSStringFromSelector(@selector(sublayers))];
    
    self.observingScrollView = NO;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSString *, NSValue *> *)change
                       context:(nullable void *)context {
    if (object == self.scrollView) {
        if (![keyPath isEqualToString:@"contentOffset"]) {
            NSAssert(NO, @"keyPath '%@' is not being observed", keyPath);
        }

        CGPoint contentOffset = change[NSKeyValueChangeNewKey].CGPointValue;
        CGPoint previousContentOffset = change[NSKeyValueChangeOldKey].CGPointValue;
        [self.scrollView yy_layoutStretchyHeaderView:self
                                        contentOffset:contentOffset
                                previousContentOffset:previousContentOffset];
    } else if (object == self.scrollView.layer) {
        if (![keyPath isEqualToString:@"sublayers"]) {
            NSAssert(NO, @"keyPath '%@' is not being observed", keyPath);
        }
        
        if (!self.arrangingSelfInScrollView && self.manageScrollViewSubviewHierarchy) {
            self.arrangingSelfInScrollView = YES;
            [self.scrollView yy_arrangeStretchyHeaderView:self];
            self.arrangingSelfInScrollView = NO;
        }
    }
}

#pragma mark - Private properties and methods

- (CGFloat)verticalInset {
    return self.contentInset.top + self.contentInset.bottom;
}

- (CGFloat)horizontalInset {
    return self.contentInset.left + self.contentInset.right;
}

- (CGFloat)maximumHeight {
    return self.maximumContentHeight + self.verticalInset;
}

- (CGFloat)minimumHeight {
    return self.minimumContentHeight + self.verticalInset;
}

- (void)setupScrollViewInsetsIfNeeded {
    if (self.scrollView && self.manageScrollViewInsets) {
        UIEdgeInsets scrollViewContentInset = self.scrollView.contentInset;
        scrollViewContentInset.top = self.maximumContentHeight + self.contentInset.top + self.contentInset.bottom;
        self.scrollView.contentInset = scrollViewContentInset;
    }
}

- (void)setNeedsLayoutContentView {
    self.needsLayoutContentView = YES;
}

- (void)layoutContentViewIfNeeded {
    if (!self.needsLayoutContentView) {
        return;
    }
    
    const CGFloat ownHeight = CGRectGetHeight(self.bounds);
    const CGFloat ownWidth = CGRectGetWidth(self.bounds);
    const CGFloat contentHeightDif = (self.maximumContentHeight - self.minimumContentHeight);
    const CGFloat maxContentViewHeight = ownHeight - self.verticalInset;
    
    CGFloat contentViewHeight = maxContentViewHeight;
    if (!self.contentExpands) {
        contentViewHeight = MIN(contentViewHeight, self.maximumContentHeight);
    }
    if (!self.contentShrinks) {
        contentViewHeight = MAX(contentViewHeight, self.maximumContentHeight);
    }
    
    CGFloat contentViewTop;
    switch (self.contentAnchor) {
        case YYStretchyHeaderViewContentAnchorTop: {
            contentViewTop = self.contentInset.top;
            break;
        }
        case YYStretchyHeaderViewContentAnchorBottom: {
            contentViewTop = ownHeight - contentViewHeight;
            if (!self.contentExpands) {
                contentViewTop = MIN(0, contentViewTop);
            }
            break;
        }
    }
    self.contentView.frame = CGRectMake(self.contentInset.left,
                                        contentViewTop,
                                        ownWidth - self.horizontalInset,
                                        contentViewHeight);
    
    CGFloat newStretchFactor = (maxContentViewHeight - self.minimumContentHeight) / contentHeightDif;
    if (newStretchFactor != self.stretchFactor) {
        self.stretchFactor = newStretchFactor;
        [self didChangeStretchFactor:newStretchFactor];
        [self.stretchDelegate stretchyHeaderView:self didChangeStretchFactor:newStretchFactor];
    }
    
    self.needsLayoutContentView = NO;
}

#pragma mark - Stretch factor

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    // to be implemented in subclasses
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutContentViewIfNeeded];
}

- (void)contentViewDidLayoutSubviews {
    // default implementation does not do anything
}

@end

@implementation YYStretchyHeaderContentView

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self.superview isKindOfClass:[YYStretchyHeaderView class]]) {
        [(YYStretchyHeaderView *)self.superview contentViewDidLayoutSubviews];
    }
}

@end

NS_ASSUME_NONNULL_END

