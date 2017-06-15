//
//  BAAlertController.h
//  BAAlertController
//
//  Created by boai on 2017/6/5.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef BAAlertController_h
#define BAAlertController_h

#import "UIAlertController+BAKit.h"
#import "NSObject+BARunTime.h"
#import "NSMutableAttributedString+BAKit.h"

#pragma mark - NotiCenter
#define BAKit_NotiCenter [NSNotificationCenter defaultCenter]

#pragma mark - 简单警告框
/*! view 用 BAKit_ShowAlertWithMsg */
#define BAKit_ShowAlertWithMsg(msg) [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:(msg) delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil] show];
/*! VC 用 BAKit_ShowAlertWithMsg */
#define BAKit_ShowAlertWithMsg_ios8(msg) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确 定" style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:sureAction];\
[self presentViewController:alert animated:YES completion:nil];

CG_INLINE UIColor *
BAKit_Color_RGBA(u_char r,u_char g, u_char b, u_char a) {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

#define BAKit_Color_Translucent    [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:0.5f]
#define BAKit_Color_White          [UIColor whiteColor]
#define BAKit_Color_Clear          [UIColor clearColor]
#define BAKit_Color_Black          [UIColor blackColor]
#define BAKit_Color_Red            [UIColor redColor]
#define BAKit_Color_Green          [UIColor greenColor]
#define BAKit_Color_Yellow         [UIColor yellowColor]
#define BAKit_Color_Orange         [UIColor orangeColor]

#define BAKit_Color_gray11         BAKit_Color_RGBA(248, 248, 248, 1.0)


/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BAAlertController
 
 最新更新时间：2017-06-05 【倒叙】
 最新Version：【Version：1.0.0】
 更新内容：
 1.0.0.1、普通的 UIAlertController-alert，可以自由设置按钮数量、按钮颜色
 1.0.0.2、普通的 UIAlertController-alert，可以自由设置按钮数量、按钮颜色【多按钮样式，颜色数组和title数组个数不等】
 1.0.0.3、普通的 带 textField 的 UIAlertController-alert，可添加一个或者多个 textField
 1.0.0.4、NSMutableAttributedString 的UIAlertController-alert，可以自由设置 NSMutableAttributedString（title、message）按钮数量、按钮颜色
 1.0.0.5、普通的 UIAlertController-actionSheet，可以自由设置按钮数量、按钮颜色
 1.0.0.6、NSMutableAttributedString 的UIAlertController-actionSheet，可以自由设置 NSMutableAttributedString（title、message）按钮数量、按钮颜色
 1.0.0.7、完美适配 iPhone 和 iPad 版本
 1.0.0.8、理论完全兼容现有 iOS 8 以上系统版本
 
 */

#endif /* BAAlertController_h */
