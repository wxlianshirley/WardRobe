//
//  NowChangePhoneOrPsdViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/2/6.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "NowChangePhoneOrPsdViewController.h"
#import "SelfViewController.h"
#import "InfomationViewController.h"
#import "ChangePhoneOrPassworldViewController.h"
#import "InputOldPsdViewController.h"
@interface NowChangePhoneOrPsdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bingdingTelephoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *firstTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *secondTextfiled;

@property (weak, nonatomic) IBOutlet UIButton *currentButton;

@end

@implementation NowChangePhoneOrPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setContent];
    
    [self _changeBackButtonAction];
}

-(void)_changeBackButtonAction{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in array) {
        if ([vc isKindOfClass:[ChangePhoneOrPassworldViewController class]]) {
            [array removeObject:vc];
            break;
        }
    }
    for (UIViewController *vc in array){
        if ([vc isKindOfClass:[InputOldPsdViewController class]]) {
            [array removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = array;
    
}


-(void)_setContent{
    _firstTextfiled.borderStyle = UITextBorderStyleNone;
    _secondTextfiled.borderStyle = UITextBorderStyleNone;
    
    [_firstTextfiled becomeFirstResponder];
    
    //修改验证码按钮的颜色
    [self.codeButton setTitleColor:Color_BBB forState:UIControlStateNormal];
    self.codeButton.userInteractionEnabled = NO;
    //修改确认按钮的颜色
    self.currentButton.backgroundColor = Color_BBB;
    self.currentButton.userInteractionEnabled = NO;
    
    [_firstTextfiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_secondTextfiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (_ischangeTelephone) {
        self.title = @"修改手机号";
        self.bingdingTelephoneLabel.text = @"2.绑定新手机";
        _firstTextfiled.placeholder = @"输入需要新绑定的手机号";
        _secondTextfiled.placeholder = @"输入短信验证码";
        _firstTextfiled.keyboardType =  UIKeyboardTypeNumberPad;
        _secondTextfiled.keyboardType =  UIKeyboardTypeNumberPad;
    }else{
        self.title = @"修改密码";
        self.bingdingTelephoneLabel.text = @"2.设置新密码";
        self.codeButton.hidden = YES;
        _firstTextfiled.placeholder = @"设置6～16位数的新密码";
        _secondTextfiled.placeholder = @"再次输入新密码";
        _firstTextfiled.secureTextEntry = YES;
        _secondTextfiled.secureTextEntry = YES;
    }
}



#pragma mark -
#pragma mark - textfile delegate
//取消第一响应者
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_firstTextfiled resignFirstResponder];
    [_secondTextfiled resignFirstResponder];
}



-(void)textFieldDidChange:(UITextField *)textField{
    if (_ischangeTelephone) {
        //修改手机号
        if (textField == self.firstTextfiled) {
            if ([self.firstTextfiled.text length] > 11) {//修改手机号的第一行：新手机号
                textField.text = [self.firstTextfiled.text substringToIndex:11];
            }
            if (self.firstTextfiled.text.length == 11) {//修改手机号的第一行：发送验证码
                //修改验证码按钮的颜色
                [self.codeButton setTitleColor:BaseRedColor forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = YES;
            }
            
        }else{//修改手机号的第二行：验证码
            if ([self.secondTextfiled.text length] > 11)  textField.text = [self.secondTextfiled.text substringToIndex:11];
        }
    }else{
        //修改密码
        if (textField == self.firstTextfiled) {
            if ([self.firstTextfiled.text length] > 16)  textField.text = [self.firstTextfiled.text substringToIndex:16];
        }else{
            if ([self.secondTextfiled.text length] > 16)  textField.text = [self.secondTextfiled.text substringToIndex:16];
        }
    }
    
    
    
    //修改下一步按钮状态
    if (_ischangeTelephone) {
        if (self.firstTextfiled.text.length == 11 && self.secondTextfiled.text.length >= 6) {
            self.currentButton.backgroundColor = BaseRedColor;
            self.currentButton.userInteractionEnabled = YES;
        }else{
            self.currentButton.userInteractionEnabled = NO;
            self.currentButton.backgroundColor = Color_BBB;
        }
    }else{
        if (self.firstTextfiled.text.length >= 6 && self.secondTextfiled.text.length >= 6) {
            self.currentButton.backgroundColor = BaseRedColor;
            self.currentButton.userInteractionEnabled = YES;
        }else{
            self.currentButton.userInteractionEnabled = NO;
            self.currentButton.backgroundColor = Color_BBB;
        }
    }
    
    
}

#pragma mark - Button Action
//返回按钮
-(void)backButtonAction{
    //回到信息页面
    
}
//获取验证码按钮
- (IBAction)codeButtonAction:(id)sender {
    /*
     类型：
     USER_REG(注册)
     MODIFY_OR_FIND_PASS(修改/找回密码)
     SMS_LOGIN(验证码登录)
     MODIFY_PHONE(修改手机号)
     WITHDRAWALS(提现)*/
    
    //判断类型为“修改手机号”
    NSString *type = _ischangeTelephone ?  @"MODIFY_PHONE":@"MODIFY_OR_FIND_PASS";
    
    //判断手机号位数及第一位数字
    if (![XLJudgeTheempty checkPhone:self.firstTextfiled.text ]) {
        [self.view makeToast:@"请检查手机号格式" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    NSDictionary *params = @{@"phone":self.firstTextfiled.text,
                             @"type":type
                             };
    /*
    [XLAFnetworking postWithURL:sendPhoneCode params:params progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(NSDictionary* response) {
        if ([response[@"status"]boolValue]) {
            //按钮倒计时
//            [self openCountdown:_codeButton];
            [ButtonCountDown countDownButton:_codeButton withTitle:@"重新发送" withBackgroundColor:BaseRedColor withCountDownTime:59];
            NSLog(@"——————————————————————————验证码发送成功————————————————————%@",response);
        }else{
            [self.view makeToast:response[@"msg"] duration:2.0 position:CSToastPositionCenter];
        }
    } failBlock:^(NSError *error) {
        NSLog(@"——————————————————————————验证码网络请求失败%@——————————————————————————",error);
    }];*/
}

//确定修改按钮
- (IBAction)currentButtonAction:(id)sender {
    
    if (!_ischangeTelephone) {
        if (![self.firstTextfiled.text isEqualToString: self.secondTextfiled.text]) {
            [self.view makeToast:@"两次输入密码不一致，请检查后重试" duration:2.0 position: CSToastPositionCenter];
            return;
        }
    }
    //++++++++++++++++++++++++++++++++++++++发送修改手机号或者修改密码的网络请求+++++++++++++++++++++++++++++++++++++++++++
    
    //对code和oldpwd进行判空
    self.oldPwdNum = self.oldPwdNum ? self.oldPwdNum : @"";
    self.codeNum = self.codeNum ? self.codeNum : @"";
    
    NSString *url;
    NSDictionary *parmas;
    if (self.ischangeTelephone) {
        //************************************修改手机号**************************************
        //验证码或者旧密码类型
        NSString *type = self.oldPwdNum.length>1 ? @"PWD" : @"SMS";
//        url = ChangePhone;
        parmas = @{@"type": type,@"phone":self.firstTextfiled.text,@"smsCode":self.secondTextfiled.text,@"password":self.oldPwdNum,@"oldPhoneSmsCode":self.codeNum};
        NSLog(@"**********parmars*****%@",parmas);
    }else{
        //************************************修改密码**************************************
        NSString *type = self.oldPwdNum.length>1 ? @"PWD" : @"SMS";
//        url = ChangePassword;
        parmas = @{@"type": type,@"password":self.secondTextfiled.text,@"oldPassword":self.oldPwdNum,@"smsCode":self.codeNum};
    }
    [XLAFnetworking postWithURL:url params:parmas progressBlock:nil successBlock:^(NSDictionary *response) {
        if ([response[@"status"]boolValue]) {
            [self.view makeToast:@"修改成功" duration:2.0 position:CSToastPositionCenter];
            if (self.ischangeTelephone) {
                // 读取账户 将手机号存入userdefualt和 回调到个人信息页面
                NSMutableDictionary *userInfoDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"]mutableCopy];
                [userInfoDic setValue:self.firstTextfiled.text forKey:@"phone"];
                [[NSUserDefaults standardUserDefaults]setObject:userInfoDic forKey:@"userInfoDic"];
                
                //成功后回到信息页面
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[InfomationViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }

            }else{
                //创建
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"telephone"];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults removeObjectForKey:@"expire"];
                [userDefaults removeObjectForKey:@"token"];
                [userDefaults removeObjectForKey:@"userInfoDic"];
                
                //成功后回到个人中心页面
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[SelfViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
           
        }else{
            [self.view makeToast:response[@"msg"] duration:2.0 position:CSToastPositionCenter];
        }
        
    } failBlock:^(NSError *error) {
        
    }];
    
   
    
   
}

@end
