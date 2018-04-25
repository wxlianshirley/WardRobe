//
//  SelfViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/11/30.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "SelfViewController.h"
#import "UserInfoModel.h"
#import "SelfViewTableViewCell_Zero.h"
#import "SelfViewTableViewCell_one.h"
#import "SelfViewTableViewCell_two.h"

//section=0
#import "SystemSetupViewController.h"
//section=1



//section=2
#import "ActivityCenterViewController.h"
#import "UserFeedBackViewController.h"
#import "ProblemViewController.h"
//section=3qqq
#import "InfomationViewController.h"
#import "LoginViewController.h"



static NSString * const SelfViewTableViewCell_Zero_identifier = @"SelfViewTableViewCell_Zero_identifier";
static NSString * const SelfViewTableViewCell_one_identifier = @"SelfViewTableViewCell_one_identifier";
static NSString * const SelfViewTableViewCell_two_identifier = @"SelfViewTableViewCell_two_identifier";



@interface SelfViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    SystemSetupViewController *systemVC;
    
    NSArray *twoArr;
    NSArray *twoImgArr;
    NSString * token;
}
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSDictionary *dataDic;//数据
@property(nonatomic,copy)NSString *photoUrl;//头像
@property(nonatomic,copy)NSString *name;//昵称
@property(nonatomic,copy)NSString *telephone;//电话

@property (assign, nonatomic)NSInteger todayGold;//今日金币
@property (assign, nonatomic)NSInteger surplusGold;//剩余未兑换金币
@property (assign, nonatomic)NSInteger totalGold;//合计赚取的金币



@end

@implementation SelfViewController
//视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //获取本地token
    
    token = [KUserDefault objectForKey:@"token"];
    if (token) {
        
    }else{
        [_tableView reloadData];
    }
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    [self _loadTableView];
    systemVC = [[SystemSetupViewController alloc]init];
    
    twoArr = [NSArray arrayWithObjects:@"活动中心",@"意见反馈",@"常见问题", nil];
    twoImgArr = [NSArray arrayWithObjects:@"huodongzhongxin",@"userfeedBack",@"changjianwenti", nil];
    
    
}


