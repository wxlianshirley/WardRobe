//
//  XLCurrentMomentTime.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/8.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "XLCurrentMomentTime.h"

@implementation XLCurrentMomentTime

/**
 当前时间

 @return CurrectTime
 */
+(NSDateComponents *)_loadCurrectTime{
    //    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *nowdate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags =NSYearCalendarUnit |NSMonthCalendarUnit |NSDayCalendarUnit |NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:nowdate];
    return comps;
    
}


/**
 显示的文字（刚刚、今天、昨天、一周前、一月前）

 @param dateString 需要转换的文字,格式必须与dataFormat一致
 @param dateFormat 格式为：yyyy-MM-dd 或 yyyy-MM-dd HH:mm:ss
 @return 显示的文字（刚刚、今天、昨天、一周前、一月前）
 */
+ (NSString *)formateDate:(NSString *)dateString withDateFormatter:(NSString *)dateFormat
{
    @try {
        // ------实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:dateFormat];//这里的格式必须和DateString格式一致
        NSDate * nowDate = [NSDate date];
        // ------将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        // ------取当前时间和转换时间两个日期对象的时间间隔
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        //        NSLog(@"time----%f",time);
        // ------再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = [[NSString alloc] init];
        if (time<=60) {  //1分钟以内的
            dateStr = @"刚刚";
        }else if(time<=60*60){  //一个小时以内的
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        }else if(time<=60*60*24){  //在两天内的
            
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //在同一天
                dateStr = [NSString stringWithFormat:@"今天"/*,[dateFormatter stringFromDate:needFormatDate]*/];
            }else{
                //昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                //在同一年
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
}






@end
