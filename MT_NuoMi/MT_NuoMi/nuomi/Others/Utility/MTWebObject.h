//
//  MTWebObject.h
//  MT_NuoMi
//
//  Created by Austen on 15/9/15.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//首先创建一个实现了JSExport协议的协议
@protocol TestJSObjectProtocolDelegate <JSExport>

//此处我们测试几种参数的情况
-(void)TestNOParameter;
-(void)TestOneParameter:(NSString *)message;
-(void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2;

@end


@interface MTWebObject : NSObject

@end
