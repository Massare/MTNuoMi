//
//  MTTitleTableViewCell.h
//  MT_NuoMi
//
//  Created by Austen on 15/10/2.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTTitleTableViewCellDelegate <NSObject>

@optional
-(void)didSelectedJBiaotiAtIndex:(NSInteger)index;

@end

@interface MTTitleTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MTTitleTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSDictionary *act;

@end
