//
//  XLJudgeTheempty.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/8.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLJudgeTheempty : NSObject

+(BOOL)isJudgetheemptyString:(NSString *)valueString;//判断字符串是否为空

+(NSString *)Judgetheempty:(NSString *)valueString;//判断字符串是否为空
+ (NSDictionary *)deleteNull:(NSDictionary *) dic;//删除字典的空箱

+ (BOOL)checkPhone:(NSString *)phoneNumber;//判断手机号合法性
+ (BOOL)checkEmail:(NSString *)email;//判断邮箱
@end
