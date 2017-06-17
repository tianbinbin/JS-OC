//
//  ViewController.m
//  JSDemo
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "ViewController.h"
#import "TBJStest.h"
#import "webViewjavascribtViewController.h"

// 原生交互 这个库是apple iOS7 之后推出来的库 实现网页与原生的交互问题
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * CustomwebView;          // 创建一个webview

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"js and Native";
    
    // 2. 创建webview 对象
    self.CustomwebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-40)];
    self.CustomwebView.delegate=self;
    //添加webview到当前viewcontroller的view上
    [self.view addSubview:self.CustomwebView];
    
    //网址
    NSString *httpStr=@"https://www.baidu.com";
    NSURL *httpUrl=[NSURL URLWithString:httpStr];
    NSURLRequest *httpRequest=[NSURLRequest requestWithURL:httpUrl];
    [self.CustomwebView loadRequest:httpRequest];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-40, self.view.bounds.size.width, 40)];
    [btn setTitle:@"webviewjavascribt" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor  grayColor];
    [btn addTarget:self action:@selector(TB_BtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
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

     NSLog(@"网页加载完成");
    
    // 我们做交互一般都是在网页加载完成
    
    /**
     *    通过OC 调js
     */
    //1.首先创建JSContext 对象（此处通过当前 webview 的键获取到 jscontext）
    JSContext * context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //2.准备执行的js 代码
    NSString * alertJS = @"alert ('text1 js OC')";
    //3.通过OC 方法调用js的 alert
    [context evaluateScript:alertJS];
    
    /*************************************************************************/
    
    /**
     *    js 调 oc 有两种形式
     */
    
    /*
    // 1. js 调 oc 方式一
    // test1 是js 的方法名称 通过webview的键获取的 jscontext  将其整体赋值给oc 的一个block block 执行的是ios 的代码 就是js 调 oc
    context[@"test1"] = ^(){
        
        //1. 我们从js 获取的参数一般是一个数组
        NSArray * args = [JSContext currentArguments];
        
        //2. 打印获取到的参数
        for(id obj in args){
        
            NSLog(@"打印从js获取到的参数---%@",obj);
        }
    };
    
    //2.因为没有后台 我们清楚ios 如何调js 这里写一些假的参数
    NSString * jsfunctStr = @"test1('tianbin')";
    [context evaluateScript:jsfunctStr];
    
    NSString * jsfunctStr1 = @"test1('tianbin shuai ge')";
    [context evaluateScript:jsfunctStr1];
    */
   
    
    //2.js 调oc 第二种方式 通过对象调用，我们假设js里面有一个对象 testobject
    // 在 js 调用之前我们也创建一个对象 并将这个对象赋值给js 对象 testobject
    TBJStest *testJO=[TBJStest new];
    context[@"testobject"]=testJO;
    
    //同样我们也用刚才的方式模拟一下js调用方法
    NSString *jsStr1=@"testobject.TestNOParameter()";
    [context evaluateScript:jsStr1];
    NSString *jsStr2=@"testobject.TestOneParameter('参数1')";
    [context evaluateScript:jsStr2];
    NSString *jsStr3=@"testobject.TestTowParameterSecondParameter('参数A','参数B')";
    [context evaluateScript:jsStr3];
    
}

// 网页请求失败则会调用该方法
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"网页加载失败");
}



-(void)TB_BtnClik:(UIButton *)btn{


    // 跳转到下一个界面 用第三方库实现
    [self.navigationController pushViewController:[[webViewjavascribtViewController alloc]init] animated:YES];
    
}


@end
