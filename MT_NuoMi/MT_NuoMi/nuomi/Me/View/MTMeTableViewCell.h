//
//  MTMeTableViewCell.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/18.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTMeTableViewCellDelegate <NSObject>

- (void)didSelectedCellItemAtIndex:(NSInteger)index;

@end

@interface MTMeTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MTMeTableViewCellDelegate>delegate;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array;

@end
