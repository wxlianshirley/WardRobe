//
//  common.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/2.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#ifndef common_h
#define common_h

#define ks_width  [UIScreen mainScreen].bounds.size.width
#define ks_height  [UIScreen mainScreen].bounds.size.height
#define padding 10
#define navigation_height 44
#define statuBar_height 20
#define KUserDefault [NSUserDefaults standardUserDefaults]

//颜色
#define BaseRedColor [UIColor colorWithRed:212/255.0 green:34/255.0 blue:28/255.0 alpha:1.0] //主红色
#define bottomBGColor [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]
#define Color_F2F2F2 [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0] //f2f2f2
#define Color_999 [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] //999
#define Color_666 [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] //666
#define Color_ccc [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] //cccccc
#define Color_222 [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] //222222
#define Color_Blue [UIColor colorWithRed:0/255.0 green:160/255.0 blue:233/255.0 alpha:1.0] //蓝色:00A0E9
#define Color_BBB [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0] //BBBBBB
#define Color_EEE [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0] //EEEEEE
#define Color_pink [UIColor colorWithRed:255/255.0 green:237/255.0 blue:237/255.0 alpha:1] //提现的粉色
#define Color_orange [UIColor colorWithRed:253/255.0 green:159/255.0 blue:19/255.0 alpha:1] //橙色：fd9f13

//字体
//判断是否iPhoneX
#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//状态栏
#define STATUSBAR_HEIGHT  [UIApplication shareApplication].statrusBarFrame.size.height

//---------------***顶部菜单***---------------------
//每个频道的宽高
#define channelBtn_Height 44
#define channelBtn_Width   60

//编辑菜单页面每个item的宽高
#define itemSize_Height 40
#define itemSize_Width 80

//button font
#define TopMenuButtonFont [UIFont systemFontOfSize: 14.0]

//---------------***新闻列表***---------------------
//新闻列表的位置
#define ViewList_X (channelBtn_Height)
//新闻列表高度
#define ViewList_Height ([UIScreen mainScreen].bounds.size.height - navigation_height - statuBar_height - channelBtn_Height)
//状态栏高度
#define statueBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height



#endif /* common_h */
