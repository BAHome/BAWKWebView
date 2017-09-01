//
//  BACell.h
//  BAWKWebView
//
//  Created by boai on 2017/6/30.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKit_WebView.h"

@class WebVIewModel;
@interface BACell : UITableViewCell

@property(nonatomic, strong) WebVIewModel *model;
@property(nonatomic, strong) WKWebView *webView;

@property(nonatomic, assign) CGFloat cell_height;
@property(nonatomic, copy) void (^WebLoadFinish)(CGFloat cell_h);

+ (id)ba_creatCellWithTableView:(UITableView *)tableView;


@end
