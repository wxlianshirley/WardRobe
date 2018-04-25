//
//  InfomationViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/14.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

#import<Photos/Photos.h>

#import "InfomationViewController.h"
#import "InfomationTableViewCell.h"
#import "InfomationPhotoTableViewCell.h"

#import "GSPickerView.h"
#import "XLDatePickerView.h"
#import "SetPhoneViewController.h"
#import "ChangePhoneOrPassworldViewController.h"
#import "LoginViewController.h"
#import "ManageWeChatOrAlipayViewController.h"

static NSString * const InfomationtableViewPhotoCell_identifier = @"InfomationtableViewPhotoCell_identifier";
static NSString * const InfomationtableViewCell_identifier = @"InfomationtableViewCell_identifier";


@interface InfomationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,PhoneNumChangeDelegate>
{
    UIImage *image;
    NSArray *array;//账户设置cell的titleLabel数据
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(weak,nonatomic)UIImagePickerController *imagePicker;//图片选择
//@property (nonatomic,strong)GSPickerView *pickerView;//生日选择
@property(nonatomic,strong)XLDatePickerView *datePickerView;//生日选择

@property(nonatomic,copy)NSString *userPhotoUrl;//头像
@property(nonatomic,copy)NSString *userName;//昵称
@property(nonatomic,copy)NSString *userPhone;//电话
@property(nonatomic,assign)NSString* userSex;//性别
@property(nonatomic,copy)NSString *userBirthday;//生日

@property(nonatomic,copy)NSString *alipayAccount;//支付宝账户
@property(nonatomic,copy)NSString *alipayName;//支付宝姓名
@property(nonatomic,copy)NSString *weixinPayName;//微信钱包姓名
@property(nonatomic,copy)NSString *weixinPayPhone;//微信钱包手机号
@property(nonatomic,copy)NSString *passworld;//密码

@property(nonatomic,strong)NSDictionary *dataDic;//信息总数据

@end

@implementation InfomationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self _loadData];
    self.hidesBottomBarWhenPushed = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户设置";
    [self _loadTableView];
}


