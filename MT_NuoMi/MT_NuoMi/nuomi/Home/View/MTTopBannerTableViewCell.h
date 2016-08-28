//
//  MTTopBannerTableViewCell.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTTopBannerTableViewCellDelegate <NSObject>

- (void)didSelectedTopBannerViewIndex:(NSInteger)index;

@end

@interface MTTopBannerTableViewCell : UITableViewCell

@property (nonatomic, weak) id<MTTopBannerTableViewCellDelegate>delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array;

- (void)addTimer;
- (void)closeTimer;

@end
