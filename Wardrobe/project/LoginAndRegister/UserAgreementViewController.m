//
//  UserAgreementViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/15.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "UserAgreementViewController.h"

@interface UserAgreementViewController ()
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (nonatomic, strong) WKWebView *detailWebView;
@end

@implementation UserAgreementViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.backgroundColor = BaseRedColor;
    
    [self _loadWebView];
}

-(void)_loadWebView{
    _detailWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
//    _detailWebView.navigationDelegate = self;
//    _detailWebView.scrollView.delegate = self;
    [self.view addSubview:_detailWebView];
    [_detailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.right.left.bottom.equalTo(self.view);
//        make.height.mas_equalTo(channelBtn_Height);
    }];
    
    NSString *timeStr =[NSString stringWithFormat:@"http://www.dzkandian.com/user.protocol.html?_r=%@",[XLAFnetworking currentTimeStr]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:timeStr]];
    [_detailWebView loadRequest:urlRequest];
}
- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
