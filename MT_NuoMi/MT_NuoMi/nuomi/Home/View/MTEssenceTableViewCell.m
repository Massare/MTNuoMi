//
//  MTEssenceTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTEssenceTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MTEssenceTableViewCell
{
    NSTimeInterval _startTime;
    NSTimeInterval _nowTime;
}

- (void)awakeFromNib {
    self.hourLabel.layer.masksToBounds = YES;
    self.minLabel.layer.masksToBounds = YES;
    self.secondLabel.layer.masksToBounds = YES;
}

-(void)setListArray:(NSArray *)listArray
{
    _listArray = listArray;
    
    if (listArray.count == 3) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = (UIImageView *)[self.contentView viewWithTag:200+i];
            UILabel *shopNameLabel = (UILabel *)[self.contentView viewWithTag:210+i];
            UILabel *newPriceLabel = (UILabel *)[self.contentView viewWithTag:220+i];
            UILabel *oldPriceLabel = (UILabel *)[self.contentView viewWithTag:230+i];
            
            
            shopNameLabel.text = [listArray[i] objectForKey:@"brand"];
            newPriceLabel.text = [NSString stringWithFormat:@"￥%ld",[[listArray[i] objectForKey:@"current_price"] integerValue]/100];
            
            NSString *oldStr = [NSString stringWithFormat:@"%ld",[[listArray[i] objectForKey:@"market_price"] integerValue]/100];
            //中划线
            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
            oldPriceLabel.attributedText = attribtStr;
            //变换数据  网页
            
            NSString *imgStr = [listArray[i] objectForKey:@"na_logo"];
            NSRange range = [imgStr rangeOfString:@"src="];
            if (range.location != NSNotFound) {
                NSString *subStr = [imgStr substringFromIndex:range.location+range.length];
                subStr = [subStr stringByRemovingPercentEncoding];
                [imageView sd_setImageWithURL:[NSURL URLWithString:subStr] placeholderImage:[UIImage imageNamed:@"icon_nav_cart_normal"]];
               
            }
        }
    }else{
        
    }
}

-(void)setActiveTimeArray:(NSArray *)activeTimeArray
{
    _activeTimeArray = activeTimeArray;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    _nowTime=[dat timeIntervalSince1970];
    //NSString *timeString = [NSString stringWithFormat:@"%.0f", _nowTime];
 
    for (int i = 0; i < activeTimeArray.count; i++)
    {
        NSInteger endtime = [[activeTimeArray[i] objectForKey:@"endtime"] integerValue];
        NSInteger starttime = [[activeTimeArray[i] objectForKey:@"starttime"] integerValue];
        if (_nowTime < endtime)
        {
            if (_nowTime < starttime)
            {
                self.titleLabel.text = @"距开始";
                _startTime = starttime;
            }else
            {
                self.titleLabel.text = @"距结束";
                _startTime = endtime;
            }
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];//定时器每秒传输
            break;
        }
    }
    
}

- (void)updateUI {
     [self performSelectorOnMainThread:@selector(setTimeLabel) withObject:nil waitUntilDone:NO];
}

-(void)setTimeLabel
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    _nowTime=[dat timeIntervalSince1970];
    if (_startTime <= _nowTime)
    {
        return;
    }
    NSInteger subTime = _startTime - _nowTime;
    NSInteger hour = subTime/3600;
    NSInteger min = (subTime%3600)/60;
    NSInteger sec = (subTime%3600)%60;
    self.hourLabel.text = [NSString stringWithFormat:@"%02ld",(long)hour];
    self.minLabel.text = [NSString stringWithFormat:@"%02ld",(long)min];
    self.secondLabel.text = [NSString stringWithFormat:@"%02ld",(long)sec];
    
}



@end
