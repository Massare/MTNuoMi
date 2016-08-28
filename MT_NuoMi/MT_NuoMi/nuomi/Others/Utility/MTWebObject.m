//
//  MTWebObject.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/15.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTWebObject.h"

@implementation MTWebObject

-(void)TestNOParameter
{
    NSLog(@"this is ios TestNOParameter");
}

-(void)TestOneParameter:(NSString *)message
{
    NSLog(@"this is ios TestOneParameter=%@",message);
}

-(void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2
{
    NSLog(@"this is ios TestTowParameter=%@  Second=%@",message1,message2);
}

@end
