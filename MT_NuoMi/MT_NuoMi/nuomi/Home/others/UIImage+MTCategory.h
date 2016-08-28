//
//  UIImage+MTCategory.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/16.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MTCategory)

/** 设置图片圆角 */
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

/** 自定义图片大小 */
-(UIImage *) setOriginImage:(UIImage *)image scaleToSize:(CGSize)size;
/** 生成颜色图片 */
-(UIImage *) setOriginColor:(UIColor *)color scaleToSize:(CGSize)size;

@end
