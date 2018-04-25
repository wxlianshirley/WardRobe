//
//  SelfViewTableViewCell_one.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/14.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfViewTableViewCell_one : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property(nonatomic,copy) void(^QuickCachButtonClickBlock)(void);//快速提现的回调
@property(nonatomic,copy) void(^FriendInvitationButtonClickBlock)(void);//好友邀请的回调
@property(nonatomic,copy) void(^MyOrderButtonClickBlock)(void);//我的订单的回调
@property(nonatomic,copy) void(^ProfitDetailsButtonClickBlock)(void);//收益明细的回调

@end
