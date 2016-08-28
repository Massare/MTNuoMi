//
//  MTRecommendTableViewCell.h
//  MT_NuoMi
//
//  Created by Austen on 15/10/2.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTRecommendTableViewCellDelegate <NSObject>

@optional
-(void)didSelectedTuiJianAtIndex:(NSInteger)index;

@end

@interface MTRecommendTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MTRecommendTableViewCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array ;

@end
