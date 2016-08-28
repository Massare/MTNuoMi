//
//  MTCityViewController.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTCityViewControllerDelegate <NSObject>

- (void)didSelectCity:(NSString *)city;

@end

@interface MTCityViewController : UIViewController

@property (nonatomic, weak)id<MTCityViewControllerDelegate>delegate;

@end
