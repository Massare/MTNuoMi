//
//  MTEssenceTableViewCell.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTEssenceTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, strong) NSArray *activeTimeArray;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@end
