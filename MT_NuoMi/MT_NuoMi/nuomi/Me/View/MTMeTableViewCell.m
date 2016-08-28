//
//  MTMeTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/18.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTMeTableViewCell.h"
#import "MTButtonMenuView.h"

@implementation MTMeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array //形成cell
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        for (int i = 0; i < array.count; i++)
        {
            NSDictionary *act = array[i];
            MTButtonMenuView *backView;
            
            backView = [[MTButtonMenuView alloc] initWithFrame1:CGRectMake(i * [UIScreen mainScreen].bounds.size.width/array.count, 0, [UIScreen mainScreen].bounds.size.width/array.count, 80)
                                                       title:act[@"title"]
                                                    imagestr:act[@"image"]];
            
            backView.tag = 100+i;
            
            backView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
            [backView addGestureRecognizer:tap];
            
            backView.backgroundColor = [UIColor whiteColor];
            
            [self addSubview:backView];
            
        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)OnTapBackView:(UITapGestureRecognizer *)sender//点击触发 手势
{
    //UIView *backView = (UIView *)sender.view;
    //int tag = (int)backView.tag-100;
    [self.delegate didSelectedCellItemAtIndex:0];
    //NSLog(@"%d",tag);
}




@end
