//
//  ButtonCountDown.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/2/7.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonCountDown : NSObject

+(void)countDownButton:(UIButton *)sender withTitle:(NSString *)title withBackgroundColor:(UIColor* )color withCountDownTime:(NSInteger)timeNum;

@end
