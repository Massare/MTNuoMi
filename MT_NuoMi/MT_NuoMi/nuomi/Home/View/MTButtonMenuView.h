//
//  MTButtonMenuView.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/14.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTButtonMenuView : UIView

-(id)initWithFrame9:(CGRect)frame subtitle:(NSString *)subtitle title:(NSString *)title long_title:(NSString *)long_title;
-(id)initWithFrame8:(CGRect)frame subtitle:(NSString *)subtitle title:(NSString *)title imagestr:(NSString *)imagestr;
-(id)initWithFrame7:(CGRect)frame subtitle:(NSString *)subtitle title:(NSString *)title tuijian:(NSString *)tuijian imagestr:(NSString *)imagestr;
-(id)initWithFrame6:(CGRect)frame subtitle:(NSString *)subtitle title:(NSString *)title imagestr:(NSString *)imagestr;
-(id)initWithFrame5:(CGRect)frame subtitle:(NSString *)subtitle title:(NSString *)title tuijian:(NSString *)tuijian imagestr:(NSString *)imagestr;
-(id)initWithFrame4:(CGRect)frame subtitle:(NSString *)subtitle title:(NSString *)title imagestr:(NSString *)imagestr;
-(id)initWithFrame3:(CGRect)frame subtitle:(NSString *)subtitle title:(NSString *)title imagestr:(NSString *)imagestr;

-(id)initWithFrame2:(CGRect)frame title:(NSString *)title imagestr:(NSString *)imagestr;
-(id)initWithFrame1:(CGRect)frame title:(NSString *)title imagestr:(NSString *)imagestr;
-(id)initWithFrame:(CGRect)frame title:(NSString *)title imagestr:(NSString *)imagestr;

@end
