//
//  YHProfileApplicationViewViewController.m
//  WanCai
//
//  Created by yh_swjtu on 16/7/30.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileApplyViewViewController.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "YHJobApplyTool.h"
#import "YHMyJobApply.h"
#import "YHResultItem.h"
#import "YHApplyTableViewCell.h"
#import "YHJobsTool.h"
#import "YHJobs.h"
#import "YHIndusToImageTool.h"
#import "YHCareFromDetailViewController.h"

static int pageIndex;

@interface YHProfileApplyViewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *myApplyList;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) UILabel *footer;

@end

@implementation YHProfileApplyViewViewController

- (UILabel *) footer{
    if(!_footer){
        _footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        _footer.font = [UIFont systemFontOfSize:15];
        _footer.textAlignment = NSTextAlignmentCenter;
    }
    return _footer;
}

- (NSMutableArray *)myApplyList {
    if (!_myApplyList) {
        _myApplyList = [NSMutableArray array];
    }
    return _myApplyList;
}

- (NSString *)userId{
    if (!_userId) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *userId = [defaults objectForKey:@"userId"];
        _userId = (NSString *)userId;
    }
    return _userId;
}

- (UITableView *) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 1;
    self.tableView.tableFooterView = self.footer;
    
    [self setUpStyle];
    [self setUpRefresh];
}

- (void) setUpStyle{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.title = @"我的申请";
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = YHGray;
    //    self.tableView.sectionHeaderHeight = 20;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.rowHeight = 90;

}


#pragma mark - MJ_Refresh
- (void)setUpRefresh{
    // 设置回调
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self setRefreshHeader:header andFooter:footer];
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    
    // 进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

- (void) setRefreshHeader:(MJRefreshNormalHeader *)header
                andFooter:(MJRefreshAutoNormalFooter *)footer{
    
    header.lastUpdatedTimeText = ^ NSString *(NSDate *date){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"MM-dd HH:mm";
        return [NSString stringWithFormat:@"上次更新时间：%@", [format stringFromDate:date]];
    };
    [header setTitle:@"下拉以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    footer.refreshingTitleHidden = NO;
}


#pragma mark - tableView DateSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myApplyList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHApplyTableViewCell *cell = [YHApplyTableViewCell cellFromTableView:self.tableView withIdentifier:@"applyTableListCell"];
    YHMyJobApply *jobApply = self.myApplyList[indexPath.row];
    cell.myJobApply = jobApply;
    cell.iconName = [YHIndusToImageTool getIconWithIndustry:jobApply.WorkLocation];
    return cell;
}

#pragma mark - ERROR HUD
- (void)showErrorWithHUD:(NSString *)msg{
    
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

#pragma mark - load&refresh Data
- (void)loadData {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        return;
    }
    NSString *pageIdx = [NSString stringWithFormat:@"%i",pageIndex];
    [YHJobApplyTool getMyJobApplyList:^(YHResultItem *result) {
        for (YHMyJobApply *myJobApply in result.rows) {
            if(myJobApply){
                [YHJobsTool getJobInfo:^(YHResultItem *result) {
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                    YHJobs *jobs = [result.rows firstObject];
                    if(jobs){
                        myJobApply.WorkLocation = jobs.IndustryName;
                        [self.myApplyList addObject:myJobApply];
                        NSIndexPath *path = [NSIndexPath indexPathForRow:self.myApplyList.count - 1 inSection:0];
                        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
                        [self.footer setText:[NSString stringWithFormat:@"共加载%d条申请", (int)self.myApplyList.count]];
                    }
                } withJobId:myJobApply.JobId];
            }
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.footer setText:[NSString stringWithFormat:@"共加载%d条申请", (int)self.myApplyList.count]];
        pageIndex += 1;
    } withuserId:self.userId pagesize:@"10" pageindex:pageIdx];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    YHMyJobApply *com = self.myApplyList[indexPath.row];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    hud.label.text = @"加载中...";
    [hud showAnimated:YES];
    
    [YHJobsTool getJobInfo:^(YHResultItem *result) {
        YHJobs *item = [result.rows firstObject];
        //此处需要修改，简历id不能写死，此处写死只为了测试用
        YHCareFromDetailViewController *detail = [YHCareFromDetailViewController detailInfoViewWithJob:item andResumeId:com.ResumeId];
        [hud hideAnimated:YES];
        [self.navigationController pushViewController:detail animated:YES];
    } withJobId:com.JobId];
}



@end
