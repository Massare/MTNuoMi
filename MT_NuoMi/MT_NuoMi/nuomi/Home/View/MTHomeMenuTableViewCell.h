//
//  MTHomeMenuTableViewCell.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTHomeMenuTableViewCellDelegate <NSObject>

@optional
-(void)didSelectedHomeMenuCellAtIndex:(NSInteger)index;

@end

@interface MTHomeMenuTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MTHomeMenuTableViewCellDelegate> delegate;
+(instancetype)cellWithTableView:(UITableView *)tableView menuArray:(NSMutableArray *)menuArray;

@end
