//
//  LoginViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/8.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
//#import <WXApi.h>
@interface LoginViewController ()<UITextFieldDelegate>


#pragma mark - 公共按钮
//顶部界面选择
@property (weak, nonatomic) IBOutlet UIView *passwordLoginView;//密码登录页面
@property (weak, nonatomic) IBOutlet UIView *codeLoginButtonView;//验证码登录

@property (weak, nonatomic) IBOutlet UIButton *passWordLoginButton;//密码登录界面
@property (weak, nonatomic) IBOutlet UIButton *codeLoginButton;//验证码登录界面

@property (weak, nonatomic) IBOutlet UIView *passWordLoginLIne;//密码登录界面按钮下方线条
@property (weak, nonatomic) IBOutlet UIView *codeLoginButtonLine;//验证码登录界面按钮下方线条

- (IBAction)passwordLoginButtonAction:(id)sender;//密码登录按钮事件
- (IBAction)codeLoginButtonAction:(id)sender;//验证码登录按钮事件


//
@property(nonatomic,assign)BOOL isCodeLogin;//是否为验证码登录
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;//发送验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *wechatLoginButton;



#pragma mark - 手机号登录
@property (weak, nonatomic) IBOutlet UITextField *telephoneLabel;//手机号（包含密码登录和验证码登录）




#pragma mark - 验证码登录

@property (weak, nonatomic) IBOutlet UITextField *codeLabel;//验证码label
- (IBAction)sendCodeButtonAction:(id)sender;//发送验证码


//底部按钮选择
- (IBAction)registerButtonAction:(id)sender;//注册按钮事件
- (IBAction)findPasswordButtonAction:(id)sender;//找回密码

//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;//登陆按钮

- (IBAction)loginApp:(id)sender;//登陆按钮（包含密码登录和验证码登录）


@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;//密码
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY_alipay;



//微信登录和支付宝登录按钮
- (IBAction)WeChatLoginButtonAction:(id)sender;
- (IBAction)AliPayLoginButtonAction:(id)sender;


@end

