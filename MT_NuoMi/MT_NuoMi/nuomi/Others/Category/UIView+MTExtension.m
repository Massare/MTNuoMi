//
//  UIView+MTExtension.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/14.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "UIView+MTExtension.h"

@implementation UIView (MTExtension)

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}


- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (BOOL)isShowingOnKeyWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect newFrame = [window convertRect:self.frame fromView:self.superview];
    CGRect winBounds = window.bounds;
    
    BOOL intersect = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == window && intersect;
    
}

/**
 *  从xib中获取视图
 */

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
