//
//  MTItemGroupTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/16.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTItemGroupTableViewCell.h"
#import "MTHomeShopModel.h"
#import "MTItemView.h"

@interface MTItemGroupTableViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILongPressGestureRecognizer *pressRecognizer;

@end

@implementation MTItemGroupTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array//形成cell
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        int n = (int)random()%(int)11;
        int z = 0;
        for (int i = n; i < n+8; i++)
        {
            MTShopTuanModel *shopM = array[i];
            MTItemView *backView;
            int l = 0;
            if (z%2 == 0)
            {
                l = 10;
            }else
            {
                l = 5;
            }
            backView = [[MTItemView alloc] initWithFrame:CGRectMake(z%2 * [UIScreen mainScreen].bounds.size.width/2+l, z/2*160+10, [UIScreen mainScreen].bounds.size.width/2-15, 160)
                                                   title:shopM.brand_name
                                                    juli:shopM.distance
                                                pingfeng:shopM.score_desc
                                                 xianjia:shopM.groupon_price
                                                 yuanjia:shopM.market_price
                                                imagestr:shopM.image];
            
            backView.tag = 100+i;
            
            backView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
            [backView addGestureRecognizer:tap];
            
            [self addSubview:backView];
            z++;
            
            /* 长按手势来形成按钮效果（按钮会和scrollView以及tableView的滑动冲突） */
            self.pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];//用长按来做出效果
            self.pressRecognizer.minimumPressDuration = 0.05;
            
            self.pressRecognizer.delegate = self;//用来实现长按不独占
            self.pressRecognizer.cancelsTouchesInView = NO;
            
            [backView addGestureRecognizer:self.pressRecognizer];
            
        }
    }
    return self;
}


-(void)OnTapBackView:(UITapGestureRecognizer *)sender//点击触发 手势
{
    UIView *backView = (UIView *)sender.view;
    int tag = (int)backView.tag-100;
    [self.delegate didSelectedItemTuanAtIndex:tag];
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
