//
//  MTGuessLikeTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTGuessLikeTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "MTHomeShopModel.h"

@interface MTGuessLikeTableViewCell ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *latestPriceLabel;


@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@property (nonatomic, strong) UILongPressGestureRecognizer *pressRecognizer;

@end

@implementation MTGuessLikeTableViewCell

-(void)setShopM:(MTShopTuanModel *)shopM
{
    _shopM = shopM;
    NSRange range = [shopM.image rangeOfString:@"src="];
    if (range.location != NSNotFound) {
        NSString *subStr = [shopM.image substringFromIndex:range.location+range.length];
        subStr = [subStr stringByRemovingPercentEncoding];
        [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:subStr] placeholderImage:nil];
    }
    
    self.layer.borderWidth = 0.5;//边框线
    self.layer.borderColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.9].CGColor;
    
    self.nameLabel.text = shopM.brand_name;
    self.descriptionLabel.text = shopM.short_title;
    self.distanceLabel.text = shopM.distance;
    
    float price = [shopM.groupon_price floatValue]/100;
    if ((int)price == price)
    {
        self.latestPriceLabel.text = [NSString stringWithFormat:@"￥%ld",[shopM.groupon_price integerValue]/100];
    }else
    {
        self.latestPriceLabel.text = [NSString stringWithFormat:@"￥%.1f",[shopM.groupon_price floatValue]/100];
    }
    
    self.scoreLabel.text = shopM.score_desc;
    
    //中间的划线
    NSString *oldStr = [NSString stringWithFormat:@"%ld",[shopM.market_price integerValue]/100];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
    self.oldPriceLabel.attributedText = attribtStr;
    
    /* 长按手势来形成按钮效果（按钮会和scrollView以及tableView的滑动冲突） */
    self.pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];//用长按来做出效果
    self.pressRecognizer.minimumPressDuration = 0.05;
    
    self.pressRecognizer.delegate = self;//用来实现长按不独占
    self.pressRecognizer.cancelsTouchesInView = NO;
    
    [self addGestureRecognizer:self.pressRecognizer];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)longPress:(UITapGestureRecognizer *)sender//长按触发
{
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        sender.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.9];
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        sender.view.backgroundColor = [UIColor whiteColor];
    }
    
}


@end
