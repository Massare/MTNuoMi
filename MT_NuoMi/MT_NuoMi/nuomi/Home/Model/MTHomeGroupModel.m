//
//  MTHomeGroupModel.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/13.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTHomeGroupModel.h"

@implementation MTHomeGroupModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"hotService":@"hotService",
             @"topten":@"topten",
             @"nuomiNews":@"nuomiNews",
             @"nuomiBigNewBanner":@"nuomiBigNewBanner",
             @"banners":@"banners",
             @"activityGroup":@"activityGroup",
             @"category":@"category",
             @"daoDianfu":@"daoDianfu",
             @"meishiGroup":@"meishiGroup",
             @"entertainment":@"entertainment",
             };
}

+ (NSValueTransformer *)group3JSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MTHomeGroup3Model class]];
}

+ (NSValueTransformer *)toptenJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[MTHometopModel class]];
}

@end

@implementation MTHomeGroup3Model

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"ceilTitle":@"ceilTitle",
             @"descTitle":@"descTitle",
             @"descColor":@"descColor",
             @"listInfo":@"listInfo",
             @"moreLink":@"moreLink",
             @"titleColor":@"titleColor",
             @"banner":@"banner",
             };
}

@end


@implementation MTHometopModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"activetime":@"activetime",
             @"list":@"list",
             @"isLogo":@"isLogo",
             @"target_url":@"target_url"
             };
}

@end
