//
//  LoginViewController.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/8.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ReturnLoginViewToRegisterViewBlock)(void);
//typedef void(^ReturnFindPassWordButtonActionBlock)(void);

@interface LoginViewController : UIViewController

//@property(nonatomic,copy) ReturnLoginViewToRegisterViewBlock  returnLoginViewToRegisterView;//点击注册按钮
//@property(nonatomic,copy) ReturnFindPassWordButtonActionBlock returnFindPassWordButtonAction;//点击找回密码按钮


@property(nonatomic,copy) void(^LoginCurrentToHomePageBlock)(void);//直接登录成功的回调

@property(nonatomic,copy) void(^WeChatLoginButtonClickBlock)(void);//点击微信登录按钮的回调
@property(nonatomic,copy) void(^AlipayLoginButtonClickBlock)(void);//点击支付宝登录按钮的回调

@end

