//
//  XLJudgeTheempty.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/8.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "XLJudgeTheempty.h"

@implementation XLJudgeTheempty
#pragma  mark - 判空


+(BOOL)isJudgetheemptyString:(NSString *)valueString{
    if ([valueString isKindOfClass:[NSString class]] && ![valueString isKindOfClass:[NSNull class]] && ![valueString isEqualToString:@""] && valueString != nil) {
        return NO;
    }else return YES;
}

+(NSString *)Judgetheempty:(NSString *)valueString{
    if ([valueString isKindOfClass:[NSString class]] && ![valueString isKindOfClass:[NSNull class]] && ![valueString isEqualToString:@""] && valueString != nil) {
        return valueString;
    }else return @"";
}

//删除字典的空箱
+ (NSDictionary *)deleteNull:(NSDictionary *) dic{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in dic.allKeys) {
        
        if ([[dic objectForKey:keyStr] isEqual:[NSNull null]]) {
            
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            
            [mutableDic setObject:[dic objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}



#pragma mark --判断手机号合法性

+ (BOOL)checkPhone:(NSString *)phoneNumber

{
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    if (!isMatch)
    {
        return NO;
    }
    return YES;
}

#pragma mark 判断邮箱

+ (BOOL)checkEmail:(NSString *)email{
    
    //^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w{2,3}){1,3})$
    
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTest evaluateWithObject:email];
    
}

@end
