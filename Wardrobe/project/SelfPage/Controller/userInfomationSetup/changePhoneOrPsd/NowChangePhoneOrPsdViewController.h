//
//  NowChangePhoneOrPsdViewController.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/2/6.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneNumChangeDelegate <NSObject>

@required
-(void)SetPhoneBack:(NSString*)PhoneNumber;//编辑按钮
@end


@interface NowChangePhoneOrPsdViewController : UIViewController
@property(nonatomic,assign)BOOL ischangeTelephone;
@property(nonatomic,copy)NSString *codeNum;
@property(nonatomic,copy)NSString *oldPwdNum;

@end
