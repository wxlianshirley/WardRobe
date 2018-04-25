//
//  InputOldPsdViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/2/6.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "InputOldPsdViewController.h"
#import "NowChangePhoneOrPsdViewController.h"
@interface InputOldPsdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordLabel;//输入框
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;//下一步
@property (weak, nonatomic) IBOutlet UILabel *bingdingTelephoneLabel;//顶部右边栏目文字

@end

@implementation InputOldPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setOldPassword];
    
}

-(void)_setOldPassword{
    [_oldPasswordLabel becomeFirstResponder];
    _oldPasswordLabel.borderStyle = UITextBorderStyleNone;
    [_oldPasswordLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.nextStepButton.userInteractionEnabled = NO;
    self.nextStepButton.backgroundColor = Color_BBB;
    if (_ischangeTelephone) {
        self.title = @"修改手机号";
        self.bingdingTelephoneLabel.text = @"2.绑定新手机";
    }else{
        self.title = @"修改密码";
        self.bingdingTelephoneLabel.text = @"2.设置新密码";
    }
}

#pragma mark -
#pragma mark - textfile delegate
//取消第一响应者
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_oldPasswordLabel resignFirstResponder];
}

-(void)textFieldDidChange:(UITextField *)textField{
    if ([self.oldPasswordLabel.text length] > 16)  textField.text = [self.oldPasswordLabel.text substringToIndex:16];
    //修改下一步按钮状态
    if (self.oldPasswordLabel.text.length <= 16 && self.oldPasswordLabel.text.length >= 6) {
        self.nextStepButton.backgroundColor = BaseRedColor;
        self.nextStepButton.userInteractionEnabled = YES;
    }else{
        self.nextStepButton.userInteractionEnabled = NO;
        self.nextStepButton.backgroundColor = Color_BBB;
    }
}





#pragma mark - Button Action
- (IBAction)nextStep:(id)sender {
    //验证旧密码
    NSDictionary *params = @{@"oldPassword":self.oldPasswordLabel.text};
    /*
    [XLAFnetworking postWithURL:VerifyPwd params:params progressBlock:nil successBlock:^(NSDictionary *response) {
        if ([response[@"status"]boolValue]) {
            NowChangePhoneOrPsdViewController *nowChangeVC = [NowChangePhoneOrPsdViewController new];
            nowChangeVC.ischangeTelephone = self.ischangeTelephone;
            nowChangeVC.oldPwdNum = self.oldPasswordLabel.text;
            [self.navigationController pushViewController:nowChangeVC animated:YES];
        }else{
            [self.view makeToast:response[@"msg"] duration:2.0 position:CSToastPositionCenter];
        }
        
        
    } failBlock:^(NSError *error) {
        
    }];
    
    */
}




@end
