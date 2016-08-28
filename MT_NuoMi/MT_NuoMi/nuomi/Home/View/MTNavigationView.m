//
//  MTNavigationView.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/13.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTNavigationView.h"
#import "MTData.h"
#import "MTDataModel.h"
#import "MTScanViewController.h"
#import "MTCityViewController.h"
#import "MTIFlyMSCViewController.h"
#import "MTSearchViewController.h"

@interface MTNavigationView ()<UISearchBarDelegate, MTCityViewControllerDelegate>

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) UIButton *leftButton;

@end

@implementation MTNavigationView

- (UINavigationController *)navigationController {
    if (!_navigationController) {
        UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        _navigationController = (UINavigationController *)tabBarController.selectedViewController;
    }
    return _navigationController;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        [self addLeftButton];
        [self addSearchView];
        [self addRightButtons];
        
    }
    return self;
}

- (void)addLeftButton {
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(20, 23, 40, 35);
    [self.leftButton setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
    self.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 28, 0, 0)];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.leftButton.tag = 400;
    
    [self.leftButton setTitle:@"杭州" forState:UIControlStateNormal];
//    MTData *item = [[MTDataModel sharedStore] allItems][0];
//    if (self.city == nil) {
//        [self.leftButton setTitle:@"北京" forState:UIControlStateNormal];
//    }else {
//        [self.leftButton setTitle:self.city forState:UIControlStateNormal];
//    }
    
    [self.leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.leftButton];
}

- (void)leftButtonClick {
    MTCityViewController *vc = [[MTCityViewController alloc] init];
    vc.delegate = self;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)didSelectCity:(NSString *)city {
    [self.leftButton setTitle:city forState:UIControlStateNormal];
}

- (void)addRightButtons {
    
    UIButton *sanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sanButton.frame = CGRectMake(MTScreenWidth - 64, 30, 20, 20);
    [sanButton setBackgroundImage:[UIImage imageNamed:@"home-10-8"] forState:UIControlStateNormal];
    sanButton.tag = 402;
    [sanButton addTarget:self action:@selector(scanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sanButton];

    UIButton *shoppingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shoppingButton.frame = CGRectMake(MTScreenWidth - 34, 28, 24, 24);
    [shoppingButton setBackgroundImage:[UIImage imageNamed:@"home-10-7"] forState:UIControlStateNormal];
    shoppingButton.tag = 401;
    [shoppingButton addTarget:self action:@selector(shoppingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shoppingButton];

}

- (void)shoppingButtonClick {
    
}

- (void)scanButtonClick {
    MTScanViewController *vc = [[MTScanViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addSearchView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(70, 25, MTScreenWidth - 145, 30)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    view.layer.cornerRadius = 10;
    view.layer.borderWidth = 0.2;
    view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    view.layer.masksToBounds = YES;
    [self addSubview:view];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, MTScreenWidth - 145, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索商家或地点";
    searchBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:searchBar.bounds.size];
    searchBar.showsScopeBar = NO;
    [view addSubview:searchBar];

    UIView *searchTextField = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        searchBar.barTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        searchTextField = [[[searchBar.subviews firstObject] subviews] lastObject];
    }else {
        for (UIView *subView in searchBar.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                searchTextField = subView;
            }
        }
    }
    
    searchTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    voiceButton.frame = CGRectMake(MTScreenWidth-180, 0, 45, 30);
    [voiceButton setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [voiceButton addTarget:searchBar action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:voiceButton];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, MTScreenWidth - 145, 30);
    [searchButton.backgroundColor colorWithAlphaComponent:0];
    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:searchButton];
}

- (void)voiceButtonClick {
    MTIFlyMSCViewController *vc = [[MTIFlyMSCViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)searchButtonClick {
    
}

//取消searchbar背景色  生成纯色image
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar//不使用
{
    
    MTSearchViewController *search = [[MTSearchViewController alloc]init];
    
    search.hidesBottomBarWhenPushed = YES;//隐藏 tabBar 在navigationController结构中
    [self.navigationController pushViewController:search animated:YES];//1.点击，相应跳转
    
}

@end
