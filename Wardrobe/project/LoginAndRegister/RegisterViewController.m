//
//  RegisterViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/9.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserAgreementViewController.h"

#define PhoneNum @"0123456789\n"

@interface RegisterViewController ()<UITextFieldDelegate>



#pragma mark -

- (IBAction)backButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;//title（用户注册、找回密码）
@property (weak, nonatomic) IBOutlet UIButton *registerOrFindPasswordButton;//底部按钮（用户注册、找回密码）




#pragma mark -
#pragma mark - telephone regine
@property (weak, nonatomic) IBOutlet UITextField *telephoneLabel;//手机号label
@property (weak, nonatomic) IBOutlet UITextField *codeLabel;//验证码label
@property (weak, nonatomic) IBOutlet UIButton *codeButton;//"发送验证码"按钮
@property (weak, nonatomic) IBOutlet UITextField *setPasswordLabel;//设置密码label

//- (IBAction)codeButtonAction:(UIButton *)sender;//发送验证码按钮
//- (IBAction)registerButtonAction:(id)sender;//注册按钮


@property (weak, nonatomic) IBOutlet UILabel *agreementView;
@property (weak, nonatomic) IBOutlet UIButton *agreementView2;




@end

@implementation RegisterViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _isToFindPassword = NO;
    [self _loadContent];
 
}

