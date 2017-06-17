//
//  webViewjavascribtViewController.m
//  JSDemo
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "webViewjavascribtViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
// 添加第三方库
#import "WebViewJavascriptBridge.h"


@interface webViewjavascribtViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge * bridge;     // 通过第三方库创建对象
@property (nonatomic, strong) UIWebView * CustomwebView;            // webView  创建方式与上一个界面的一样 我直接copy

@end

@implementation webViewjavascribtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建webview 对象
    self.CustomwebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.CustomwebView.delegate=self;
    //添加webview到当前viewcontroller的view上
    [self.view addSubview:self.CustomwebView];
    
    //网址
    NSString *httpStr=@"https://www.baidu.com";
    NSURL *httpUrl=[NSURL URLWithString:httpStr];
    NSURLRequest *httpRequest=[NSURLRequest requestWithURL:httpUrl];
    [self.CustomwebView loadRequest:httpRequest];
    
    
    // 1. 类方法创建对象 让 WebViewJavascriptBridge 与 webview 桥接
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.CustomwebView];
    [self.bridge setWebViewDelegate:self];
    
    

    
    
    // 2. 注册handel @"openCamera" 要与后台商定 确定名字一样
//    [self.bridge registerHandler:@"tbtext1" handler:^(id data, WVJBResponseCallback responseCallback) {
//        
//        NSLog(@"收到指令执行ios 的代码");
//        
//        
//    }];
    
    
//    [self.bridge registerHandler:@"registerFunc" handler:^(id data, WVJBResponseCallback responseCallback) {
//        
//        NSLog(@"收到指令执行ios 的代码");
//        
//        
//    }];
}



#pragma mark------webviewdelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页加载之前会调用此方法
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    return YES;
}

//  请求发送之后开始接收响应之前会调用这个方法
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"网页开始加载");
}

//  请求发送之后,并且服务器已经返回响应之后调用该方法
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    // 获取当前页面的title
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    // 获取当前页面的url
    NSString *url = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    NSLog(@"网页加载完成当前网页的标题:%@  当前网页的url=%@",title,url);
    
    
    
    
    

    //1.首先创建JSContext 对象（此处通过当前 webview 的键获取到 jscontext）
    JSContext * context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    

    
    
    //不需要传参数,不需要后台返回执行结果
//    [self.bridge callHandler:@"registerFunc"];
    
    //需要传参数,不需要从后台返回执行结果
    /***
     @param callHandler 商定的事件名称,用来调用网页里面相应的事件实现
     @param data id类型,相当于我们函数中的参数,向网页传递函数执行需要的参数
     ***/
    
//    [_bridge callHandler:@"registerFunc" data:@"name"];
    
    //需要传参数,需要从后台返回执行结果
    
//    [_bridge callHandler:@"registerFunc" data:@"name" responseCallback:^(id responseData) {
//        
//        NSLog(@"后台执行完成后返回的数据");
//        
//    }];

    

    
    
    // js 调 oc
    /***
     /@param registerHandler 要注册的事件名称(这里我们为loginFunc)
     /@param handel 回调block函数 当后台触发这个事件的时候会执行block里面的代码
     ***/
//    [_bridge registerHandler:@"test1" handler:^(id data, WVJBResponseCallback responseCallback) {
//        // data 后台传过来的参数,例如用户名、密码等
//        
//        NSLog(@"testObjcCallback called: %@", data);
//        
//        //具体的登录事件的实现,这里的login代表实现登录功能的一个OC函数。
// 
//        
//        // responseCallback 给后台的回复
//        
//        responseCallback(@"Response from testObjcCallback");
//    }];
    
    
    
    /**
     *    通过OC 调js
     */
    //2.准备执行的js 代码
    NSString * jsfunctStr1 = @"test1('tianbin shuai ge')";
    //3.通过OC 方法调用js的 alert
    [context evaluateScript:jsfunctStr1];
    
    // oc 调 js
    
    //不需要传参数,不需要后台返回执行结果
//    [_bridge callHandler:@"registerFunc"];
    
    //需要传参数,不需要从后台返回执行结果
    /***
     @param callHandler 商定的事件名称,用来调用网页里面相应的事件实现
     @param data id类型,相当于我们函数中的参数,向网页传递函数执行需要的参数
     ***/
    
//    [_bridge callHandler:@"registerFunc" data:@"name"];
    
    //需要传参数,需要从后台返回执行结果
    
//    [_bridge callHandler:@"registerFunc" data:@"name" responseCallback:^(id responseData) {
//        
//        NSLog(@"后台执行完成后返回的数据");
//        
//    }];

}

// 网页请求失败则会调用该方法
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"网页加载失败");
}



@end
