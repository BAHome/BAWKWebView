//
//  ViewController2.m
//  BAWebViewController
//
//  Created by boai on 2017/6/13.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "ViewController2.h"
#import "BAKit_WebView.h"

@interface ViewController2 ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation ViewController2


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BAKit_Color_Gray_10_pod;
    self.shareBtn.hidden = NO;
    self.webView.hidden = NO;
    
    NSString *htmlName = @"BAHome2";
    [self.webView ba_web_loadHTMLFileName:htmlName];

    [self ba_JS_OC];
    [self ba_OC_JS_2];
}

#pragma mark - JS_OC
- (void)ba_JS_OC
{
    // 1、先注册ID
    NSArray *messageNameArray = @[@"BA_Alert", @"BA_JumpVC", @"BA_SendMsg"];
    [self.webView ba_web_addScriptMessageHandlerWithNameArray:messageNameArray];
    
    // 2、JS 调用 OC 时 webview 会调用此 block
    BAKit_WeakSelf
    self.webView.ba_web_userContentControllerDidReceiveScriptMessageBlock = ^(WKUserContentController * _Nonnull userContentController, WKScriptMessage * _Nonnull message) {
        BAKit_StrongSelf
        if ([message.name isEqualToString:messageNameArray[0]])
        {
            NSString *msg = @"生命不息，折腾不止...来自 OC Alert！";
            BAKit_ShowAlertWithMsg_ios8(msg);
        }
        else if ([message.name isEqualToString:messageNameArray[1]])
        {
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = BAKit_Color_Green_pod;
            vc.title = @"这里是 JS 按钮跳转的 VC";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([message.name isEqualToString:messageNameArray[2]])
        {
            NSArray *array = message.body;
            NSString *msg = [NSString stringWithFormat:@"这是博爱的手机号: %@, \n%@ !!",array[0], array[1]];
            BAKit_ShowAlertWithMsg_ios8(msg);
        }
    };
}

#pragma mark - OC 拦截 JS URL 处理
- (void)ba_OC_JS_2
{
    BAKit_WeakSelf
    // 必须要先设定 要拦截的 urlScheme，然后再处理 回调
    self.webView.ba_web_urlScheme = @"basharefunction";
    self.webView.ba_web_decidePolicyForNavigationActionBlock = ^(NSURL *currentUrl) {
    
        BAKit_StrongSelf
        // 判断 host 是否对应，然后做相应处理
        if ([currentUrl.host isEqualToString:@"shareClick"])
        {
            // 拦截到 URL 中的分享 内容
            [self ba_shareClickWithUrl:currentUrl];
        }
        else if ([currentUrl.host isEqualToString:@"getLocation"])
        {
            [self ba_getLocationWithUrl:currentUrl];
        }
    };
}

#pragma mark OC 拦截 JS URL 处理：1、拦截 JS 提供的分享内容，用 OC 方法处理
- (void)ba_shareClickWithUrl:(NSURL *)url
{
    NSString *url_query = url.query;
    NSArray *paramArray = [url_query componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *dict_key in paramArray)
    {
        NSArray *dataArray = [dict_key componentsSeparatedByString:@"="];
        if (dataArray.count > 1)
        {
            NSString *decode_value = [dataArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [dict setObject:decode_value forKey:dataArray[0]];
        }
    }
    NSLog(@"从H5端获取的参数字典：%@", dict);
    
    /*!
     从H5端获取的参数字典：
     {
         content = "欢迎使用博爱分享2.1版本";
         imagePath = "图片地址";
         title = "博爱分享2.1版本";
         url = "www.baidu.com";
     }
     */
    
    /*!
     与后台进行交互  上传服务器  这里是测试demo  假设传回来的字典参数都上传服务器
     */
    NSString *msg = [NSString stringWithFormat:@"分享标题：%@，\n内容：%@，\n图片URL：%@，\nURL：%@", dict[@"title"], dict[@"content"], dict[@"imagePath"], dict[@"url"]];
    BAKit_ShowAlertWithMsg_ios8(msg);
}

#pragma mark OC 拦截 JS URL 处理：2、拦截 JS 获取的定位信息，用 OC 方法处理
- (void)ba_getLocationWithUrl:(NSURL *)url
{
    NSString *url_query = url.query;
    NSArray *paramArray = [url_query componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *dict_key in paramArray)
    {
        NSArray *dataArray = [dict_key componentsSeparatedByString:@"="];
        if (dataArray.count > 1)
        {
            NSString *decode_value = [dataArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [dict setObject:decode_value forKey:dataArray[0]];
        }
    }
    NSLog(@"从H5端获取的参数字典：%@", dict);
    
    /*!
     从H5端获取的参数字典：
     {
     latitude = "23.10486444538465";
     longitude = "113.37970297389353";
     }
     */
    NSString *msg = [NSString stringWithFormat:@"OC 拦截【从 JS 获取的当前定位】处理\n纬度：%@\n经度：%@", dict[@"latitude"], dict[@"longitude"]];
    BAKit_ShowAlertWithMsg_ios8(msg);
}

#pragma mark - OC_JS
- (void)ba_OC_JS
{
    // 3、OC 调用 JS
    NSString *jsMethod = [NSString stringWithFormat:@"ba_insert('18566668888', '生命不息，折腾不止...这里是 OC 插入 JS 的语句！')"];
    [self.webView ba_web_stringByEvaluateJavaScript:jsMethod completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
        
    }];
}

#pragma mark - OC 按钮调用 JS 方法：【JavaScriptCore 库】！
- (IBAction)clickShareBtn:(UIButton *)sender
{
    BAKit_WeakSelf
    if (!self.webView.loading)
    {
        BAKit_StrongSelf
        [self ba_OC_JS];
    }
}

#pragma mark - JS 调用 OC 

- (void)ba_js_OCWithDictionary:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
    NSString *title = dict[@"title"];
    NSString *content = dict[@"content"];
    NSString *url = dict[@"url"];

    // OC反馈给JS分享结果
    NSString *result = [NSString stringWithFormat:@"ba_shareResult('%@', '%@', '%@')", title, content, url];
    
    // OC 调用 JS
    [self.webView ba_web_stringByEvaluateJavaScript:result completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _webView.frame = CGRectMake(0, 80, BAKit_SCREEN_WIDTH, 300);
    _shareBtn.frame = CGRectMake(50, BAKit_SCREEN_HEIGHT - 100, 150, 40);

}

#pragma mark - setter / getter

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [WKWebView new];
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        BAKit_WeakSelf
        [self.webView ba_web_initWithDelegate:weak_self.webView uIDelegate:weak_self.webView];
        
        _webView.backgroundColor = BAKit_Color_Yellow_pod;
        
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn)
    {
        _shareBtn = [UIButton new];
        [_shareBtn setTitle:@"OC 按钮调用 JS 方法" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:BAKit_Color_Black_pod forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _shareBtn.tag = 1001;
        [_shareBtn setBackgroundColor:BAKit_Color_Green_pod];
        [_shareBtn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        
        [self.view addSubview:_shareBtn];
    }
    return _shareBtn;
}

@end
