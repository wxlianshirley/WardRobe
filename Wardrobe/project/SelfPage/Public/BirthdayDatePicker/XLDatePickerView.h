//
//  XLDatePickerView.h
//  qqqq
//
//  Created by WXL on 2018/1/1.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLDatePickerView : UIView


@property(nonatomic,copy)void (^SelectBirthDayDateBlock)(NSString *);//日期选择的回调


@end
