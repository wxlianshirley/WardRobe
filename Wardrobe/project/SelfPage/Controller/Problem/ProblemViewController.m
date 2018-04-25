//
//  ProblemViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/20.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "ProblemViewController.h"
#import "ProblemDetailViewController.h"
#import "ProblemCell.h"
#import "ProblemListModel.h"

#define ProblemtableViewCell @"ProblemtableViewCell"
@interface ProblemViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSArray *dataArr;
@end

@implementation ProblemViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"常见问题";
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [NSArray array];
    
    [self _loadData];
    [self _loadTableView];
}
-(void)_loadData{
    NSInteger page = 1;
    NSInteger limit = 10;
    NSDictionary *parmas = @{@"page":[NSNumber numberWithInteger:page],@"limit":[NSNumber numberWithInteger:limit]};
    [XLAFnetworking postWithURL:FAQ_list params:parmas progressBlock:nil successBlock:^(NSDictionary *response) {
        if (response[@"status"]) {
            NSLog(@"%@",response);
            NSArray *listArray = response[@"list"];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in listArray) {
                ProblemListModel *model = [ProblemListModel new];
                model.listId = [dic[@"id"] integerValue];
                model.title = dic[@"title"];
                [arr addObject:model];
            }
            self.dataArr = arr;
            [_tableView reloadData];
        }
    } failBlock:^(NSError *error) {
        
    }];
}

-(void)_loadTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
//    [_tableView registerClass:[ProblemCell class] forCellReuseIdentifier:ProblemtableViewCell];
    [_tableView registerNib:[UINib nibWithNibName:@"ProblemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ProblemtableViewCell];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:ProblemtableViewCell];
    
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ProblemtableViewCell];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ProblemListModel *model = [ProblemListModel new];
    model = [self.dataArr objectAtIndex:indexPath.row];
    cell.questionLabel.text = model.title;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProblemListModel *model = [ProblemListModel new];
    model = [self.dataArr objectAtIndex:indexPath.row];
    
    ProblemDetailViewController *detailVC = [[ProblemDetailViewController alloc]init];
    detailVC.navigationItem.title = model.title;
    detailVC.listId = model.listId;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}





//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return nil;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}











@end
