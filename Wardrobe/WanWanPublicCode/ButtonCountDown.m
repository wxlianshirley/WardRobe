//
//  ButtonCountDown.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/2/7.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "ButtonCountDown.h"

@implementation ButtonCountDown
+(void)countDownButton:(UIButton *)sender withTitle:(NSString *)title withBackgroundColor:(UIColor* )color withCountDownTime:(NSInteger)timeNum{
    __block NSInteger time = timeNum; //倒计时时间
    
    //    [sender setTitle:@"重新发送" forState:UIControlStateNormal];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    //设置按钮的样式
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitleColor:color forState:UIControlStateNormal];
                [sender setTitle:title forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [sender setTitle:[NSString stringWithFormat:@"%.2dS", seconds] forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


@end
