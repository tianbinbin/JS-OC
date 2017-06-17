//
//  TBJStest.h
//  JSDemo
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

// 第二种 js 调 oc 的 方法 我们首先创建一个实现了JSExport协议的协议 凡事添加了JSExport协议的协议，所规定的方法，变量等 就会对js开放，我们可以通过js调用到

@protocol TBTestJSObjectProtocol <JSExport>

//此处我们测试几种参数的情况
-(void)TestNOParameter;
-(void)TestOneParameter:(NSString *)message;
-(void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2;

@end

@interface TBJStest : NSObject<TBTestJSObjectProtocol>

@end
