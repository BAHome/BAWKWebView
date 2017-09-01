//
//  ViewController3.m
//  BAWKWebView
//
//  Created by boai on 2017/6/30.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "ViewController3.h"
#import "BAKit_WebView.h"
#import "BACell.h"
#import "WebVIewModel.h"

static NSString * const htmlString = @"<div class=\"sanju\">\n\t<div class=\"sanju-basic\" style=\"color: #095634;font-size:32px;\">\n\t\t<ul class=\"ul\" style=\"list-style-type: none;\">\n\t\t\t<li class=\"left\" style=\"float: left;width: 50%\"><span>| 品名：海南荔枝王</span></li>\n\t\t\t<li class=\"left\" style=\"float: left;width: 49%\"><span>| 产地：海南省海口市</span></li>\n\t\t</ul>\n\t\t<ul class=\"ul\" style=\"list-style-type: none;\">\n\t\t\t<li class=\"left\" style=\"float: left;width: 50%\"><span>| 规格：约1.5kg</span></li>\n\t\t\t<li class=\"left\" style=\"float: left;width: 49%\"><span>| 储存：冷藏保存，3天</span></li>\n\t\t</ul>\n\t\t<!-- <div class=\"left\" style=\"float: left;width: 50% \">\n\t\t\t<p><span>| 品名：海南荔枝王</span></p>\n\t\t\t<p><span>| 产地：海南省海口市</span></p>\n\t\t</div>\n\t\t<div class=\"left\" style=\"color:#095634;float: left;\">\n\t\t\t<p><span>| 规格：约1.5kg</span></p>\n\t\t\t<p><span>| 储存：冷藏保存，3天</span></p>\n\t\t</div> -->\n\t</div>\n\t<div class=\"clear\" style=\"clear: both;\"></div>\n\t<div class=\"sanju-deliver\" style=\"color: #095634;font-size:32px;\">\n\t\t<h2 class=\"center\" style=\"text-align: center\">配送须知</h2>\n\t\t<ul class=\"ul\" style=\"list-style-type: none;\">\n\t\t\t<li class=\"left\" style=\"float: left;width: 25%\"><span><img  src=\"http://demo2.zjsjtz.com/public/images/78/6d/5a/fc1bbf3c2ca6548bbd3f52b9278b58eb36ee2063.jpg?1498535322#h\" style=\"width: 30px;display: inline;\" alt=\"\" />配送武汉市</span></li>\n\t\t\t<li class=\"left\" style=\"float: left;width: 25%\"><span><img src=\"http://demo2.zjsjtz.com/public/images/7c/e6/ad/70646709af72d2dbcada14cc31ddd0d6d2435c99.jpg?1498535379#h\" style=\"width: 30px;display: inline;\" alt=\"\" />实付满88包邮</span></li>\n\t\t\t<li class=\"left\" style=\"float: left;width: 25%\"><span><img src=\"http://demo2.zjsjtz.com/public/images/6e/24/93/8134409080e4be6930f8f57fc18a84df33bca8e7.jpg?1498535414#h\" style=\"width: 30px;display: inline;\" alt=\"\" />顺丰冷链配送</span></li>\n\t\t\t<li class=\"left\" style=\"float: left;width: 24%\"><span><img src=\"http://demo2.zjsjtz.com/public/images/6e/24/93/8134409080e4be6930f8f57fc18a84df33bca8e7.jpg?1498535414#h\" style=\"width: 30px;display: inline;\" alt=\"\" />他人挺好</span></li>\n\t\t</ul>\n\t\t<ul class=\"ul\" style=\"list-style-type: none;\">\n\t\t\t<li class=\"left\" style=\"float: left;width: 50%\"><span>| 下单时间：当日18:00前</span></li>\n\t\t\t<li class=\"left\" style=\"float: left;width: 49%\"><span>| 送达时间：次日18:00前</span></li>\n\t\t</ul>\n\t</div>\n\n\t<div class=\"sanju-hint\" style=\"color: #095634;font-size:32px;padding: 5px\">\n\t\t<h2 class=\"center\" style=\"text-align: center\">温馨提示</h2>\n\t\t<p><span style=\"color:#999999;line-height: 1em\">回宿舍睡觉睡觉四岁斤斤计较。结局就是今生今世是你内心的计算机黑丝深刻见解解决问题了。我的心里只有我一个人在一起我说不会离开的背影？！一切又名海洋生物。我会好好先生？！一切皆是虚妄？一个人来看一下有没有觉得你会选择错误中国人在意我要不能说说说是什么的时候你们在家看看看看着一起我想说了我会告诉你们一个人在家好无聊呀。我想</span><span style=\"color:#999999;\"></span></p>\n\t</div>\n</div>\n";;
static NSString * const htmlString1 = @"<img style=\"width:100%;\" src=\"http://demo2.zjsjtz.com/public/images/1d/f9/c6/c2db1b3692bfc34c2095ddd4bd9647f3bd6795e9.jpg?1498013107#h\" alt=\"\" />";

@interface ViewController3 ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray <WebVIewModel *>*dataArray;

@property(nonatomic, assign) CGFloat cell_h;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
//    self.title = @"BAGridView";
    self.view.backgroundColor = BAKit_Color_White_pod;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BACell *cell = [BACell ba_creatCellWithTableView:tableView];
    
    WebVIewModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    
    cell.WebLoadFinish = ^(CGFloat cell_h) {

        if (model.height != cell_h)
        {
            model.height = cell_h;
            [tableView reloadData];
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebVIewModel *model = self.dataArray[indexPath.row];
   
    return model.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 64, BAKit_SCREEN_WIDTH, BAKit_SCREEN_HEIGHT - 64);
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = BAKit_Color_Gray_11_pod;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSMutableArray <WebVIewModel *>*)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[].mutableCopy;
        
//        NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.html", @"BAHome2"] ofType:nil];
//        
//        NSString *HTMLString = [NSString stringWithContentsOfFile:htmlPath
//                                                         encoding:NSUTF8StringEncoding
//                                                                error:nil];
        for (int i = 0; i < 2; i++)
        {
            WebVIewModel *model = [[WebVIewModel alloc]init];
            model.contentHtml = htmlString;
            model.height = 100;
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (void)dealloc
{
//    [BAKit_NotiCenter removeObserver:self];
}

@end
