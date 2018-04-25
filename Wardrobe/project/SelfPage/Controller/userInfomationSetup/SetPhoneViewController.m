//
//  SetPhoneViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/15.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "SetPhoneViewController.h"



@interface SetPhoneViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@property (weak, nonatomic) IBOutlet UIButton *finishButton;

//
//- (IBAction)codeSendButtonAction:(id)sender;
//- (IBAction)bindingPhoneButtonAction:(id)sender;

@end

@implementation SetPhoneViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed=YES;
    self.codeButton.userInteractionEnabled = NO;
    [self.codeButton setTitleColor:Color_999 forState:UIControlStateNormal];
    self.finishButton.userInteractionEnabled = NO;
    self.finishButton.backgroundColor = Color_999;
    [self _loadContent];
    
}

-(void)_loadContent{
    _phoneLabel.borderStyle = UITextBorderStyleNone;
    _codeLabel.borderStyle = UITextBorderStyleNone;
    _passwordLabel.borderStyle = UITextBorderStyleNone;
    
    [_phoneLabel becomeFirstResponder];
    
    _phoneLabel.delegate = self;
    _codeLabel.delegate = self;
    _passwordLabel.delegate = self;
    
    [_phoneLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_codeLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_passwordLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
        switch (_pagetype) {
            case UserSetTelephone:
                self.title = @"绑定手机号";
                self.phoneLabel.keyboardType = UIKeyboardTypePhonePad;
                self.codeLabel.keyboardType = UIKeyboardTypePhonePad;
                self.passwordLabel.placeholder = @"为了账户安全，设置一个密码";
                self.finishButton.titleLabel.text = @"确认";
                
                break;
            case UserChangePhone:
                self.title = @"修改绑定手机号";
                self.phoneLabel.keyboardType = UIKeyboardTypePhonePad;
                self.codeLabel.keyboardType = UIKeyboardTypePhonePad;
                self.passwordLabel.placeholder = @"输入登录密码";
                self.finishButton.titleLabel.text = @"确认";
                break;
            case UserChangePassword:
                self.title = @"修改密码";
                self.codeButton.hidden = YES;
                self.phoneLabel.keyboardType = UIKeyboardTypeDefault;
                self.codeLabel.keyboardType = UIKeyboardTypeDefault;
                self.phoneLabel.placeholder = @"请输入原密码";
                self.codeLabel.placeholder = @"请输入新密码";
                self.codeLabel.secureTextEntry = YES;
                self.passwordLabel.placeholder = @"请确认新密码";
                self.finishButton.titleLabel.text = @"确认";
                
                break;
            default:
                break;
        }
}
-(void)returnKey:(UILabel *)label{
    [label endEditing:YES];
}

#pragma mark -
#pragma mark - textfile delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneLabel resignFirstResponder]; //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_phoneLabel == textField){
        self.phoneLabel.text = [self.phoneLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
        if (_pagetype == UserChangePassword) {
            if ([self.phoneLabel.text length] > 16)  textField.text = [self.phoneLabel.text substringToIndex:16];
        }else{
            if ([self.phoneLabel.text length] > 11)  textField.text = [self.phoneLabel.text substringToIndex:11];
        }
    }
    else if (_codeLabel == textField){
        self.codeLabel.text = [self.codeLabel.text stringByReplacingCharactersInRange:range withString:string]; ;//得到输入框的内容
        if (_pagetype == UserChangePassword) {
            if ([self.codeLabel.text length] > 16)  textField.text = [self.codeLabel.text substringToIndex:16];
        }else{
           if ([self.codeLabel.text length] > 8)  textField.text = [self.codeLabel.text substringToIndex:8];
        }
    }else{
        self.passwordLabel.text = [self.passwordLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
        if ([self.passwordLabel.text length] > 16)  textField.text = [self.passwordLabel.text substringToIndex:16];
    }
    
    NSLog(@"self.phoneLabel.text.length:%lu.....self.codeLabel.text.length:%lu.......self.passwordLabel.text:%lu",self.phoneLabel.text.length,self.codeLabel.text.length,self.passwordLabel.text.length);
    //判断修改登录按钮的颜色
    if (_pagetype  == UserChangePassword) {
        if (self.phoneLabel.text.length >= 6 && self.codeLabel.text.length >= 6 && self.passwordLabel.text.length >= 6 ) {
            self.finishButton.backgroundColor = BaseRedColor;
            self.finishButton.userInteractionEnabled = YES;
            
        }else{
            self.finishButton.userInteractionEnabled = NO;
            self.finishButton.backgroundColor = Color_999;
        }
    }else{
        //修改codebutton状态
        if (self.phoneLabel.text.length != 11) {
            [self.codeButton setTitleColor:Color_999 forState:UIControlStateNormal];
            self.codeButton.userInteractionEnabled = NO;
        }else{
            [self.codeButton setTitleColor:BaseRedColor forState:UIControlStateNormal];
            self.codeButton.userInteractionEnabled = YES;
        }
        
        if (self.phoneLabel.text.length == 11 && self.codeLabel.text.length >= 6 && self.passwordLabel.text.length >= 6 ) {
            self.finishButton.backgroundColor = BaseRedColor;
            self.finishButton.userInteractionEnabled = YES;
        }else{
            self.finishButton.userInteractionEnabled = NO;
            self.finishButton.backgroundColor = Color_999;
        }
    }
    
    return NO;
}

#pragma mark -
#pragma mark - button click
- (IBAction)codeSendButtonAction:(id)sender {
    /*
     类型：
     USER_REG(注册)
     MODIFY_OR_FIND_PASS(修改/找回密码)
     SMS_LOGIN(验证码登录)
     MODIFY_PHONE(修改手机号)
     WITHDRAWALS(提现)*/
    
    //判断类型为“修改手机号”
    NSString *type = @"MODIFY_PHONE";
    //判断手机号位数及第一位数字
    if ([self.phoneLabel.text length] < 11 || ![[self.phoneLabel.text substringToIndex:1] isEqualToString:@"1"]) {
        UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:@"手机号错误" message:@"请检查手机号格式" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    NSDictionary *params = @{@"phone":self.phoneLabel.text,
                             @"type":type
                             };
    [XLAFnetworking postWithURL:sendPhoneCode params:params progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(NSDictionary* response) {
        if ([response[@"status"]boolValue]) {
            //按钮倒计时
            [self openCountdown:_codeButton];
            NSLog(@"——————————————————————————验证码发送成功————————————————————%@",response);
        }else{
            NSLog(@"——————————————————————————验证码发送失败%@——————————————————————————",response);

            [self presentViewController:[XLAlertController alertWithTitle:nil WithMessage:response[@"msg"]] animated:YES completion:nil];
        }
    } failBlock:^(NSError *error) {
        NSLog(@"——————————————————————————验证码网络请求失败%@——————————————————————————",error);

    }];
}



- (IBAction)bindingPhoneButtonAction:(id)sender {
    if (_pagetype == UserChangePassword) {
        if (self.phoneLabel.text.length < 6 || self.codeLabel.text.length < 4) {
            [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请输入完整信息(密码长度至少为6位)"] animated:YES completion:nil];
            return;
        }
        
    }else{
        if (self.phoneLabel.text.length < 11) {
            [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请输入完整信息(手机号长度为11位)"] animated:YES completion:nil];
            return;
        }
        if (self.codeLabel.text.length < 4) {
            [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请输入正确验证码"] animated:YES completion:nil];
            return;
        }
        
    }
    if (self.passwordLabel.text.length < 6 || self.passwordLabel.text.length > 16){
        [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请输入完整信息(密码为6～16位)"] animated:YES completion:nil];
        return;
    }
    
    
    NSLog(@"phoneNum:%@",self.phoneLabel.text);
    NSLog(@"codeLabel:%@",self.codeLabel.text);
    NSLog(@"setPasswordLabel:%@",self.passwordLabel.text);
    
    NSString *url;
    NSDictionary *pamas;
    switch (_pagetype) {
        case UserSetTelephone:
//#warning 绑定电话号码。。。。
            url = BindPhone;
            pamas = @{@"phone":self.phoneLabel.text,@"smsCode":self.codeLabel.text,@"password":self.passwordLabel.text};
            break;
        case UserChangePhone:
            url = ChangePhone;
            pamas = @{@"phone":self.phoneLabel.text,@"smsCode":self.codeLabel.text,@"password":self.passwordLabel.text};
            break;
        case UserChangePassword:
            url = ChangePassword;
            if (self.codeLabel.text != self.passwordLabel.text) {
                [self presentViewController:[XLAlertController alertWithTitle:@"密码错误" WithMessage:@"两次密码输入不相同，请重新输入"] animated:YES completion:nil];
            }else pamas = @{@"oldPassword":self.phoneLabel.text,@"password":self.passwordLabel.text};

            break;
            
        default:
            break;
    }
    
    [XLAFnetworking postWithURL:url params:pamas progressBlock:nil successBlock:^(NSDictionary *response) {
        if (![response[@"status"]boolValue]) {
            NSLog(@"——————————————————————————注册或找回密码不成功 ————————————————————————");
            [self presentViewController:[XLAlertController alertWithTitle:nil WithMessage:response[@"msg"]] animated:YES completion:nil];
            
        }else{
            NSLog(@"——————————————————————————修改手机号或修改密码成功 ————————————————————————status:%@&msg:%@&code:%@",response[@"status"],response[@"msg"],response[@"code"]);
            if (_pagetype == UserSetTelephone || _pagetype == UserChangePhone) {
//                self.ChangeOrSetPhoneBlock(self.phoneLabel.text);
                // 读取账户
                NSMutableDictionary *userInfoDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"]mutableCopy];
                [userInfoDic setValue:self.phoneLabel.text forKey:@"phone"];
                [[NSUserDefaults standardUserDefaults]setObject:userInfoDic forKey:@"userInfoDic"];
                
//                [self.delegate SetPhoneBack:self.phoneLabel.text];
                
            }
            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:@"修改成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (_pagetype == UserChangePassword) {
                        NSNotification *notification = [NSNotification notificationWithName:@"exitLoginNotification" object:nil];
                        [[NSNotificationCenter defaultCenter]postNotification:notification];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }]];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    } failBlock:^(NSError *error) {
        
    }];
}


#pragma mark -
#pragma mark - 一些动画效果 （倒计时、弹框）
// 开启倒计时效果
-(void)openCountdown:(UIButton *)sender{
    __block NSInteger time = 59; //倒计时时间
    //    [sender setTitle:@"重新发送" forState:UIControlStateNormal];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    //设置按钮的样式
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_codeButton setTitleColor:BaseRedColor forState:UIControlStateNormal];
                [_codeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                _codeButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [_codeButton setTitle:[NSString stringWithFormat:@"%.2dS", seconds] forState:UIControlStateNormal];
                [_codeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                _codeButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
@end
