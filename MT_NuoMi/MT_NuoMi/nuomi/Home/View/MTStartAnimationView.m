//
//  MTStartAnimationView.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/16.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTStartAnimationView.h"

@implementation MTStartAnimationView

static MTStartAnimationView *_animationView = nil;
+ (MTStartAnimationView *)shareAnimationView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _animationView = [[MTStartAnimationView alloc] init];
    });
    return _animationView;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _animationView = [super alloc];
    });
    return _animationView;
}

+ (MTStartAnimationView *)launchAnimation {
    return [[self shareAnimationView] initWithFrame:CGRectMake(0, 0, MTScreenWidth, MTScreenHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
 
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=9; i++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_hud_%zd", i]];
            [refreshingImages addObject:image];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MTScreenWidth/2-100, MTScreenHeight/2-70, 200, 120)];
        imageView.animationImages = refreshingImages;
        [self addSubview:imageView];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
//        [self.view addSubview:_startAnimationView];
        //[self.view bringSubviewToFront:_yourSuperView];
        //[self.view insertSubview:_yourSuperView atIndex:0];
        
        self.hidden = NO;
        
        //设置执行一次完整动画的时长
        imageView.animationDuration = 9*0.15;
        //动画重复次数 （0为重复播放）
        imageView.animationRepeatCount = 30;
        [imageView startAnimating];
    }
    return self;
}



@end
