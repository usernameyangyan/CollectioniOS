//
//  UIView+YYTransplantSubviews.m
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/2/7.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

#import "UIView+YYTransplantSubviews.h"

@interface NSLayoutConstraint (YYTransplantSubviews)

- (NSLayoutConstraint *)yy_copyWithFirstItem:(id)firstItem secondItem:(id)secondItem;

@end

@implementation UIView (YYTransplantSubviews)

- (BOOL)yy_isSelfOrLayoutGuide:(id)object {
    // We can't transplant constraints to layout guides like safe area insets (introduced in iOS 11)
    // So we assume the constraints will be related to the superview
    // This may become a problem if the safe area insets are not zero, but for header views it's always the case
    if (object == self) {
        return true;
    } else if (@available(iOS 9.0, *)) {
        return [object isKindOfClass:[UILayoutGuide class]];
    }
    return false;
}

- (void)yy_transplantSubviewsToView:(UIView *)newSuperview {
    NSArray<UIView *> *oldSubviews = self.subviews;
    NSArray<NSLayoutConstraint *> *oldConstraints = self.constraints;
    NSMutableArray<NSNumber *> *oldConstraintsActiveValues = [NSMutableArray array];
    
    if ([NSLayoutConstraint instancesRespondToSelector:@selector(isActive)]) {
        for (NSLayoutConstraint *constraint in oldConstraints) {
            [oldConstraintsActiveValues addObject:@(constraint.active)];
        }
    }

    for (UIView *view in oldSubviews) {
        [view removeFromSuperview];
        [newSuperview addSubview:view];
    }

    [self removeConstraints:oldConstraints];
    [oldConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *oldConstraint, NSUInteger index, BOOL *stop) {
        id firstItem = [self yy_isSelfOrLayoutGuide:oldConstraint.firstItem] ? newSuperview : oldConstraint.firstItem;
        id secondItem = [self yy_isSelfOrLayoutGuide:oldConstraint.secondItem] ? newSuperview : oldConstraint.secondItem;
        NSLayoutConstraint *constraint = [oldConstraint yy_copyWithFirstItem:firstItem
                                                                   secondItem:secondItem];
        if ([constraint respondsToSelector:@selector(setActive:)]) {
            constraint.active = oldConstraintsActiveValues[index].boolValue;
        } else {
            [newSuperview addConstraint:constraint];
        }
    }];
}

@end

@implementation NSLayoutConstraint (YYTransplantSubviews)

- (NSLayoutConstraint *)yy_copyWithFirstItem:(id)firstItem secondItem:(id)secondItem {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                  attribute:self.firstAttribute
                                                                  relatedBy:self.relation
                                                                     toItem:secondItem
                                                                  attribute:self.secondAttribute
                                                                 multiplier:self.multiplier
                                                                   constant:self.constant];
    constraint.identifier = self.identifier;
    if ([self respondsToSelector:@selector(isActive)]) {
        constraint.active = self.active;
    }
    return constraint;
}

@end

