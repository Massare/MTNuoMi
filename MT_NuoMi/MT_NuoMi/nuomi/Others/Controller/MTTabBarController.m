//
//  MTTabBarController.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTTabBarController.h"
#import "MTNavigationController.h"
#import "MTHomeViewController.h"
#import "MTNearbyViewController.h"
#import "MTEssenceViewController.h"
#import "MTMeViewController.h"

@interface MTTabBarController ()

@end

@implementation MTTabBarController


+ (void)initialize {
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:252/255.0 green:74/255.0 blue:132/255.0 alpha:0.9];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    
}


- (void)addChildViewControllers {
    
    [self setupController:[[MTHomeViewController alloc] init] title:@"首页" image:@"icon_tab_shouye_normal" selectedImage:@"icon_tab_shouye_highlight"];
    [self setupController:[[MTNearbyViewController alloc] init] title:@"附近" image:@"icon_tab_fujin_normal" selectedImage:@"icon_tab_fujin_highlight"];
    [self setupController:[[MTEssenceViewController alloc] init] title:@"精选" image:@"tab_icon_selection_normal" selectedImage:@"tab_icon_selection_highlight"];
    [self setupController:[[MTMeViewController alloc] init] title:@"我" image:@"icon_tab_wode_normal" selectedImage:@"icon_tab_wode_highlight"];
    
}

- (void)setupController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}



@end
