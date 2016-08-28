//
//  MTDataModel.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/13.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTData;

@interface MTDataModel : NSObject

+ (instancetype)sharedStore;
- (BOOL)saveChanges;

- (NSArray *)allItems;
- (void)createItem;


@end
