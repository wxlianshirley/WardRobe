//
//  SetPhoneViewController.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/15.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UserPhoneOrPassWordChange) {
    UserSetTelephone = 0,
    UserChangePhone,
    UserChangePassword
};

@protocol PhoneNumChangeDelegate <NSObject>

@required
-(void)SetPhoneBack:(NSString*)PhoneNumber;//编辑按钮
@end

@interface SetPhoneViewController : UIViewController


@property(nonatomic,assign)UserPhoneOrPassWordChange pagetype;
@property(nonatomic,copy) void(^ChangeOrSetPhoneBlock)(NSString *);//成功的回调

@property (nonatomic, weak) id<PhoneNumChangeDelegate>delegate;

@end
