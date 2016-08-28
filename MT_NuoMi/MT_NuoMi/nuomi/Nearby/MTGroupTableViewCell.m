//
//  MTGroupTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/10/2.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTGroupTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface MTGroupTableViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILongPressGestureRecognizer *pressRecognizer;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price_current;
@property (weak, nonatomic) IBOutlet UILabel *price_ori;
@property (weak, nonatomic) IBOutlet UILabel *minusFlag;
@property (weak, nonatomic) IBOutlet UILabel *other_desc;


@end

@implementation MTGroupTableViewCell

-(void)setActM:(NSDictionary *)actM
{
    
    self.minusFlag.text = @"";
    
    float price = [actM[@"current_price"] floatValue]/100;
    if ((int)price == price)
    {
        self.price_current.text = [NSString stringWithFormat:@"￥%d",(int)price];
    }else
    {
        self.price_current.text = [NSString stringWithFormat:@"￥%.1f",price];
    }
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:actM[@"tiny_image"]] placeholderImage:[UIImage imageNamed:@"icon_nav_cart_normal"]];
    
    self.name.text = actM[@"min_title"];
    
    if ([actM[@"sale_num"] integerValue] >10000)
    {
        long n = [actM[@"sale_num"] integerValue]/10000;
        self.other_desc.text = [NSString stringWithFormat:@"已售 %ld万",n];
    }else
    {
        long n = [actM[@"sale_num"] integerValue];
        self.other_desc.text = [NSString stringWithFormat:@"已售 %ld",n];
    }
    
    //中间的划线
    NSString *oldStr = [NSString stringWithFormat:@"%ld",[actM[@"market_price"] integerValue]/100];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
    self.price_ori.attributedText = attribtStr;
    
    self.userInteractionEnabled = YES;
    /* 长按手势来形成按钮效果（按钮会和scrollView以及tableView的滑动冲突） */
    
    self.pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];//用长按来做出效果
    self.pressRecognizer.minimumPressDuration = 0.05;
    self.pressRecognizer.delegate = self;
    self.pressRecognizer.cancelsTouchesInView = NO;
    
    [self addGestureRecognizer:self.pressRecognizer];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;//长按手势会独占对象，故用代理将他取消独占
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
