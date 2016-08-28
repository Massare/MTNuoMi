//
//  MTTopView.h
//  MT_NuoMi
//
//  Created by Austen on 15/10/2.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTTopViewDelegate <NSObject>

@optional

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withId:(NSNumber *)ID withName:(NSString *)name;

@end

@interface MTTopView : UIView

@property(nonatomic, assign) id<MTTopViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *bigGroupArray;//获取右侧数据
@property (nonatomic, strong) NSMutableArray *topArray;//获取左侧数据

@end