-(void)_loadData{

    // 读取账户
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"];
    self.dataDic = userInfoDic;
 
    self.userPhotoUrl = [self Judgetheempty: self.dataDic[@"avatar"]];
    self.userName = [self Judgetheempty: self.dataDic[@"username"]];
    
//    self.userPhone = [self Judgetheempty: self.dataDic[@"phone"]];
    if (self.userPhone.length>=11) {
        self.userPhone = [self Judgetheempty:[ self.dataDic[@"phone"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
    }else{
        self.userPhone = [self Judgetheempty: self.dataDic[@"phone"]];
    }
    
    self.userBirthday = [self Judgetheempty: self.dataDic[@"birthday"]];
    self.alipayAccount = [self Judgetheempty: self.dataDic[@"alipayAccount"]];
    self.alipayName = [self Judgetheempty: self.dataDic[@"alipayName"]];
    self.weixinPayName = [self Judgetheempty: self.dataDic[@"weixinPayName"]];
    self.weixinPayPhone = [self Judgetheempty: self.dataDic[@"weixinPayPhone"]];
    
    self.passworld = [XLJudgeTheempty Judgetheempty:self.dataDic[@"password"]];
    
    if ([self.passworld isEqualToString:@""]) {
        array = @[@[@"头像",@"昵称",@"手机号",@"性别",@"生日"],@[@"管理微信钱包",@"管理支付宝"],@[@"退出登录"]];
    }else{
        array = @[@[@"头像",@"昵称",@"手机号",@"性别",@"生日"],@[@"管理微信钱包",@"管理支付宝",@"修改密码"],@[@"退出登录"]];
    }
    
    NSInteger sex = [self.dataDic[@"gender"] integerValue];
    if (sex == 1) self.userSex = @"男";
    else if (sex == 2) self.userSex = @"女";
    else if (sex == 0) self.userSex = @"未设置";
    else self.userSex = [NSString stringWithFormat:@"%ld",(long)sex];
    [_tableView reloadData];
}

-(void)_loadTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"InfomationPhotoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:InfomationtableViewPhotoCell_identifier];
    
    [_tableView registerNib:[UINib nibWithNibName:@"InfomationTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:InfomationtableViewCell_identifier];
}

#pragma mark - delegate ddatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = array[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSMutableArray *detailarray = [[NSMutableArray alloc]initWithArray: @[self.userPhotoUrl,self.userName,self.userPhone,self.userSex ,self.userBirthday]];
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *subTitle = nil;
    if (indexPath.section == 0) {
        subTitle = detailarray[indexPath.row];
    }
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        InfomationPhotoTableViewCell *photoCell = [tableView dequeueReusableCellWithIdentifier:InfomationtableViewPhotoCell_identifier];
        photoCell.titlelable.text = array[indexPath.section][indexPath.row];
        photoCell.imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [photoCell.imgView sd_setImageWithURL:[NSURL URLWithString: self.userPhotoUrl] placeholderImage:[UIImage imageNamed:@"userPhoto"]];
        return photoCell;
    }else {
        
        InfomationTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:InfomationtableViewCell_identifier];
        cell1.titlelable.text = array[indexPath.section][indexPath.row];

        if (indexPath.section == 0) {
            cell1.detaillabel.text = detailarray[indexPath.row];
            if ([cell1.detaillabel.text isEqualToString:@"未设置"]) {
                cell1.detaillabel.textColor = Color_Blue;
            }else{
                cell1.detaillabel.textColor = [UIColor blackColor];
            }
        }
        if (indexPath.section == 2) {
            cell1.titlelable.textColor = BaseRedColor;
        }
        if (indexPath.section == 1 || indexPath.section == 2) {
            [cell1.detaillabel removeFromSuperview];
        }
        return cell1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }else{
        return 44;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
//select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //个人信息。。。
        if (indexPath.row == 0) {
            //头像
            [self _setPhoto];
        }else if (indexPath.row == 1){
            //昵称
            [self _setName];
        }else if (indexPath.row == 2){
            //手机号
            /*
            SetPhoneViewController *phoneVC;
            phoneVC = [[SetPhoneViewController alloc]init];
            phoneVC.delegate = self;
          if ([self.userPhone rangeOfString:@"1"].location == NSNotFound) {
                phoneVC.pagetype = UserSetTelephone;
            }else{
                phoneVC.pagetype = UserChangePhone;
            }
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:phoneVC animated:YES];
            */
            UIViewController *VC;
            if ([self.userPhone rangeOfString:@"1"].location == NSNotFound) {
                SetPhoneViewController *phoneVC = [SetPhoneViewController new ];
                phoneVC.delegate = self;
                phoneVC.pagetype = UserSetTelephone;
                VC = phoneVC;
            }else{
                ChangePhoneOrPassworldViewController *changePhoneVC = [ChangePhoneOrPassworldViewController new];
                changePhoneVC.ischangeTelephone = YES;
                changePhoneVC.telephoneNum = self.userPhone;
                VC = changePhoneVC;
            }
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.row == 3){
            //性别
            [self _setSex];
        }else{
            //生日
            [self _setBirthday];
        }

    }else if (indexPath.section == 1){
        //支付信息
        if (indexPath.row == 0) {
            //微信钱包
            ManageWeChatOrAlipayViewController  *manageWeChatOrAlipayVC = [[ManageWeChatOrAlipayViewController alloc]init];
            manageWeChatOrAlipayVC.isWeChatManager = YES;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:manageWeChatOrAlipayVC animated:YES];
        }if (indexPath.row == 1) {
            //支付宝钱包
            ManageWeChatOrAlipayViewController  *manageWeChatOrAlipayVC = [[ManageWeChatOrAlipayViewController alloc]init];
            manageWeChatOrAlipayVC.isWeChatManager = NO;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:manageWeChatOrAlipayVC animated:YES];
        }else if (indexPath.row == 2){
            //修改密码
//            SetPhoneViewController *phoneVC = [[SetPhoneViewController alloc]init];
//            phoneVC.pagetype = UserChangePassword;
//            self.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:phoneVC animated:YES];
            
            ChangePhoneOrPassworldViewController *changePhoneVC = [ChangePhoneOrPassworldViewController new];
            changePhoneVC.ischangeTelephone = NO;
            changePhoneVC.telephoneNum = self.userPhone;
            [self.navigationController pushViewController:changePhoneVC animated:YES];
            
            
        }else {}
        
    }else{
        //退出登录
        if ([[self Judgetheempty: self.userPhone] isEqualToString:@""]) {
            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您尚未绑定手机号，可能导致账号丢失无法找回，建议绑定手机号后再尝试退出操作" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"快速绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //手机号
                SetPhoneViewController *phoneVC;
                phoneVC = [[SetPhoneViewController alloc]init];
                __weak typeof(self) wself = self;
                phoneVC.ChangeOrSetPhoneBlock = ^(NSString * phone) {
                    wself.userPhone = [[wself Judgetheempty: phone] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                    [wself.tableView reloadData];
                };
                if ([self.userPhone rangeOfString:@"1"].location == NSNotFound) {
                    phoneVC.pagetype = UserSetTelephone;
                }else{
                    phoneVC.pagetype = UserChangePhone;
                }
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:phoneVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                
            }]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
                [self dismissViewControllerAnimated:YES completion:nil];
                //创建
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"telephone"];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults removeObjectForKey:@"expire"];
                [userDefaults removeObjectForKey:@"token"];
                NSNotification *notification = [NSNotification notificationWithName:@"exitLoginNotification" object:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notification];
            }]];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        }else{
            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"退出登录后，您将不能获得阅读收益，您确定退出吗？" preferredStyle:UIAlertControllerStyleAlert];  
            [alertVC addAction:[UIAlertAction actionWithTitle:@"暂不退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
                [self dismissViewControllerAnimated:YES completion:nil];
                //创建
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"telephone"];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults removeObjectForKey:@"expire"];
                [userDefaults removeObjectForKey:@"token"];
                NSNotification *notification = [NSNotification notificationWithName:@"exitLoginNotification" object:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notification];
            }]];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - cell的点击更新事件
