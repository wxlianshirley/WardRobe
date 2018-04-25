//
//  ChangePhoneOrPassworldViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/2/5.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "ChangePhoneOrPassworldViewController.h"
#import "InputOldPsdViewController.h"
#import "NowChangePhoneOrPsdViewController.h"
@interface ChangePhoneOrPassworldViewController ()
@property (nonatomic ,strong) CAShapeLayer *tancleLayer;//顶部线条
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;//下一步按钮

@property (weak, nonatomic) IBOutlet UIView *topBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *checkIdentityLabel;//顶部栏目的：1.验证身份
@property (weak, nonatomic) IBOutlet UILabel *bingdingTelephoneLabel;//顶部栏目的：2.绑定手机号
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;//第一个框框
@property (weak, nonatomic) IBOutlet UIButton *codeButton;//验证码button
@property (weak, nonatomic) IBOutlet UITextField *codeLabel;//滴二个框框
@end

@implementation ChangePhoneOrPassworldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //顶部块背景切换
//    [self.topBackgroundView.layer addSublayer: self.tancleLayer];
    
    [self _setChangeTelephoneOrPsd];

}

-(void)_setChangeTelephoneOrPsd{
    [self.codeLabel becomeFirstResponder];
    
    self.telephoneLabel.text = _telephoneNum;
    
    self.nextStepButton.userInteractionEnabled = NO;
//    self.nextStepButton.backgroundColor = Color_BBB;
    
    _codeLabel.borderStyle = UITextBorderStyleNone;
    
    if (_ischangeTelephone) {
        self.title = @"修改手机号";
        self.bingdingTelephoneLabel.text = @"2.绑定新手机";
    }else{
        self.title = @"修改密码";
        self.bingdingTelephoneLabel.text = @"2.设置新密码";
    }
    
    [_codeLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}



#pragma mark -
#pragma mark - textfile delegate
//取消第一响应者
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_telephoneLabel resignFirstResponder];
    [_codeLabel resignFirstResponder];
}



-(void)textFieldDidChange:(UITextField *)textField{

    if ([self.codeLabel.text length] > 8)  textField.text = [self.codeLabel.text substringToIndex:8];
    

    //修改下一步按钮状态
    if (self.telephoneLabel.text.length == 11 && self.codeLabel.text.length >= 6) {
//        self.nextStepButton.backgroundColor = BaseRedColor;
        self.nextStepButton.userInteractionEnabled = YES;
    }else{
        self.nextStepButton.userInteractionEnabled = NO;
//        self.nextStepButton.backgroundColor = Color_BBB;
    }
    
    
}



#pragma mark - Button Action
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

    NSDictionary *params = @{@"phone":@"",
                             @"type":type
                             };
    /*
    [XLAFnetworking postWithURL:nil params:params progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
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
    }];
     */
}
//收不到验证码按钮
- (IBAction)notReceivedCode:(id)sender {
    InputOldPsdViewController *oldPsdVC = [InputOldPsdViewController new];
    oldPsdVC.ischangeTelephone = self.ischangeTelephone;
    [self.navigationController pushViewController:oldPsdVC animated:YES];
}

//下一步按钮
- (IBAction)nextStep:(id)sender {
    //验证验证码正不正确
    /*验证码类型：
     USER_REG(注册)
     MODIFY_OR_FIND_PASS(修改/找回密码)
     SMS_LOGIN(验证码登录)
     MODIFY_PHONE(修改手机号)
     WITHDRAWALS(提现)*/
    //判断类型为“修改手机号”
    NSString *type = _ischangeTelephone ?  @"MODIFY_PHONE":@"MODIFY_OR_FIND_PASS";
    NSDictionary *params = @{@"smsCode":self.codeLabel.text,@"smsType":type};
    /*
    [XLAFnetworking postWithURL:VerifySms params:params progressBlock:nil successBlock:^(NSDictionary *response) {
        
        if ([response[@"status"]boolValue]) {
            [self.view makeToast:@"验证成功" duration:2.0 position:CSToastPositionCenter];
            NowChangePhoneOrPsdViewController *nowChangeVC = [NowChangePhoneOrPsdViewController new];
            nowChangeVC.ischangeTelephone = self.ischangeTelephone;
            nowChangeVC.codeNum = self.codeLabel.text;
            [self.navigationController pushViewController:nowChangeVC animated:YES];
        }else{
            [self.view makeToast:response[@"msg"] duration:2.0 position:CSToastPositionCenter];
        }
        
    } failBlock:^(NSError *error) {
        
    }];
    */
    
    
    
    
}



#pragma mark -
#pragma mark - 一些动画效果 （倒计时、顶部线条）
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

//顶部背景线条
-(CAShapeLayer *)tancleLayer{
    if(_tancleLayer == nil){
        _tancleLayer = [[CAShapeLayer alloc] init];
        _tancleLayer.frame = CGRectMake(0, 0, _topBackgroundView.frame.size.width/2.0 + 15, _topBackgroundView.frame.size.height);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(_topBackgroundView.frame.size.width/2.0,0)];
        [path addLineToPoint:CGPointMake(_topBackgroundView.frame.size.width/2.0 + 15, _topBackgroundView.frame.size.height/2.0)];
        [path addLineToPoint:CGPointMake(_topBackgroundView.frame.size.width/2.0, _topBackgroundView.frame.size.height)];
        [path addLineToPoint:CGPointMake(0, _topBackgroundView.frame.size.height)];
        [path addLineToPoint:CGPointMake(0, 0)];
        _tancleLayer.path = path.CGPath;
        _tancleLayer.strokeColor = [UIColor clearColor].CGColor;
        _tancleLayer.lineWidth = 0.01f;
        _tancleLayer.fillColor = [UIColor redColor].CGColor;
        _tancleLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _tancleLayer;
}

@end