-(void)_loadTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"SelfViewTableViewCell_Zero" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SelfViewTableViewCell_Zero_identifier];
    [_tableView registerNib:[UINib nibWithNibName:@"SelfViewTableViewCell_one" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SelfViewTableViewCell_one_identifier];
    [_tableView registerNib:[UINib nibWithNibName:@"SelfViewTableViewCell_two" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SelfViewTableViewCell_two_identifier];
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 5;
    _tableView.separatorStyle = NO;
    _tableView.alwaysBounceVertical=NO;
    
    /*
    SelfViewHeader *headView = [[SelfViewHeader alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    _tableView.tableHeaderView = headView;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.bounds.size.width/2;;
    imageView.backgroundColor = [UIColor redColor];
    [headView addSubview:imageView];
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.backgroundColor = [UIColor redColor];
    [headView addSubview:nameLabel];
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.backgroundColor = [UIColor redColor];
    [headView addSubview:phoneLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView).with.offset(10);
        make.left.equalTo(imageView.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(10);
        make.left.equalTo(imageView.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    */
   
}

#pragma mark -
#pragma mark - delegate datasourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
//    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 1;
    else if (section == 1) return 1;
    else if (section == 2) return twoArr.count;
    else return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取本地token
//    NSString * token = [KUserDefault objectForKey:@"token"];
    
    
    SelfViewTableViewCell_Zero *zeroCell = [tableView dequeueReusableCellWithIdentifier:SelfViewTableViewCell_Zero_identifier];
    SelfViewTableViewCell_one *oneCell = [tableView dequeueReusableCellWithIdentifier:SelfViewTableViewCell_one_identifier];
    SelfViewTableViewCell_two *twoCell = [tableView dequeueReusableCellWithIdentifier:SelfViewTableViewCell_two_identifier];
    
    zeroCell.selectionStyle = UITableViewCellSelectionStyleNone;
    oneCell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    if (indexPath.section == 0) {
        [zeroCell.userimageView sd_setImageWithURL:[NSURL URLWithString: self.photoUrl] placeholderImage:[UIImage imageNamed:@"userPhoto"]];
        zeroCell.userNameLabel.text = self.name;
        
        
        zeroCell.userPhoneLabel.text = [self.telephone isEqualToString:@""] ? @"尚未设置手机号": self.telephone;
        if ([zeroCell.userPhoneLabel.text isEqualToString:@"尚未设置手机号"]) {
            zeroCell.userPhoneLabel.textColor = [UIColor whiteColor];
        }else{
            zeroCell.userPhoneLabel.textColor = [UIColor whiteColor];
        }
        //如果没有token就全部为空
        if (token) {
            zeroCell.ishideLoginBtn = true;
        }else{
            zeroCell.ishideLoginBtn = false;
            zeroCell.userNameLabel.text = @"";
            zeroCell.userPhoneLabel.text = @"";
            zeroCell.userimageView.image = [UIImage imageNamed:@"userPhoto"];
        }
        
        zeroCell.todayGoldLabel.text = [NSString stringWithFormat:@"%ld",(long)self.todayGold];
        zeroCell.surplusGoldLabel.text =[NSString stringWithFormat:@"%ld",(long)self.surplusGold] ;
        zeroCell.totalGoldLabel.text =[NSString stringWithFormat:@"%ld",(long)self.totalGold] ;
        
        
        zeroCell.SystemSetupButtonClickBlock = ^{
            if (token) {
                //跳转到系统设置
                self.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:systemVC animated:YES];
                self.hidesBottomBarWhenPushed=NO;
            }else{
                LoginViewController *loginVC = [LoginViewController new];
                loginVC.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:loginVC animated:true];
            }
        };
        zeroCell.InfomationSetupButtonClickBlock = ^{
            if (token) {
                //账户设置
                InfomationViewController *infomationVC = [[InfomationViewController alloc]init];
                self.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:infomationVC animated:YES];
                self.hidesBottomBarWhenPushed= NO;
            }else{
                LoginViewController *loginVC = [LoginViewController new];
                loginVC.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:loginVC animated:true];
            }

        };
        
        zeroCell.LoginButtonClickBlock = ^{
            LoginViewController *loginVC = [LoginViewController new];
            loginVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:loginVC animated:true];
        };
        
        return zeroCell;
    }
    else if (indexPath.section == 1) {
     
//        __weak typeof(oneCell)wCell = oneCell;
//        //好友邀请
//        oneCell.FriendInvitationButtonClickBlock = ^{
//            if (token) {
//                if ( [ wCell.titleLab.text isEqualToString: @"立即签到" ]) {
//                    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
//                }else{
//                    [XLAFnetworking postWithURL:ShareUmeng params:@{@"keys":@"APP分享标题,APP分享描述,APP分享链接"} progressBlock:nil successBlock:^(NSDictionary *response) {
//
//                        NSArray *arr = response[@"data"];
//
//                        NSString *title = arr[0];
//                        NSString *destri = arr[1];
//                        NSString *url = arr[2];
//
////                        NSLog(@"%@,%@,%@",title,destri,url);
////                        push_share_message(SocialPlatformNone, title, destri, nil, url, nil);
//
//                    } failBlock:^(NSError *error) {
//
//                    }];
//                }
//            }else{
//                LoginViewController *loginVC = [LoginViewController new];
//                loginVC.hidesBottomBarWhenPushed = true;
//                [self.navigationController pushViewController:loginVC animated:true];
//
//            }
//
//        };
       
        return oneCell;
    }
    else if (indexPath.section == 2){

        
//        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
//        cell.textLabel.text = twoArr[indexPath.row];
//        cell.imageView.image = [UIImage imageNamed:twoImgArr[indexPath.row]];
//        return cell;
        twoCell.textLab.text = twoArr[indexPath.row];
        twoCell.imgView.image = [UIImage imageNamed:twoImgArr[indexPath.row]];
        return twoCell;
    }else{

//        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
//        cell.textLabel.text = @"账户设置";
//        cell.imageView.image = [UIImage imageNamed:@"managerShezhi"];
//        return cell;
        twoCell.textLab.text = @"账户设置";
        twoCell.imgView.image = [UIImage imageNamed:@"managerShezhi"];
        return twoCell;
        
        
        
    }
}
#pragma mark - selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    NSString * token = [KUserDefault objectForKey:@"token"];
    if (!token) {
        LoginViewController *loginVC = [LoginViewController new];
        loginVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:loginVC animated:true];
        return;
    }

    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            //活动中心
//            NSLog(@"活动中心");
            ActivityCenterViewController *activityCenterVC = [[ActivityCenterViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:activityCenterVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }else
            if (indexPath.row == 1){
            //意见反馈
            UserFeedBackViewController *userFeedBackVC = [[UserFeedBackViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userFeedBackVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }else{
            //常见问题
            ProblemViewController *problemVC = [[ProblemViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:problemVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
        
    }else if (indexPath.section == 3){
        //账户设置
        InfomationViewController *infomationVC = [[InfomationViewController alloc]init];
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:infomationVC animated:YES];
        self.hidesBottomBarWhenPushed= NO;
    }
    
    
    
}



#pragma mark - height setter
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }else if (indexPath.section == 1){
        return 90;
    }else{
        return 44;
    }
}

#pragma  mark - 判空
-(NSString *)Judgetheempty:(NSString *)string{
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }else return string;
}

//删除字典的空箱
- (NSDictionary *)deleteNull:(NSDictionary *) dic{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in dic.allKeys) {
        
        if ([[dic objectForKey:keyStr] isEqual:[NSNull null]]) {
            
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            
            [mutableDic setObject:[dic objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}

@end
