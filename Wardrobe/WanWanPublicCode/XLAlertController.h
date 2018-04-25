//
//  XLAlertController.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/28.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLAlertController : NSObject
typedef void(^XLResponseSuccessBlock) (NSDictionary* response);//显示完成的回调

//只有确定按钮的弹框
+(UIAlertController *)alertWithTitle:(NSString *)title WithMessage :(NSString *)message;

//1秒消失的弹框
+(UIAlertController *)OneSecondsalertWithTitle:(NSString *)title WithMessage :(NSString *)message WithDismissView:(XLResponseSuccessBlock*)Block;

@end
