//
//  YHTalkViewController.m
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTalkViewController.h"
#import "MJRefresh.h"
#import "YHTalkHeaderTableViewCell.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "YHAnswerModel.h"
#import "YHQATableViewCell.h"


@interface YHTalkViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViews;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation YHTalkViewController

- (NSMutableArray *) array{
    if(!_array){
        _array = [NSMutableArray array];
    }
    return _array;
}

- (UITableView *) tableViews{
    if(!_tableViews){
        CGFloat width = self.view.frame.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height - 64 - 40 - 49;
        _tableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStyleGrouped];
        _tableViews.dataSource = self;
        _tableViews.delegate = self;
    }
    return _tableViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableViews];
    
    self.tableViews.mj_header = [self getHeader];
    self.tableViews.mj_footer = [self getFooter];
    
    [self.tableViews.mj_header beginRefreshing];
}

- (MJRefreshAutoNormalFooter *) getFooter{
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    footer.refreshingTitleHidden = NO;
    return footer;
}

- (void) viewDidDisappear:(BOOL)animated{
    
    [self.tableViews.mj_header endRefreshing];
    
    [self.tableViews.mj_footer endRefreshing];
}

- (MJRefreshNormalHeader *) getHeader{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    header.lastUpdatedTimeText = ^ NSString* (NSDate *date){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"MM-dd HH:mm";
        return [NSString stringWithFormat:@"上次刷新时间：%@", [format stringFromDate:date]];
    };
    [header setTitle:@"下拉以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    return header;
}

- (void) loadMoreData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showErrorWithHUD:@"请检查网络连接"];
        [self.tableViews.mj_footer endRefreshing];
        [self.tableViews.mj_header endRefreshing];
        return;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"talktest.plist" ofType:nil];
    NSArray *temp = [NSArray arrayWithContentsOfFile:path];
    for(NSDictionary *dic in temp){
        YHAnswerModel *model = [YHAnswerModel modelWithDic:dic];
        [self.array addObject:model];
    }
    [self.tableViews.mj_header endRefreshing];
    [self.tableViews.mj_footer endRefreshing];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.tableViews reloadData];
}

- (void) showErrorWithHUD:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    [hud hideAnimated:YES afterDelay:1];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aio_face_store_button_canceldown.png"]];
    hud.label.text = msg;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 1;
    }else{
        return self.array.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"topic_identifier1";
    static NSString *identifier1 = @"topic_identifier2";
    if(indexPath.section == 0){
        NSArray *temparray = @[@{@"iconName":@"ad_benke", @"titleName":@"管理"}, @{@"iconName":@"ad_guanggao", @"titleName":@"广告"},@{@"iconName":@"ad_guanli", @"titleName":@"金融"},@{@"iconName":@"ad_ios", @"titleName":@"ios开发"},@{@"iconName":@"ad_ruanjian", @"titleName":@"软件"}];
        YHTalkHeaderTableViewCell *cell = [YHTalkHeaderTableViewCell cellFromTableView:tableView withReuseIdentifier:identifier1 andArray:temparray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        YHQATableViewCell *cell = [YHQATableViewCell cellFromTableView:tableView withReuseIdentifier:identifier];
        YHAnswerModel *model = self.array[indexPath.row];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 100;
    }
    return 85;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 5;
    }
    return 35;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return @"问答";
    }
    return @"";
}

@end