-(void)_loadContent{
    
    _setPasswordLabel.placeholder = _isToFindPassword?@"输入新密码":@"请再次输入密码";
    _topTitleLabel.text = _isToFindPassword?@"找回密码":@"用户注册";
    NSString *title = _isToFindPassword?@"确认":@"注册";
    [_registerOrFindPasswordButton setTitle:title forState:UIControlStateNormal];
    if (_isToFindPassword) {
        _agreementView.hidden = YES;
        _agreementView2.hidden = YES;
    }
    
    //修改codebutton状态
    [self.codeButton setTitleColor:Color_BBB forState:UIControlStateNormal];
    self.codeButton.userInteractionEnabled = NO;
    
    //判断修改注册按钮的颜色
    if (self.telephoneLabel.text.length >= 11  && self.codeLabel.text.length >= 4 && self.setPasswordLabel.text.length >= 6) {
        self.registerOrFindPasswordButton.backgroundColor = BaseRedColor;
        self.registerOrFindPasswordButton.userInteractionEnabled = YES;
        
    }else{
        self.registerOrFindPasswordButton.userInteractionEnabled = NO;
        self.registerOrFindPasswordButton.backgroundColor = Color_BBB;
    }
    
    _telephoneLabel.borderStyle = UITextBorderStyleNone;
    _codeLabel.borderStyle = UITextBorderStyleNone;
    _setPasswordLabel.borderStyle = UITextBorderStyleNone;
    
    _telephoneLabel.delegate = self;
    _codeLabel.delegate = self;
    _setPasswordLabel.delegate = self;
    [self.telephoneLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.setPasswordLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_telephoneLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_codeLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_setPasswordLabel addTarget:self action:@selector(returnKey:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [_telephoneLabel becomeFirstResponder];
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
    [_setPasswordLabel resignFirstResponder];
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (_telephoneLabel == textField){
//        self.telephoneLabel.text = [self.telephoneLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
//        if ([self.telephoneLabel.text length] > 11)  textField.text = [self.telephoneLabel.text substringToIndex:11];
//    }
//    else if (_codeLabel == textField){
//        self.codeLabel.text = [self.codeLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
//        if ([self.codeLabel.text length] > 8)  textField.text = [self.codeLabel.text substringToIndex:8];
//    }else{
//        self.setPasswordLabel.text = [self.setPasswordLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
//        if ([self.setPasswordLabel.text length] > 16)  textField.text = [self.setPasswordLabel.text substringToIndex:16];
//    }
//
//    //修改codebutton状态
//    if (self.telephoneLabel.text.length != 11) {
//        [self.codeButton setTitleColor:Color_BBB forState:UIControlStateNormal];
//        self.codeButton.userInteractionEnabled = NO;
//    }else{
//        [self.codeButton setTitleColor:BaseRedColor forState:UIControlStateNormal];
//        self.codeButton.userInteractionEnabled = YES;
//    }
//
//    //判断修改注册按钮的颜色
//    if (self.telephoneLabel.text.length >= 11  && self.codeLabel.text.length >= 4 && self.setPasswordLabel.text.length >= 6) {
//        self.registerOrFindPasswordButton.backgroundColor = BaseRedColor;
//        self.registerOrFindPasswordButton.userInteractionEnabled = YES;
//
//    }else{
//        self.registerOrFindPasswordButton.userInteractionEnabled = NO;
//        self.registerOrFindPasswordButton.backgroundColor = Color_BBB;
//    }
//    return NO;
//}

-(void)textFieldDidChange:(UITextField *)textField{
    if (_telephoneLabel == textField){
        if ([self.telephoneLabel.text length] > 11)  textField.text = [self.telephoneLabel.text substringToIndex:11];
        //修改codebutton状态
        if (self.telephoneLabel.text.length != 11) {
            [self.codeButton setTitleColor:Color_BBB forState:UIControlStateNormal];
            self.codeButton.userInteractionEnabled = NO;
        }else{
            [self.codeButton setTitleColor:BaseRedColor forState:UIControlStateNormal];
            self.codeButton.userInteractionEnabled = YES;
        }
    }
    else if (_codeLabel == textField){
        if ([self.codeLabel.text length] > 8)  textField.text = [self.codeLabel.text substringToIndex:8];
    }else{
        if ([self.setPasswordLabel.text length] > 16)  textField.text = [self.setPasswordLabel.text substringToIndex:16];
    }
    
    
    
    //判断修改注册按钮的颜色
    if (self.telephoneLabel.text.length >= 11  && self.codeLabel.text.length >= 4 && self.setPasswordLabel.text.length >= 6) {
        self.registerOrFindPasswordButton.backgroundColor = BaseRedColor;
        self.registerOrFindPasswordButton.userInteractionEnabled = YES;
        
    }else{
        self.registerOrFindPasswordButton.userInteractionEnabled = NO;
        self.registerOrFindPasswordButton.backgroundColor = Color_BBB;
    }
}

#pragma mark -
#pragma mark - 按钮的点击
//顶部返回按钮
- (IBAction)backButtonAction:(id)sender {
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.2;
//    animation.type = kCATransitionMoveIn;
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:true];
}


//发送验证码按钮
- (IBAction)codeButtonAction:(UIButton *)sender {
    /*
     类型：
     USER_REG(注册)
     MODIFY_OR_FIND_PASS(修改/找回密码)
     SMS_LOGIN(验证码登录)
     MODIFY_PHONE(修改手机号)
     WITHDRAWALS(提现)*/
    //判断类型为“注册”或是“找回密码”
    NSString *type = _isToFindPassword?@"MODIFY_OR_FIND_PASS":@"USER_REG";
    //判断手机号位数及第一位数字
    if ([self.telephoneLabel.text length] != 11 || ![[self.telephoneLabel.text substringToIndex:1] isEqualToString:@"1"]) {
        UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:@"手机号错误" message:@"请检查手机号格式" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    NSDictionary *params = @{@"phone":self.telephoneLabel.text,
                             @"type":type
                             };
    [XLAFnetworking postWithURL:sendPhoneCode params:params progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(NSDictionary* response) {
        if ([response[@"status"]boolValue]) {
            NSLog(@"——————————————————————————验证码发送成功————————————————————");
            //按钮倒计时
//            [self openCountdown:sender];
            [ButtonCountDown countDownButton:_codeButton withTitle:@"重新发送" withBackgroundColor:BaseRedColor withCountDownTime:59];

        }else{

            [self presentViewController:[XLAlertController alertWithTitle:nil WithMessage:response[@"msg"]] animated:YES completion:nil];
            
        }
    } failBlock:^(NSError *error) {
        NSLog(@"——————————————————————————验证码发送失败%@——————————————————————————",error);
    }];
    
    
}

//注册或找回密码按钮
- (IBAction)registerButtonAction:(id)sender {
    

        if (self.telephoneLabel.text.length != 11 || ![XLJudgeTheempty checkPhone:self.telephoneLabel.text]) {
            [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请输入正确的11位手机号"] animated:YES completion:nil];
            return;
        }
        if (self.codeLabel.text.length < 4) {
            [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"确认您的验证码是否正确"] animated:YES completion:nil];
            return;
        }
        if (self.setPasswordLabel.text.length < 6) {
            [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请正确设置6～16位密码"] animated:YES completion:nil];
            return;
        }
    
//    NSLog(@"phoneNum:%@",self.telephoneLabel.text);
//    NSLog(@"codeLabel:%@",self.codeLabel.text);
//    NSLog(@"setPasswordLabel:%@",self.setPasswordLabel.text);
    
    //判断”注册“或“找回密码”url
    NSString *url = _isToFindPassword?registerAPI:@"http://192.168.1.101:8080/renren-fast/api/user/reg";
    
    NSDictionary *params = @{@"phone":self.telephoneLabel.text,
                             @"smsCode":self.codeLabel.text,
                             @"password":self.setPasswordLabel.text
                             };
    
    
    [XLAFnetworking postWithURL:url params:params progressBlock:nil successBlock:^(NSDictionary *response) {
        NSLog(@"注册成功");
        //账号
        [[NSUserDefaults standardUserDefaults]setObject:self.telephoneLabel.text forKey:@"telephone"];
        //密码
        [[NSUserDefaults standardUserDefaults]setObject:self.setPasswordLabel.text forKey:@"password"];
        //必须
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popViewControllerAnimated:true];
    } failBlock:^(NSError *error) {
        NSLog(@"注册失败");
    }];
    
    /*
    [XLAFnetworking postWithURL:url params:params progressBlock:nil successBlock:^(NSDictionary* response) {

        
        NSLog(@"status:%@  &msg:%@  &code:%@",response[@"status"],response[@"msg"],response[@"code"]);
        if (![response[@"status"]boolValue]) {
            NSLog(@"——————————————————————————注册或找回密码不成功 ————————————————————————");
           
        }else{
            NSLog(@"——————————————————————————注册或找回密码成功 ————————————————————————status:%@&msg:%@&code:%@",response[@"status"],response[@"msg"],response[@"code"]);
            
            [[UIApplication sharedApplication].keyWindow makeToast:response[@"msg"] duration:2.0 position:CSToastPositionCenter];
            //注册后登陆
            [self loginApp];
            
//            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:nil message:response[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:alertVC animated:YES completion:nil];
//
//            [self performSelector:@selector(OneSecondsDisappearAction:) withObject:alertVC afterDelay:1.0];
            
//            [self loginApp];
        }
    } failBlock:^(NSError *error) {
        NSLog(@"——————————————————————————注册或找回密码失败 ————————————————————————%@",error);
        
    }];
     */
}

#pragma mark -
#pragma mark - 注册成功---直接登录
//注册成功---直接登录 ------- 手机号密码登录
- (void)loginApp {
    //密码登录和验证码登录都在这，要判断是验证码还是密码
    NSLog(@"phoneNum:%@",self.telephoneLabel.text);
    NSLog(@"setPasswordLabel:%@",self.setPasswordLabel.text);

    //密码登录
    NSDictionary *params = @{@"phone":self.telephoneLabel.text,
                   @"password":self.setPasswordLabel.text
                   };
    
    
   
    
    
    /*
    [XLAFnetworking postWithURL:LoginByTelephone params:params progressBlock:nil successBlock:^(NSDictionary* response) {
        if (![response[@"status"]boolValue]){
            NSLog(@"——————————————————————————注册后直接登录失败 ————————————————————————");
            
        }else{
//            [self presentViewController:[XLAlertController OneSecondsalertWithTitle:nil WithMessage:response[@"msg"]] animated:YES completion:nil];
            
            NSLog(@"——————————————————————————注册后直接登录成功 ————————————————————————status:%@  &msg:%@  &code:%@",response[@"status"],response[@"msg"],response[@"code"]);
            NSDictionary *data = response[@"data"];
            NSString *expire = [data[@"expire"] stringValue];//过期时间，单位秒
            NSString *token = data[@"token"];//token
            
            //储存过期时间
            [[NSUserDefaults standardUserDefaults]setObject:expire forKey:@"expire"];//过期时间，单位秒
            //储存token
            [[NSUserDefaults standardUserDefaults ]setObject:token forKey:@"token"];
            //账号
            [[NSUserDefaults standardUserDefaults]setObject:self.telephoneLabel.text forKey:@"telephone"];
            //密码
            [[NSUserDefaults standardUserDefaults]setObject:self.setPasswordLabel.text forKey:@"password"];
            //必须
            [[NSUserDefaults standardUserDefaults]synchronize];
            
//            self.returnRegistToLoginCurrent();
            
            [self.setPasswordLabel endEditing:YES];
            //注册登录成功后通知跳到首页
            NSNotification *notification = [NSNotification notificationWithName:@"returnRegistToLoginCurrentNotification" object:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notification];
        }
 
    } failBlock:^(NSError *error) {
        NSLog(@"——————————————————————————注册后直接登录失败 ————————————————————————%@",error);
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
//注册后2秒登录
- (void)OneSecondsDisappearAction:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
    
}

//用户协议
- (IBAction)agreementButtonAction:(id)sender {
    UserAgreementViewController *userAgreementVC = [UserAgreementViewController new];
    [self presentViewController:userAgreementVC animated:YES completion:nil];
    
//    self.tabBarController.tabBar.hidden = YES;
//    [self.navigationController pushViewController:userAgreementVC animated:YES];
//    self.tabBarController.tabBar.hidden = NO;
    
}



@end
