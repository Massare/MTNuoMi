//
//  MTHomeGroupModel.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/13.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MTHometopModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *activetime;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSNumber *isLogo;
@property (nonatomic, strong) NSString *target_url;

@end

//服务
@interface MTHomeGroup3Model : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *ceilTitle;
@property (nonatomic, strong) NSString *descTitle;
@property (nonatomic, strong) NSString *descColor;
@property (nonatomic, strong) NSArray *listInfo;

@property (nonatomic, strong) NSString *moreLink;
@property (nonatomic, strong) NSString *titleColor;

@property (nonatomic, strong) NSArray *banner;

@end


@interface MTHomeGroupModel : MTLModel<MTLJSONSerializing>



@property (nonatomic, strong) MTHometopModel *topten;
@property (nonatomic, strong) NSArray *nuomiNews;
@property (nonatomic, strong) NSArray *nuomiBigNewBanner;
@property (nonatomic, strong) NSArray *banners;

@property (nonatomic, strong) NSDictionary *activityGroup;//listInfo 数组
@property (nonatomic, strong) NSArray *category;
@property (nonatomic, strong) NSArray *daoDianfu;

@property (nonatomic, strong) MTHomeGroup3Model *hotService;
@property (nonatomic, strong) MTHomeGroup3Model *meishiGroup;
@property (nonatomic, strong) MTHomeGroup3Model *entertainment;


@end