//头像
-(void)_setPhoto{
    UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
        
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 进入相册
        [self openPhotoLibrary];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//昵称
-(void)_setName{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"请输入昵称(2-10位)" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction: [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

        //得到文本信息
        for(UITextField *textField in alertController.textFields){
            NSLog(@"text = %@", textField.text);
            if (textField.text.length >= 2 && textField.text.length <= 10) {
                //拿到name，显示在界面上，发起网络请求
                [self XLAfnetworking:@"username" WithContent:textField.text WithCorrectBack:^(bool isCorrect) {
                    if (isCorrect) {
                        self.userName = textField.text;
                        // 读取账户
                        NSMutableDictionary *userInfoDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"]mutableCopy];
                        [userInfoDic setValue:self.userName forKey:@"username"];
                        [[NSUserDefaults standardUserDefaults]setObject:userInfoDic forKey:@"userInfoDic"];
                    }
                }];
                [_tableView reloadData];
            }else{
                if ([textField.text length] > 10)  textField.text = [textField.text substringToIndex:10];
                UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"昵称长度需在2～10位" preferredStyle:UIAlertControllerStyleAlert];
                [alertController1 addAction:  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertController1 animated:YES completion:nil];
            }
        }
    }]];
    [alertController addAction:  [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"昵称";
        textField.borderStyle = UITextBorderStyleNone;
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

//性别
-(void)_setSex{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"男");
        //发起网络请求提交数据：性别男
        [self XLAfnetworking:@"gender" WithContent:@"1" WithCorrectBack:^(bool isCorrect) {
            if (isCorrect) {
                self.userSex = @"男";
                // 读取账户
//                NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"];
//                [userInfoDic setValue:[NSNumber numberWithInt:1] forKey:@"gender"];
                // 读取账户
                NSMutableDictionary *userDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"]mutableCopy];
                [userDic setValue:[NSNumber numberWithInt:1] forKey:@"gender"];
                [[NSUserDefaults standardUserDefaults]setObject:userDic forKey:@"userInfoDic"];
            }
        }];
        [_tableView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"女");
        //发起网络请求提交数据：性别男女
        [self XLAfnetworking:@"gender" WithContent:@"2"WithCorrectBack:^(bool isCorrect) {
            if (isCorrect) {
                self.userSex = @"女";
                // 读取账户
                NSMutableDictionary *userDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"]mutableCopy];
                [userDic setValue:[NSNumber numberWithInt:2] forKey:@"gender"];
                [[NSUserDefaults standardUserDefaults]setObject:userDic forKey:@"userInfoDic"];
            }
        }];
        [_tableView reloadData];
    }]];
    [alertController addAction:  [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

//生日
-(void)_setBirthday{
    _datePickerView = [[XLDatePickerView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_datePickerView];
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    __weak typeof(self) Wself = self;
    _datePickerView.SelectBirthDayDateBlock = ^(NSString * DateStr) {
        if (![Wself.userBirthday isEqualToString: DateStr]) {
            [Wself XLAfnetworking:@"birthday" WithContent:DateStr WithCorrectBack:^(bool isCorrect) {
                if (isCorrect) {
                    Wself.userBirthday = DateStr;
                    // 读取账户
                    NSMutableDictionary *userInfoDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"]mutableCopy];
                    [userInfoDic setValue:DateStr forKey:@"birthday"];
                    [[NSUserDefaults standardUserDefaults]setObject:userInfoDic forKey:@"userInfoDic"];
                }
            }];
            [Wself.tableView reloadData];
        }else{
            NSLog(@"未修改生日，不上传修改申请");
        }
        
    };
    
    /*
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.view.bounds];
    }
    NSString *str = @"2017-01-01";
    if ([self.userBirthday containsString:@"-"]) {
        str = self.userBirthday;
    }
    [self.pickerView appearWithTitle:@"---" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:str sureAction:^(NSInteger path, NSString *pathStr) {
//        NSLog(@"%ld   %@",path,pathStr);
        if (![self.userBirthday isEqualToString: pathStr]) {
            [self XLAfnetworking:@"birthday" WithContent:pathStr];
            if ([self XLAfnetworking:@"birthday" WithContent:pathStr]) {
                self.userBirthday = pathStr;
            }
            [_tableView reloadData];
        }else{
            NSLog(@"未修改生日，不上传修改申请");
        }
    } cancleAction:^{
        
    }];
     */
}



#pragma mark - imagePickerController
/**
 
 *  调用照相机
 
 */

- (void)openCamera

{

    
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        NSLog(@"----------------------------------没有摄像头------------------------------");
        UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:@"请在iPhone的“设置-隐私”选项中，允许大众看点访问你的摄像头" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController1 addAction:  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController1 animated:YES completion:nil];
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES; //可编辑
        //判断是否可以打开照相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            //摄像头
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else NSLog(@"没有摄像头");
    }
}


/**
 
 *  打开相册
 
 */

-(void)openPhotoLibrary{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        //无权限  这个时候最好给个提示，用户点击是就跳转到应用的权限设置内 用户动动小手即可允许权限
        NSLog(@"不能打开相册");
    }
    

// 进入相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.navigationBar.translucent = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else NSLog(@"不能打开相册");
}



// imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        UIImage * img = [info objectForKey:UIImagePickerControllerEditedImage];///原图
//        NSData *data;
//        data = UIImageJPEGRepresentation(img, 0.01);
//        if (UIImagePNGRepresentation(img) == nil)
//        else data = UIImagePNGRepresentation(img);
        
//        image = [UIImage imageWithData:data];
        image = [self compressImageQuality:img toByte:640];
        
        //网络请求上传图片
        [self XLImageAfnetworking:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma  mark - 判空
-(NSString *)Judgetheempty:(NSString *)valueString{
    if ([valueString isKindOfClass:[NSString class]] && ![valueString isKindOfClass:[NSNull class]] && ![valueString isEqualToString:@""] && valueString != nil) {
        return valueString;
    }else return @"未设置";
}


#pragma  mark - 修改资料后的网络请求
-(BOOL)XLAfnetworking:(NSString *)key WithContent:(id)content WithCorrectBack:(void (^)(bool isCorrect))currectBlock{
   __block BOOL isAFnOK;
    
    NSDictionary *parmas = @{@"key":key,@"value":content};
    [XLAFnetworking postWithURL:UpdateInfo params:parmas progressBlock:nil successBlock:^(NSDictionary *response) {
        if (!response[@"status"]) {
            //弹出上传失败
            isAFnOK = NO;
            currectBlock(isAFnOK);
        }else{
            NSLog(@"**************************修改成功******************%@",response);
            // Make toast
            [self.view makeToast:@"   修改成功   " duration:1.0 position:CSToastPositionBottom];
            isAFnOK = YES;
            currectBlock(isAFnOK);
            [_tableView reloadData];
        }
    } failBlock:^(NSError *error) {
        
    }];
    return isAFnOK;
}

#pragma  mark - 修改资料后的网络请求(照片)
-(void)XLImageAfnetworking:(UIImage *)imageName{
//   NSData * data = UIImageJPEGRepresentation(imageName, 0.7);
    NSDictionary *parmas = @{@"type":@"AVATAR"};
    
    [XLAFnetworking postWithImageArray:@[imageName] WithURL:UploadFile params:parmas progressBlock:nil successBlock:^(NSDictionary *response) {
        NSLog(@"response:%@",response);
        if (!response[@"status"]) {
            //弹出上传失败
            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:nil message:response[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            
        }else{
            if ([response[@"code"] integerValue] == 200) {
                NSLog(@"**************************上传文件成功，拿到头像URL******************%@",response);
                NSString *photoURL = response[@"url"];
                //已获取图片URL，上传图片
                [self XLAfnetworking:@"avatar" WithContent:photoURL WithCorrectBack:^(bool isCorrect) {
                    if (isCorrect) {
                        self.userPhotoUrl = photoURL;
                        // 读取账户
                        NSMutableDictionary *userInfoDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"]mutableCopy];
                        [userInfoDic setValue:self.userPhotoUrl forKey:@"avatar"];
                        [[NSUserDefaults standardUserDefaults]setObject:userInfoDic forKey:@"userInfoDic"];
                    }
                }];
            }else{
                //非200
            }
        }
    } failBlock:^(NSError *error) {
        NSLog(@"**************************上传文件失败******************%@",error);
    }];
 
}

//二分法压缩图片
- (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    return resultImage;
}

#pragma mark - phoneNumberChangeDelegate  修改资料后的代理
-(void)SetPhoneBack:(NSString *)PhoneNumber{
    
    self.userPhone = [[self Judgetheempty: PhoneNumber] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.passworld = @"yes";
    array = @[@[@"头像",@"昵称",@"手机号",@"性别",@"生日"],@[@"管理微信钱包",@"管理支付宝",@"修改密码"],@[@"退出登录"]];
    [self.tableView reloadData];
}


@end
