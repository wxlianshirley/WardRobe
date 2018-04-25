//
//  ManageWeChatOrAlipayViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/16.
//  Copyright © 2017年 wxLian. All rights reserved.
//
#import "AppDelegate.h"
#import "ManageWeChatOrAlipayViewController.h"

@interface ManageWeChatOrAlipayViewController ()<UITextFieldDelegate>
{
    NSString *weChatImageUrl;//微信头像URL
}

@property(nonatomic,assign)BOOL isChangeManager;//是绑定还是修改？
@property (weak, nonatomic) IBOutlet UIButton *bingdingButton;

@property (weak, nonatomic) IBOutlet UILabel *firstlabel;//支付宝账户||真实姓名
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;//支付宝姓名||手机号码

@property (weak, nonatomic) IBOutlet UIView *backgroudView;//支付宝||微信
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroudHeight;//view高度


@property (weak, nonatomic) IBOutlet UITextField *firstTextFile;//支付宝账户||真实姓名
@property (weak, nonatomic) IBOutlet UITextField *secondTextFile;//支付宝姓名||手机号码


@property (weak, nonatomic) IBOutlet UILabel *weChatAuthorizedLabel;//微信授权绑定账户
@property (weak, nonatomic) IBOutlet UIImageView *weChatAuthorizedImageView;//微信授权绑定头像

@property (weak, nonatomic) IBOutlet UILabel *reminderLabel;//温馨提示



@end

@implementation ManageWeChatOrAlipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _loadContent];
}
#pragma mark - get set
-(void)setIsChangeManager:(BOOL)isChangeManager{
    _isChangeManager = isChangeManager;
    
    if (_isChangeManager) {
        self.firstTextFile.enabled = NO;
        self.secondTextFile.enabled = NO;
        [_bingdingButton setTitle:@"修改" forState:UIControlStateNormal];
        
    }else{
        self.firstTextFile.enabled = YES;
        self.secondTextFile.enabled = YES;
        [_bingdingButton setTitle:@"绑定" forState:UIControlStateNormal];
        [self.firstTextFile becomeFirstResponder];
    }
}


