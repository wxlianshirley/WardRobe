//
//  ActivityCenterViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/16.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "ActivityCenterViewController.h"
#import "ActivityCenterTableViewCell.h"
#import "ActivityCenterModel.h"



static NSString * const ActivityCenterViewCell_identifier = @"ActivityCenterViewCell_identifier";

@interface ActivityCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;//原始数据
@property(nonatomic,strong)NSMutableArray *titleArray;//通过时间排序的数组
@property(nonatomic,assign)int page;

@end

@implementation ActivityCenterViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];

    }
    return _dataArray;
}

-(void)loadView{
    [super loadView];
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    _tableView.estimatedRowHeight = 40;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    [_tableView registerClass:[ActivityCenterTableViewCell class] forCellReuseIdentifier:ActivityCenterViewCell_identifier];
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    //下拉刷新，上拉加载
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataInHeader)];
    [_tableView.mj_header beginRefreshing];
    
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataInFooter)];

    
    
}
//下拉刷新
-(void)loadDataInHeader{
    [self.dataArray removeAllObjects];
    self.page = 1;
    [XLAFnetworking postWithURL:ActivityCenter params:@{@"page":@"1",@"limit":@"10"} progressBlock:nil successBlock:^(NSDictionary *response) {
        
        BOOL status = response[@"status"];
        if(!status){
            return;
        }
       
        NSArray *infoArray = response[@"list"];
        [infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dicInfo = (NSDictionary*)obj;
            ActivityCenterModel *model = [ActivityCenterModel yy_modelWithJSON:dicInfo];
           
            [self.dataArray addObject:model];
           
  
            
        }];
        //对数据排序归类
        [self sortData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView.mj_header endRefreshing];
            
            [self.tableView reloadData];
        });
    } failBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        XLEmptyView *emptyView = [[[NSBundle mainBundle] loadNibNamed:@"XLEmptyView" owner:nil options:nil]lastObject];
        [emptyView initWithEmptyImage:[UIImage imageNamed:@"NoNetWork"] withEmptyTitle:@"网络异常，请检查网络" withEmptyButtonTitle:@"重新加载" withEmptyButton:^{
            [self.tableView.mj_header beginRefreshing];
            [emptyView removeFromSuperview];
        }];
        [self.view addSubview:emptyView];
        [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.equalTo(self.tableView);
        }];
        
    }];
}

//上拉加载
-(void)loadDataInFooter{
    self.page +=1;
    [XLAFnetworking postWithURL:ActivityCenter params:@{@"page":[NSString stringWithFormat:@"%d",self.page],@"limit":@"10"} progressBlock:nil successBlock:^(NSDictionary *response) {
        
        
        BOOL status = response[@"status"];
        if(!status){
            return;
        }
        
        
        NSArray *infoArray = response[@"list"];
        if (infoArray.count<=0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        [infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dicInfo = (NSDictionary*)obj;
            ActivityCenterModel *model = [ActivityCenterModel yy_modelWithJSON:dicInfo];
            
            [self.dataArray addObject:model];
            
        }];
        
        [self sortData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        });
    } failBlock:^(NSError *error) {
        
    }];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //监听数据源，判断是否显示 暂无数据
    
    return _titleArray.count;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *arr = _titleArray[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityCenterViewCell_identifier];
    
    NSMutableArray *dateArray = _titleArray[indexPath.section];
    ActivityCenterModel *model = dateArray[indexPath.row];
    if(indexPath.row == 0){
        cell.timeLabel.hidden = false;
    }else{
        cell.timeLabel.hidden = true;
    }
    cell.model = model;
    

    
    
    return cell;
}

//按照时间对数据进行分组排序
-(void)sortData{
        //使用NSSet,时间去重
    NSMutableSet *set = [NSMutableSet set];
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ActivityCenterModel *model = obj;
        NSString *timeStr = [self transformDateToString:model.createTime];
       
       
        [set addObject:timeStr];
        
    }];
    NSArray *userArray = [set allObjects];
   
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:false];//true 升序，false 降序
    //按照时间的降序
    NSArray *myArray = [userArray sortedArrayUsingDescriptors:@[sd1]];
    _titleArray = [NSMutableArray array];
    [myArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //有多少种时间，为分配多少的数组，存取时间相同的数据
        NSMutableArray *arr = [NSMutableArray array];
        [_titleArray addObject:arr];
    }];

    
    //遍历self.dataArray取其中每个数据的日期看看与myArray中时间匹配的数据，装在_titleArray中对应的数组中
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ActivityCenterModel *model = obj;
        NSString *currentSrt = [self transformDateToString:model.createTime];//转换后的时间
        
        for (NSString *str in myArray) {
            
            if([str isEqualToString:currentSrt]){
                NSMutableArray *arr = [_titleArray objectAtIndex:[myArray indexOfObject:str]];
                [arr addObject:model];
            }
        }
        
    }];
    
    
    //按照详细时间（24小时）再进行排序
//    [_titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSMutableArray *arr = obj;
//        if (arr.count>1) {
//            [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//                ActivityCenterModel *model1 = (ActivityCenterModel*)obj1;
//                ActivityCenterModel *model2 = (ActivityCenterModel*)obj2;
//
//                NSArray *timeArr1 = [[[model1.createTime componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"];
//                NSString *timeStr1 = [NSString stringWithFormat:@"%@%@%@",timeArr1[0],timeArr1[1],timeArr1[2]];
//                int num1 = [timeStr1 intValue];
//
//                NSArray *timeArr2 = [[[model2.createTime componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"];
//                NSString *timeStr2 = [NSString stringWithFormat:@"%@%@%@",timeArr2[0],timeArr2[1],timeArr2[2]];
//                int num2 = [timeStr2 intValue];
//
//                if (num1<num2) {
//                    return NSOrderedDescending;
//                }
//                return NSOrderedAscending;
//            }];
//
//
//        }
//    }];
    
    
}
-(NSString *)transformDateToString:(NSString *)dateStr{
    NSString *transformStr;
    NSString *timeStr = [[dateStr componentsSeparatedByString:@" "] firstObject];
    NSArray *dateArr = [timeStr componentsSeparatedByString:@"-"];
    transformStr = [NSString stringWithFormat:@"%@%@%@",dateArr[0],dateArr[1],dateArr[2]];
    
    return transformStr;
}


@end
