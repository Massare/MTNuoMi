//
//  MTPriceTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/16.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTPriceTableViewCell.h"

@interface MTPriceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestPriceLabel;

@end

@implementation MTPriceTableViewCell

- (void) setAct:(NSDictionary *)act
{
    if (act)
    {
        self.nameLabel.text = act[@"title"];
        self.descriptionLabel.text = act[@"description"];
        
        float price = [act[@"current_price"] floatValue]/100;
        NSString *tuan;
        if ((int)price == price)
        {
            tuan = [NSString stringWithFormat:@"%ld",[act[@"current_price"] integerValue]/100];
        }else
        {
            tuan = [NSString stringWithFormat:@"%.1f",[act[@"current_price"] floatValue]/100];
        }
        //富文本
        NSMutableAttributedString *tuanatt =  [[NSMutableAttributedString alloc] init];
        NSAttributedString *tuan0 = [[NSAttributedString alloc]initWithString:@"￥"];
        NSMutableAttributedString *tuan1 = [[NSMutableAttributedString alloc]initWithString:tuan];
        NSAttributedString *tuan2 = [[NSAttributedString alloc]initWithString:@"团购价"];
        [tuan1 addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:25]
                      range:NSMakeRange(0, tuan1.length)];
        
        NSString *oldStr = [NSString stringWithFormat:@"门市价 %ld",[act[@"market_price"] integerValue]/100];
        
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:oldStr
                                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                                                                  NSForegroundColorAttributeName:[UIColor grayColor],
                                                                                  NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                                                                  NSStrikethroughColorAttributeName:[UIColor grayColor]}];
        
        [tuanatt appendAttributedString: tuan0];//拼接
        [tuanatt appendAttributedString: tuan1];
        [tuanatt appendAttributedString: tuan2];
        
        self.latestPriceLabel.attributedText= attrStr;
        self.priceLabel.attributedText = tuanatt;
    }
    
}

@end
