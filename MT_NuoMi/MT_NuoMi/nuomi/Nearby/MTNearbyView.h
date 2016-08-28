//
//  MTNearbyView.h
//  MT_NuoMi
//
//  Created by Austen on 15/10/2.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTNearbyView : UIView

-(id)initWithFrame2:(CGRect)frame name:(NSString *)name distance:(NSString *)distance discount:(NSString *)discount;

-(id)initWithFrame1:(CGRect)frame name:(NSString *)name distance:(NSString *)distance discount:(NSString *)discount;

-(id)initWithFrame0:(CGRect)frame name:(NSString *)name distance:(NSString *)distance discount:(NSString *)discount imagestr:(NSString *)imagestr  array:(NSArray *)array;

@end