-(void)_loadContent{
    
    // 读取账户
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"];
    NSDictionary* dataDic = userInfoDic;
    
    if (self.isWeChatManager) {
        self.title = @"管理微信钱包";
        self.firstlabel.text = @"真实姓名:";
        self.secondLabel.text = @"手机号码:";
        self.firstTextFile.keyboardType = UIKeyboardTypeDefault;
        self.secondTextFile.keyboardType = UIKeyboardTypePhonePad;
        self.firstTextFile.text = [XLJudgeTheempty Judgetheempty: dataDic[@"weixinPayName"]];
        self.secondTextFile.text = [XLJudgeTheempty Judgetheempty: dataDic[@"weixinPayPhone"]];
        self.weChatAuthorizedLabel.text = [XLJudgeTheempty Judgetheempty: dataDic[@"weixinPayNickname"]];
        [self.weChatAuthorizedImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"weixinPayAvatar"]] placeholderImage:[UIImage imageNamed:@"userPhoto"]];
        self.backgroudHeight.constant = 134;
    }else{
        self.title = @"管理支付宝";
        self.firstlabel.text = @"支付宝姓名:";
        self.secondLabel.text = @"支付宝账户:";
        self.firstTextFile.keyboardType = UIKeyboardTypeDefault;
        self.secondTextFile.keyboardType = UIKeyboardTypeDefault;
        self.firstTextFile.text = [XLJudgeTheempty Judgetheempty: dataDic[@"alipayName"]];
        self.secondTextFile.text = [XLJudgeTheempty Judgetheempty: dataDic[@"alipayAccount"]];
        self.backgroudHeight.constant = 89 ;
        self.backgroudView.clipsToBounds = YES;
        self.reminderLabel.hidden = YES;
    }
    [super loadViewIfNeeded];
    
    if (self.firstTextFile.text.length < 1 || self.secondTextFile.text.length <1) {
        self.isChangeManager = NO;
    }else{
        self.isChangeManager = YES;
    }

    _firstTextFile.borderStyle = NO;
    _secondTextFile.borderStyle = NO;
    _firstTextFile.delegate = self;
    _secondTextFile.delegate = self;
    
    [self.firstTextFile addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.secondTextFile addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
#pragma mark -
#pragma mark - textfile delegate
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_firstTextFile resignFirstResponder];
    [_secondTextFile resignFirstResponder];
}
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_firstTextFile == textField){
        self.firstTextFile.text = [self.firstTextFile.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
        NSLog(@"self.firstTextFile.text:%@",self.firstTextFile.text);
    }
    else {
        self.secondTextFile.text = [self.secondTextFile.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
        NSLog(@"self.secondTextFile.text:%@",self.secondTextFile.text);
        if (self.isWeChatManager) {
            if ([self.secondTextFile.text length] > 11)  textField.text = [self.secondTextFile.text substringToIndex:11];
        }else{
            if ([self.secondTextFile.text length] > 10)  {
                textField.text = [self.secondTextFile.text substringToIndex:11];
                [self.navigationController.view makeToast:@"姓名最多10位" duration:2.0 position:CSToastPositionCenter];
                
            };
        }
    }
    
    return NO;
}
*/

- (void)textFieldDidChange:(UITextField *)textField{

    if (self.isWeChatManager) {
        if ([self.secondTextFile.text length] > 11)  textField.text = [self.secondTextFile.text substringToIndex:11];
    }else{
        if ([self.firstTextFile.text length] > 10)  {
            textField.text = [self.secondTextFile.text substringToIndex:11];
            [self.navigationController.view makeToast:@"姓名最多10位" duration:2.0 position:CSToastPositionCenter];
        };
    }

}


#pragma mark -
#pragma mark - 绑定按钮
- (IBAction)bindingAlipayButtonAction:(id)sender {
    
    if (self.isChangeManager) {
        self.isChangeManager = NO;
        return;
    }
    
    
    NSLog(@"self.firstTextFile.text-----%@",self.firstTextFile.text);
    NSLog(@"self.secondTextFile.text-----%@",self.secondTextFile.text);
    
    if (self.firstTextFile.text.length < 1 || self.secondTextFile.text.length <1) {
        [self.navigationController.view makeToast:@"请填写完整信息" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *firstdicKey;
    NSString *seconddicKey;
    if (_isWeChatManager) {
        
        firstdicKey = @"weixinPayName";
        seconddicKey = @"weixinPayPhone";
        if (self.secondTextFile.text.length != 11 || ![XLJudgeTheempty checkPhone:self.secondTextFile.text]) {
            [self.navigationController.view makeToast:@"请检查手机号格式" duration:2.0 position:CSToastPositionCenter];
            return;
        }
        if (self.weChatAuthorizedLabel.text.length < 2) {
            [self.navigationController.view makeToast:@"请进行微信授权后再操作" duration:2.0 position:CSToastPositionCenter];
            return;
        }
        
    }else{
#warning 判断账号是不是数字、字母和标点
        if ( ![XLJudgeTheempty checkPhone:self.secondTextFile.text] && ![XLJudgeTheempty checkEmail:self.secondTextFile.text]) {
            [self.navigationController.view makeToast:@"请填写正确的账户信息（一般为电话号码或者邮箱）" duration:2.0 position:CSToastPositionCenter];
            return;
        }
        firstdicKey = @"alipayName";
        seconddicKey = @"alipayAccount";
    }
    
    NSDictionary *params = @{@"key":firstdicKey,@"value":self.firstTextFile.text};
    NSDictionary *parmas2 = @{@"key":seconddicKey,@"value":self.secondTextFile.text};
    NSLog(@"%@",params);
    [XLAFnetworking postWithURL:UpdateInfo params:params progressBlock:nil successBlock:^(NSDictionary *response) {//发送第一个label
        NSLog(@"管理钱包：response:%@",response);
        
        [XLAFnetworking postWithURL:UpdateInfo params:parmas2 progressBlock:nil successBlock:^(NSDictionary *response) {//发送第二个label
            NSLog(@"管理钱包：response:%@",response);
            [self.navigationController.view makeToast:@"提交成功" duration:2.0 position:CSToastPositionCenter];
            
            // 读取账户
            NSMutableDictionary *userInfoDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"]mutableCopy];
            if (_isWeChatManager) {
                [userInfoDic setValue:self.firstTextFile.text forKey:@"weixinPayName"];
                [userInfoDic setValue:self.secondTextFile.text forKey:@"weixinPayPhone"];
                [userInfoDic setValue:self.weChatAuthorizedLabel.text forKey:@"weixinPayNickname"];
                [userInfoDic setValue:weChatImageUrl forKey:@"weixinPayAvatar"];
            }else{
                [userInfoDic setValue:self.firstTextFile.text forKey:@"alipayName"];
                [userInfoDic setValue:self.secondTextFile.text forKey:@"alipayAccount"];
            }
            [[NSUserDefaults standardUserDefaults]setObject:userInfoDic forKey:@"userInfoDic"];
            [self.delegate ChangeWeChatOrAlipayBack:_isWeChatManager];//修改成功后代理回调
            [self.navigationController popViewControllerAnimated:YES];
            
        } failBlock:^(NSError *error) {}];
    } failBlock:^(NSError *error) {}];
}

//授权微信钱包
- (IBAction)authorizeWeChatButtonAction:(id)sender {
    NSNotification *notification = [NSNotification notificationWithName:@"WeChatLoginNotification" object:@"3"];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSLog(@"delegate.weChatNikeName:%@",delegate.weChatNikeName);
//    NSLog(@"delegate.weChatHeadImgUrl:%@",delegate.weChatHeadImgUrl);
//    self.weChatAuthorizedLabel.text = delegate.weChatNikeName;
//    [self.weChatAuthorizedImageView sd_setImageWithURL:[NSURL URLWithString:delegate.weChatHeadImgUrl] placeholderImage:[UIImage imageNamed:@"userPhoto"]];
}
//微信钱包绑定后拿到的头像和昵称
-(void)changeWeChatName:(NSString *)nickName WithUserImage:(NSString *)userImage{
    self.weChatAuthorizedLabel.text = nickName;
    weChatImageUrl = userImage;
    [self.weChatAuthorizedImageView sd_setImageWithURL:[NSURL URLWithString:weChatImageUrl] placeholderImage:[UIImage imageNamed:@"userPhoto"]];
}


@end
