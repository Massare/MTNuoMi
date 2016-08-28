//
//  UIView+MTExtension.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/14.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;

/** 判断一个控件是否真正显示在主窗口 */
- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;

@end
