//
//  SelfViewTableViewCell_Zero.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/14.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfViewTableViewCell_Zero : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userimageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *todayGoldLabel;//今日金币
@property (weak, nonatomic) IBOutlet UILabel *surplusGoldLabel;//剩余未兑换金币
@property (weak, nonatomic) IBOutlet UILabel *totalGoldLabel;//合计赚取的金币
@property(nonatomic)BOOL ishideLoginBtn;




@property(nonatomic,copy) void(^SystemSetupButtonClickBlock)(void);//系统设置的回调

@property(nonatomic,copy) void(^InfomationSetupButtonClickBlock)(void);//信息设置的回调

@property(nonatomic,copy) void(^LoginButtonClickBlock)(void);//登录按钮的回调
@end
