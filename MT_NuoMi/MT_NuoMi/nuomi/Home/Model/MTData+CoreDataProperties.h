//
//  MTData+CoreDataProperties.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/13.
//  Copyright © 2015年 mlc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTData.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSData *historyData;
@property (nonatomic) double orderingValue;
@property (nullable, nonatomic, retain) NSString *searchTerm;

@end

NS_ASSUME_NONNULL_END
