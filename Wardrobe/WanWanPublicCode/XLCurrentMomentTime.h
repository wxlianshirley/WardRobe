//
//  XLCurrentMomentTime.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/8.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLCurrentMomentTime : NSObject
+(NSDateComponents *)_loadCurrectTime;



/**
 显示的文字（刚刚、今天、昨天、一周前、一月前）
 
 @param dateString 需要转换的文字,格式必须与dataFormat一致
 @param dateFormat 格式为：yyyy-MM-dd 或 yyyy-MM-dd HH:mm:ss
 @return 显示的文字（刚刚、今天、昨天、一周前、一月前）
 */
+ (NSString *)formateDate:(NSString *)dateString withDateFormatter:(NSString *)dateFormat;


@end
