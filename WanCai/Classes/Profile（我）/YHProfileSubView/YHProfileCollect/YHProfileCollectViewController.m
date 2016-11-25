//
//  YHProfileCollectViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/6/6.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileCollectViewController.h"
#import "YHFavoriteJobTool.h"
#import "MJRefresh.h"
#import "YHMyFavoriteJob.h"
#import "YHResultItem.h"
#import "YHJobsTool.h"
#import "YHJobs.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "YHReturnMsg.h"
#import "YHCollectDetailJobInfoViewController.h"

#import "YHSearchTableViewCell.h"
#import "YHIndusToImageTool.h"


@interface YHProfileCollectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *favouriteJobs;
@property (nonatomic, assign) int size;
@property (nonatomic, strong) UILabel *footView;

@end

@implementation YHProfileCollectViewController

- (NSMutableArray *) favouriteJobs{
    if(!_favouriteJobs){
        _favouriteJobs = [NSMutableArray array];
    }
    return _favouriteJobs;
}

- (UILabel *) footView{
    if(!_footView){
        _footView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _footView.textAlignment = NSTextAlignmentCenter;
        _footView.font = [UIFont systemFontOfSize:14];
        [_footView setTextColor:[UIColor grayColor]];
    }
    return _footView;
}

#pragma mark - Life Cycel
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YHGray;
    self.title = @"职位收藏";
    [self.view addSubview: self.tableView];
    self.tableView.tableFooterView = self.footView;
    self.size = 1;
    // 设置回调
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    [self setRefreshHeader:header andFooter:footer];
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    
    // 进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationItem.rightBarButtonItem = nil;
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



#pragma mark - UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _favouriteJobs.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"favourite_collection";
    YHSearchTableViewCell *cell = [YHSearchTableViewCell cellFromTableView:tableView withIdentifier:identifier];
    //注意，此处赋值顺序不能改变，cell中的其他控件的位置均是基于iconview得到的，因此必须先初始化icon
    YHJobs *job = self.favouriteJobs[indexPath.row];
    cell.iconName = [YHIndusToImageTool getIconWithIndustry:job.IndustryName];
    cell.job = job;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    YHMyFavoriteJob *Job =  self.favouriteJobs[indexPath.row];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    hud.label.text = @"加载中...";
    [hud showAnimated:YES];
    
    
    [YHJobsTool getJobInfo:^(YHResultItem *result) {
        YHJobs *item = [result.rows firstObject];
        YHCollectDetailJobInfoViewController *detail = [YHCollectDetailJobInfoViewController detailInfoViewWithJob:item];
        [hud hideAnimated:YES];
        [self.navigationController pushViewController:detail animated:YES];
    } withJobId:Job.JobId];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    if(editingStyle == UITableViewCellEditingStyleDelete){
        //有问题，无法删除收藏职位
        YHJobs *Job =  self.favouriteJobs[indexPath.row];
        [YHJobsTool deleteMyJobFavoriteById:^(YHReturnMsg *result) {
            if([result.msg isEqualToString:@"删除失败"]){
                [self showErrorWithHUD:@"收藏删除失败"];
            }else{
                [self.favouriteJobs removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                self.footView.text = [NSString stringWithFormat:@"共加载%d条收藏记录", (int)self.favouriteJobs.count];
            }
        } withuserId:Job.JobId];
    }
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


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除收藏";
}
#pragma mark - refresh load data
- (void) reloadData {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        return;
    }
    
    //此段代码使tableView中的数据呈现出有序排列
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [YHFavoriteJobTool getMyJobFavoriteList:^(YHResultItem *result) {
        for(YHMyFavoriteJob *company in result.rows){
            
            [YHJobsTool getJobInfo:^(YHResultItem *result) {
                YHJobs * jobs = [result.rows firstObject];
                if(jobs){
                    
                    [self.favouriteJobs addObject:jobs];
                    NSIndexPath *path = [NSIndexPath indexPathForRow:self.favouriteJobs.count - 1 inSection:0];
                    
                    //                    for(int i = 0; i < self.favouriteJobs.count; i ++){
                    //                        YHJobs *temp = self.favouriteJobs[i];
                    //                        if(![self compareOfDate:temp.PublishDate withDate:jobs.PublishDate] || (i == (self.favouriteJobs.count - 1))){
                    //                            if(i == (self.favouriteJobs.count - 1) && [self compareOfDate:temp.PublishDate withDate:jobs.PublishDate]){
                    //                                [self.favouriteJobs addObject:jobs];
                    //                                path = [NSIndexPath indexPathForRow:self.favouriteJobs.count - 1 inSection:0];
                    //                            }else{
                    //                                [self.favouriteJobs insertObject:jobs atIndex:i];
                    //                                path = [NSIndexPath indexPathForRow:i inSection:0];
                    //                            }
                    //                            break;
                    //                        }
                    //
                    //                    }
                    //                    if(self.favouriteJobs.count == 0){
                    //                        [self.favouriteJobs addObject:jobs];
                    //                        path = [NSIndexPath indexPathForRow:self.favouriteJobs.count - 1 inSection:0];
                    //                    }
                    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
                    self.footView.text = [NSString stringWithFormat:@"共加载%d条收藏记录",(int)self.favouriteJobs.count];
                }
            } withJobId:company.JobId];
        }
        self.size ++;
        self.footView.text = [NSString stringWithFormat:@"共加载%d条收藏记录",(int)self.favouriteJobs.count];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } withuserId:userId pagesize:[NSNumber numberWithInt:30] pageindex:[NSNumber numberWithInt:self.size] keywords:@""];
}
//- (void) reloadData {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
//    if(status == NotReachable){
//        [self showErrorWithHUD:@"请检查网络连接"];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        return;
//    }
//    
//    //此段代码使tableView中的数据呈现出有序排列
//    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    [YHFavoriteJobTool getMyJobFavoriteList:^(YHResultItem *result) {
//        for(YHMyFavoriteJob *company in result.rows){
//            
//            [YHJobsTool getJobInfo:^(YHResultItem *result) {
//                YHJobs * jobs = [result.rows firstObject];
//                if(jobs){
//                    NSIndexPath *path;
//                    for(int i = 0; i < self.favouriteJobs.count; i ++){
//                        YHJobs *temp = self.favouriteJobs[i];
//                        if(![self compareOfDate:temp.PublishDate withDate:jobs.PublishDate] || (i == (self.favouriteJobs.count - 1))){
//                            if(i == (self.favouriteJobs.count - 1) && [self compareOfDate:temp.PublishDate withDate:jobs.PublishDate]){
//                                [self.favouriteJobs addObject:jobs];
//                                path = [NSIndexPath indexPathForRow:self.favouriteJobs.count - 1 inSection:0];
//                            }else{
//                                [self.favouriteJobs insertObject:jobs atIndex:i];
//                                path = [NSIndexPath indexPathForRow:i inSection:0];
//                            }
//                            break;
//                        }
//                        
//                    }
//                    if(self.favouriteJobs.count == 0){
//                        [self.favouriteJobs addObject:jobs];
//                        path = [NSIndexPath indexPathForRow:self.favouriteJobs.count - 1 inSection:0];
//                    }
//                    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
//                    self.footView.text = [NSString stringWithFormat:@"共加载%d条收藏记录",(int)self.favouriteJobs.count];
//                }
//            } withJobId:company.JobId];
//        }
//        self.size ++;
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    } withuserId:userId pagesize:[NSNumber numberWithInt:30] pageindex:[NSNumber numberWithInt:self.size] keywords:@""];
//    
//    //此段代码加载的是没有经过排列的数据
////        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
////        [YHFavoriteJobTool getMyJobFavoriteList:^(YHResultItem *result) {
////            for (YHMyFavoriteJob *item in result.rows){
////                [self.favouriteJobs addObject:item];
////            }
////            [self.tableView reloadData];
////            self.footView.text = [NSString stringWithFormat:@"共加载%d条收藏记录",(int)self.favouriteJobs.count];
////            [self.tableView.mj_header endRefreshing];
////            [self.tableView.mj_footer endRefreshing];
////            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
////            self.size += 1;
////        } withuserId:userId pagesize:[NSNumber numberWithInt:10] pageindex:[NSNumber numberWithInt:self.size] keywords:@""];
//    
//}

