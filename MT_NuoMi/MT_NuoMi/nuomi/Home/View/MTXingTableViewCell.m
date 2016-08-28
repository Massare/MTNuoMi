//
//  MTXingTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTXingTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface MTXingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation MTXingTableViewCell


-(void)setHomeNewDataDic:(NSDictionary *)homeNewDataDic
{
    _homeNewDataDic = homeNewDataDic;
    self.messageLabel.text = [homeNewDataDic objectForKey:@"subTitle"];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:[homeNewDataDic objectForKey:@"titlePictureUrl"]] placeholderImage:[UIImage imageNamed:@"icon_nav_cart_normal"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[homeNewDataDic objectForKey:@"pictureUrl"]] placeholderImage:[UIImage imageNamed:@"icon_nav_cart_normal"]];
}

@end
