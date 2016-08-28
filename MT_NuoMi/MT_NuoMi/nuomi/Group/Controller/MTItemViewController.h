//
//  MTItemViewController.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/15.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTItemViewController : UIViewController

@property (nonatomic, strong) NSString *httpUrl;
@property (nonatomic, strong) NSString *HttpArg;
@property (nonatomic) NSURLSession *session;

@end