- (BOOL) compareOfDateWithShortStyle:(NSString *)src withDate:(NSString *)dest{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    format.dateFormat = @"yyyy/MM/dd";
    NSDate *former = [format dateFromString:src];
    NSDate *last = [format dateFromString:dest];
    
    NSComparisonResult result = [former compare:last];
    if(result == NSOrderedAscending){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL) compareOfDate:(NSString *)src withDate:(NSString *)dest{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    format.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *former = [format dateFromString:src];
    NSDate *last = [format dateFromString:dest];
    
    NSComparisonResult result = [former compare:last];
    if(result == NSOrderedDescending){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL) compareDateOfDay:(NSString *)src withDate:(NSString *)dest{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy/MM/dd";
    [format setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *former = [format dateFromString:src];
    
    format.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *last = [format dateFromString:dest];
    
    format.dateFormat = @"yyyy-MM-dd";
    NSString *temp = [format stringFromDate:former];
    NSString *temp1 = [format stringFromDate:last];
    former = [format dateFromString:temp];
    last = [format dateFromString:temp1];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:former];
    
    former = [former dateByAddingTimeInterval:interval];
    
    interval = [zone secondsFromGMTForDate:last];
    last = [last dateByAddingTimeInterval:interval];
    
    
    NSComparisonResult result = [former compare:last];
    if(result == NSOrderedSame){
        return YES;
    }else{
        return NO;
    }
}

- (NSString *) getDate:(NSString *)date{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    [format setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *dest = [format dateFromString:date];
    format.dateFormat = @"yyyy/MM/dd";
    return [format stringFromDate:dest];
}

#pragma mark - Lazy Initial
- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = YHGray;
    }
    return _tableView;
}

@end
