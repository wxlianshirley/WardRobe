//
//  SystemSetupViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/16.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "SystemSetupViewController.h"
#import "UserAgreementViewController.h"

#import "HSUpdateApp.h"
@interface SystemSetupViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *array;
}
@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;
@end

@implementation SystemSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统设置";
    [self _loadTableView];
}
-(UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}
-(void)_loadTableView{
    array = @[@[@"当前版本"/*,@"清除缓存"*/],@[@"评分",@"用户协议"/*,@"关于"*/]];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}
#pragma mark -
#pragma mark - delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 2;
//    }else{
//        return 2;
//    }

    NSArray *arr =  array[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = array[indexPath.section][indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    if (indexPath.section == 0 && indexPath.row == 0) {//检查更新
        //=================根据appid检测====================
        [HSUpdateApp hs_updateWithAPPID:apple_id withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
            if (isUpdate) {
                [self showAlertViewTitle:@"版本检测" subTitle:[NSString stringWithFormat:@"检测到新版本%@。是否更新？",storeVersion] openUrl:openUrl];
            }else{
//                NSLog(@"当前版本%@,商店版本%@，不需要更新",currentVersion,storesVersion);
                [self.view makeToast:@"已是最新版本" duration:2.0 position:CSToastPositionCenter];
            }
            [self.indicatorView stopAnimating];
        }];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {//评分
        NSString  * nsStringToOpen = [NSString  stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",apple_id];//替换为对应的APPID
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {//用户协议
        UserAgreementViewController *userAgreementVC = [UserAgreementViewController new];
        [self presentViewController:userAgreementVC animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    */
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark - AlertView 跳转AppStore
-(void)showAlertViewTitle:(NSString *)title subTitle:(NSString *)subTitle openUrl:(NSString *)openUrl{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        if (@available(iOS 10.0, *)) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:@{} completionHandler:^(BOOL success) {
//
//            }];
//        } else {
//            // Fallback on earlier versions
//        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
