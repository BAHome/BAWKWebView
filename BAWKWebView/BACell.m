//
//  BACell.m
//  BAWKWebView
//
//  Created by boai on 2017/6/30.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BACell.h"
#import "WebVIewModel.h"

static NSString * const kCellID = @"BACell_id";

@interface BACell ()

//@property(nonatomic, strong) WKWebViewConfiguration *webConfig;

@end

@implementation BACell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

+ (id)ba_creatCellWithTableView:(UITableView *)tableView
{
    BACell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (!cell)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
    }
    
    return cell;
}

- (void)setupUI
{
//    self.webView.hidden = NO;
    
}

- (void)setModel:(WebVIewModel *)model
{
    _model = model;
    
    if (self.model.height == 100)
    {
        [self.webView ba_web_loadHTMLString:self.model.contentHtml];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.webView.frame = self.bounds;
//    self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.webView.scrollView.contentInset.top, 0, 0, 0);
//    self.webView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.webView.scrollView.contentInset.top);
}

- (WKWebView *)webView
{
    if (!_webView)
    {
//        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.webConfig];
        _webView = [WKWebView new];
        _webView.ba_web_isAutoHeight = YES;
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        BAKit_WeakSelf
        [_webView ba_web_initWithDelegate:weak_self.webView uIDelegate:weak_self.webView];
        
        _webView.backgroundColor = BAKit_Color_Yellow_pod;
        _webView.userInteractionEnabled = false;
        
        self.webView.ba_web_getCurrentHeightBlock = ^(CGFloat currentHeight) {

            BAKit_StrongSelf
            self.cell_height = currentHeight;
            NSLog(@"html 高度2：%f", currentHeight);

            if (self.WebLoadFinish)
            {
                self.WebLoadFinish(self.cell_height);
            };
        };

        
//        self.webView.ba_web_didFinishBlock = ^(WKWebView * _Nonnull webView, WKNavigation * _Nonnull navigation) {
//            
//            BAKit_StrongSelf
//            
//            CGRect frame = webView.frame;
////            frame.size.height = 1;
////            webView.frame = frame;
//            CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
//            frame.size = fittingSize;
//            NSLog(@"html size:：%@", NSStringFromCGSize(fittingSize));
//            self.webView.frame = frame;
//            
//            self.cell_height = fittingSize.height;
//            
//            if (self.WebLoadFinish)
//            {
//                self.WebLoadFinish(self.cell_height);
//            };
//
//        };
        
        [self.contentView addSubview:_webView];
    }
    return _webView;
}

//- (WKWebViewConfiguration *)webConfig
//{
//    if (!_webConfig) {
//        
//        // 创建并配置WKWebView的相关参数
//        // 1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
//        // 2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
//        // 3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
//        
//        _webConfig = [[WKWebViewConfiguration alloc] init];
//        _webConfig.allowsInlineMediaPlayback = YES;
//        
//        //        _webConfig.allowsPictureInPictureMediaPlayback = YES;
//        
//        // 通过 JS 与 webView 内容交互
//        // 注入 JS 对象名称 senderModel，当 JS 通过 senderModel 来调用时，我们可以在WKScriptMessageHandler 代理中接收到
//        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//        //        [userContentController addScriptMessageHandler:self name:@"BAShare"];
//        _webConfig.userContentController = userContentController;
//        
//        // 初始化偏好设置属性：preferences
//        _webConfig.preferences = [WKPreferences new];
//        // The minimum font size in points default is 0;
//        _webConfig.preferences.minimumFontSize = 40;
//        // 是否支持 JavaScript
//        _webConfig.preferences.javaScriptEnabled = YES;
//        // 不通过用户交互，是否可以打开窗口
//        _webConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
//    }
//    return _webConfig;
//}

@end
