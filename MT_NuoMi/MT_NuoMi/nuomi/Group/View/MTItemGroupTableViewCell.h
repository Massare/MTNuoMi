//
//  MTItemGroupTableViewCell.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/16.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MTItemGroupTableViewCellDelegate <NSObject>

@optional
-(void)didSelectedItemTuanAtIndex:(NSInteger)index;

@end

@interface MTItemGroupTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MTItemGroupTableViewCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array;


@end
