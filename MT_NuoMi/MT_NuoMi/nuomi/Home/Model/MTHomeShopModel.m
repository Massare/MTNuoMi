//
//  MTHomeShopModel.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/13.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTHomeShopModel.h"

@implementation MTHomeShopModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"tuan_list":@"tuan_list",
             @"tuan_num":@"tuan_num"
             };
}


+(NSValueTransformer *)tuan_listJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MTShopTuanModel class]];
}

@end


@implementation MTShopTuanModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"deal_id":@"deal_id",
             @"image":@"image",
             @"brand_name":@"brand_name",
             @"short_title":@"short_title",
             @"sale_count":@"sale_count",
             
             @"groupon_price":@"groupon_price",
             @"market_price":@"market_price",
             @"pay_start_time":@"pay_start_time",
             @"pay_start_time":@"pay_start_time",
             @"newgroupon":@"new_groupon",
             
             @"sale_out":@"sale_out",
             @"groupon_type":@"groupon_type",
             @"score":@"score",
             @"comment_num":@"comment_num",
             @"bought_weekly":@"bought_weekly",
             
             @"reason":@"reason",
             @"is_latest":@"is_latest",
             @"other_desc":@"other_desc",
             @"score_desc":@"score_desc",
             @"appoint":@"appoint",
             
             @"is_flash":@"is_flash",
             @"is_t10":@"is_t10",
             @"is_card":@"is_card",
             @"favour_list":@"favour_list",
             @"distance":@"distance",
             
             @"user_distance_status":@"user_distance_status",
             @"user_distance_poi":@"user_distance_poi",
             @"user_distance":@"user_distance",
             @"s":@"s",
             @"ifvirtual":@"ifvirtual",
             
             @"virtual_redirect_url":@"virtual_redirect_url"
             };
}

@end
