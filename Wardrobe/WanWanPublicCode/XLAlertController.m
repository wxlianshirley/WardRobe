//
//  XLAlertController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/28.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "XLAlertController.h"

@implementation XLAlertController



+(UIAlertController *)alertWithTitle:(NSString *)title WithMessage :(NSString *)message{
    UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    return alertVC;
}

+(UIAlertController *)OneSecondsalertWithTitle:(NSString *)title WithMessage :(NSString *)message WithDismissView:(XLResponseSuccessBlock*)Block{
    
    UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(OneSecondsDisappearAction:) userInfo:@[alertVC] repeats:NO];
    
    return alertVC;
}


+(void)OneSecondsDisappearAction:(NSTimer *)timer{
    UIAlertController *alert = [timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}





@end