@implementation LoginViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:true animated:false];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCodeLogin = NO;
    
    //密码登录
    [self _setpasswordLogin];
}
//密码登录
-(void)_setpasswordLogin{   
    _telephoneLabel.borderStyle = UITextBorderStyleNone;
    _codeLabel.borderStyle = UITextBorderStyleNone;
    _passwordLabel.borderStyle = UITextBorderStyleNone;
    
    _telephoneLabel.delegate = self;
    _codeLabel.delegate = self;
    _passwordLabel.delegate = self;
    
    [self.telephoneLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_telephoneLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_codeLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_passwordLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //修改验证码按钮的颜色
    [self.sendCodeButton setTitleColor:Color_BBB forState:UIControlStateNormal];
    self.sendCodeButton.userInteractionEnabled = NO;
    
    //判断修改登录按钮的颜色
//    if (self.telephoneLabel.text.length >= 11 && self.passwordLabel.text.length > 1) {
//        self.loginButton.backgroundColor = BaseRedColor;
//        self.loginButton.userInteractionEnabled = YES;
//    }else if (self.telephoneLabel.text.length >= 11 && self.codeLabel.text.length >= 4){
//        self.loginButton.backgroundColor = BaseRedColor;
//        self.loginButton.userInteractionEnabled = YES;
//    }else{
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = Color_BBB;
//    }
    
}
-(void)returnKey:(UILabel *)label{
    [label endEditing:YES];
}

#pragma mark -
#pragma mark - textfile delegate
//取消第一响应者
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_telephoneLabel resignFirstResponder];
    [_codeLabel resignFirstResponder];
    [_passwordLabel resignFirstResponder];
}
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_telephoneLabel == textField){
        self.telephoneLabel.text = [self.telephoneLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
        if ([self.telephoneLabel.text length] > 11)  textField.text = [self.telephoneLabel.text substringToIndex:11];
    }
    else if (_codeLabel == textField){
        self.codeLabel.text = [self.codeLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
        if ([self.codeLabel.text length] > 8)  textField.text = [self.codeLabel.text substringToIndex:8];
    }else{
        self.passwordLabel.text = [self.passwordLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
        if ([self.passwordLabel.text length] > 16)  textField.text = [self.passwordLabel.text substringToIndex:16];
    }
    //判断修改登录按钮的颜色
    if (self.telephoneLabel.text.length == 11 && self.passwordLabel.text.length >= 6) {
        self.loginButton.backgroundColor = BaseRedColor;
        self.loginButton.userInteractionEnabled = YES;
    }else if (self.telephoneLabel.text.length == 11 && self.codeLabel.text.length >= 4){
        self.loginButton.backgroundColor = BaseRedColor;
        self.loginButton.userInteractionEnabled = YES;
    }else{
//        self.loginButton.selected = NO;
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = Color_BBB;
    }
 
    
    return NO;
}
*/
- (void)textFieldDidChange:(UITextField *)textField{
    if (_telephoneLabel == textField){
        if ([self.telephoneLabel.text length] > 11)  textField.text = [self.telephoneLabel.text substringToIndex:11];
        //修改codebutton状态
        if (self.telephoneLabel.text.length != 11) {
            [self.sendCodeButton setTitleColor:Color_BBB forState:UIControlStateNormal];
            self.sendCodeButton.userInteractionEnabled = NO;
        }else{
            [self.sendCodeButton setTitleColor:BaseRedColor forState:UIControlStateNormal];
            self.sendCodeButton.userInteractionEnabled = YES;
        }
    }
    else if (_codeLabel == textField){
        if ([self.codeLabel.text length] > 8)  textField.text = [self.codeLabel.text substringToIndex:8];
    }else{
        if ([self.passwordLabel.text length] > 16)  textField.text = [self.passwordLabel.text substringToIndex:16];
    }
    
    
    
    //判断修改登录按钮的颜色
    if (self.telephoneLabel.text.length == 11 && self.passwordLabel.text.length >= 6) {
        self.loginButton.backgroundColor = BaseRedColor;
        self.loginButton.userInteractionEnabled = YES;
    }else if (self.telephoneLabel.text.length == 11 && self.codeLabel.text.length >= 4){
        self.loginButton.backgroundColor = BaseRedColor;
        self.loginButton.userInteractionEnabled = YES;
    }else{
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = Color_BBB;
    }
}


#pragma mark -
#pragma mark - 按钮的点击事件

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
//发送验证码按钮(用于登录 type：SMS_LOGIN(验证码登录))
- (IBAction)sendCodeButtonAction:(id)sender {
    /*
     类型：
     USER_REG(注册)
     MODIFY_OR_FIND_PASS(修改/找回密码)
     SMS_LOGIN(验证码登录)
     MODIFY_PHONE(修改手机号)
     WITHDRAWALS(提现)*/
//    NSLog(@"%@",_telephoneLabel.text);
    //判断手机号位数及第一位数字
    if ([self.telephoneLabel.text length] != 11 || ![[self.telephoneLabel.text substringToIndex:1] isEqualToString:@"1"]) {
        UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:@"手机号错误" message:@"请检查手机号格式" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    NSDictionary *params = @{@"phone":self.telephoneLabel.text,
                             @"type":@"SMS_LOGIN"
                             };
    [XLAFnetworking postWithURL:sendPhoneCode params:params progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(NSDictionary* response) {
        
        if (![response[@"status"]boolValue]){
            NSLog(@"——————————————————————————发送验证码不成功 ————————————————————————");
            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:nil message:response[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        }else{
            
        NSLog(@"——---——————————发送验证码成功——————————");
        //按钮倒计时
        [self openCountdown:sender];
//            [ButtonCountDown countDownButton:_sendCodeButton withTitle:@"重新发送" withBackgroundColor:BaseRedColor withCountDownTime:59];
            
        }
    } failBlock:^(NSError *error) {
        NSLog(@"失败%@",error);
    }];
}





//回传注册按钮点击
- (IBAction)registerButtonAction:(id)sender {
    //回传注册按钮点击
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];

    [self.navigationController pushViewController:registerVC animated:YES];
    
}

//回传找回密码按钮点击
- (IBAction)findPasswordButtonAction:(id)sender {
    //回传找回密码按钮点击

    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    registerVC.isToFindPassword = YES;
  
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)loginApp:(id)sender {
    //密码登录和验证码登录都在这，要判断是验证码还是密码
//    NSLog(@"phoneNum:%@",self.telephoneLabel.text);
//    NSLog(@"codeLabel:%@",self.codeLabel.text);
//    NSLog(@"setPasswordLabel:%@",self.passwordLabel.text);
    
    [self.telephoneLabel resignFirstResponder];
    [self.passwordLabel resignFirstResponder];
    [self.codeLabel resignFirstResponder];
    
    if (self.telephoneLabel.text.length != 11 || ![XLJudgeTheempty checkPhone:self.telephoneLabel.text]) {
        [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请输入正确的11位手机号"] animated:YES completion:nil];
        return;
    }
    
    
    NSString *postURL;
    NSDictionary *params = [NSDictionary dictionary];
    if (_isCodeLogin) {
        if (self.codeLabel.text.length < 4) {
            [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请正确输入验证码"] animated:YES completion:nil];
            return;
        }
        //验证码登录
        postURL = LoginByCode;
        params = @{@"phone":self.telephoneLabel.text,
                 @"smsCode":self.codeLabel.text
                                 };
    }else if (!_isCodeLogin){
        if (self.passwordLabel.text.length < 6) {
            [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请正确输入6～16位密码"] animated:YES completion:nil];
            return;
        }
        //密码登录
        postURL = LoginByTelephone;
        params = @{@"phone":self.telephoneLabel.text,
                   @"password":self.passwordLabel.text
                   };
    }else{
        [self presentViewController:[XLAlertController alertWithTitle:nil WithMessage:@"请输入登录信息"] animated:YES completion:nil];
        return;
    }
    
    [XLAFnetworking postWithURL:LoginByTelephone params:params progressBlock:nil successBlock:^(NSDictionary *response) {
        NSLog(@"登录成功");
        //账号
        [[NSUserDefaults standardUserDefaults]setObject:self.telephoneLabel.text forKey:@"telephone"];
        //密码
        [[NSUserDefaults standardUserDefaults]setObject:self.passwordLabel.text forKey:@"password"];
        //必须
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //登录成功后通知跳到首页
        NSNotification *notification = [NSNotification notificationWithName:@"LoginCurrentToHomePageNotification" object:nil];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        
    } failBlock:^(NSError *error) {
        NSLog(@"登录失败");
    }];
    
    /*
    [XLAFnetworking postWithURL:postURL params:params progressBlock:nil successBlock:^(NSDictionary* response) {
        
        if (![response[@"status"]boolValue]){
            NSLog(@"——————————————————————————直接登录不成功 ————————————————————————");
//            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:nil message:response[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
//            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:alertVC animated:YES completion:nil];
            [self presentViewController:[XLAlertController alertWithTitle:nil WithMessage:response[@"msg"]] animated:YES completion:nil];
        }else{
            NSDictionary *data = response[@"data"];
            
            NSString *expire = [data[@"expire"] stringValue];//过期时间，单位秒
            NSString *token = data[@"token"];//token
            
            NSLog(@"——————————————————————————直接登录成功 ————————————————————————status:%@  &msg:%@  &code:%@",response[@"status"],response[@"msg"],response[@"code"]);
            //储存过期时间
            [[NSUserDefaults standardUserDefaults]setObject:expire forKey:@"expire"];//过期时间，单位秒
            //储存token
            [[NSUserDefaults standardUserDefaults ]setObject:token forKey:@"token"];
            //账号
            [[NSUserDefaults standardUserDefaults]setObject:self.telephoneLabel.text forKey:@"telephone"];
            //密码
            [[NSUserDefaults standardUserDefaults]setObject:self.passwordLabel.text forKey:@"password"];
            //必须
            [[NSUserDefaults standardUserDefaults]synchronize];
            
//            self.LoginCurrentToHomePageBlock();
            
            
            //登录成功后通知跳到首页
            NSNotification *notification = [NSNotification notificationWithName:@"LoginCurrentToHomePageNotification" object:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notification];
        }
        NSLog(@"%@",response);
        
    } failBlock:^(NSError *error) {
        NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!error!!!!!!!!!!!!!!!%@",error);
    }];
     */
    
    
    
    
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
                [sender setTitleColor:BaseRedColor forState:UIControlStateNormal];
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
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

#pragma mark - 微信登录和支付宝登录
- (IBAction)WeChatLoginButtonAction:(id)sender {
    NSNotification *notification = [NSNotification notificationWithName:@"WeChatLoginNotification" object:@"1"];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
    
//    NSLog(@"微信登录失败");
    
}

- (IBAction)AliPayLoginButtonAction:(id)sender {
    NSNotification *notification = [NSNotification notificationWithName:@"AlipayLoginNotification" object:@"1"];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}






//密码登录和验证码登录页面切换
- (IBAction)passwordLoginButtonAction:(id)sender {
    _isCodeLogin = NO;
    self.sendCodeButton.hidden = YES;
    self.codeLoginButtonView.hidden = YES;
    self.passwordLoginView.hidden = NO;

    self.codeLoginButtonLine.hidden = YES;
    self.passWordLoginLIne.hidden = NO;
    
    [sender setTitleColor:BaseRedColor forState:UIControlStateNormal];
    [self.codeLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}
- (IBAction)codeLoginButtonAction:(id)sender {
    _isCodeLogin = YES;
    self.sendCodeButton.hidden = NO;
    self.codeLoginButtonView.hidden = NO;
    self.passwordLoginView.hidden = YES;
    
    self.codeLoginButtonLine.hidden = NO;
    self.passWordLoginLIne.hidden = YES;
    
    [sender setTitleColor:BaseRedColor forState:UIControlStateNormal];
    [self.passWordLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

@end
