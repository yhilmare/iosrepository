//
//  YHDeleteViewController.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDeleteViewController.h"
#import "YHFavoriteJobTool.h"
#import "MJRefresh.h"
#import "YHMyFavoriteJob.h"
#import "YHResultItem.h"
#import "YHLoginViewController.h"
#import "YHJobsTool.h"
#import "YHDetailInfoOfJobViewController.h"
#import "YHJobs.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "YHReturnMsg.h"

#import "YHSearchTableViewCell.h"
#import "YHIndusToImageTool.h"


@interface YHDeleteViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *favouriteJobs;
@property (nonatomic, assign) int size;
@property (nonatomic, strong) UILabel *footView;

@end

@implementation YHDeleteViewController

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
    self.title = @"回收站";
    [self.view addSubview: self.tableView];
    self.tableView.tableFooterView = self.footView;
    self.size = 1;
    // 设置回调
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    [self setRefreshHeader:header];
    self.tableView.mj_header = header;
    
    // 进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void) setRefreshHeader:(MJRefreshNormalHeader *)header{
    
    header.lastUpdatedTimeText = ^ NSString *(NSDate *date){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"MM-dd HH:mm";
        return [NSString stringWithFormat:@"上次更新时间：%@", [format stringFromDate:date]];
    };
    [header setTitle:@"下拉以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
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
    
    static NSString *identifier = @"delete_list";
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
        YHDetailInfoOfJobViewController *detail = [YHDetailInfoOfJobViewController detailInfoViewWithJob:item];
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
        
        YHJobs *jobs = self.favouriteJobs[indexPath.row];
        NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        path = [NSString stringWithFormat:@"%@/deleteList.plist", path];
        NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
        for(int k = 0; k < array.count; k ++){
            NSDictionary *dic = array[k];
            if([dic[@"userId"] isEqualToString:userId == nil?@"-1":[userId stringValue]]){
                NSMutableArray *temp = dic[@"Jobs"];
                for(int i = 0; i < temp.count; i++){
                    if([jobs.JobId isEqualToString:temp[i]]){
                        [temp removeObjectAtIndex:i];
                    }
                }
                NSDictionary *newDic = @{@"userId":userId == nil?@"-1":[userId stringValue], @"Jobs":temp};
                [array replaceObjectAtIndex:k withObject:newDic];
                [array writeToFile:path atomically:YES];
                break;
            }
        }
        
        [self.favouriteJobs removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.footView.text = [NSString stringWithFormat:@"共加载%d条记录",(int)self.favouriteJobs.count];
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
    return @"删除";
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
        self.footView.text = [NSString stringWithFormat:@"共加载%d条记录",(int)self.favouriteJobs.count];
        return;
    }
    
    if(self.size == 1){
        self.size = 0;
        NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        path = [NSString stringWithFormat:@"%@/deleteList.plist", path];
        NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
        if(array == nil){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            self.footView.text = [NSString stringWithFormat:@"共加载%d条记录",(int)self.favouriteJobs.count];
            return;
        }else{
            for(int i = 0; i < array.count; i++){
                NSDictionary *dic = array[i];
                if([dic[@"userId"] isEqualToString:userId == nil?@"-1":[userId stringValue]]){
                    NSMutableArray *array = dic[@"Jobs"];
                    for(NSString *JobId in array){
                        [YHJobsTool getJobInfo:^(YHResultItem *result) {
                            YHJobs *jobs = [result.rows firstObject];
                            if(jobs){
                                [self.favouriteJobs addObject:jobs];
                                NSIndexPath *path = [NSIndexPath indexPathForRow:self.favouriteJobs.count - 1 inSection:0];
                                [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
                                self.footView.text = [NSString stringWithFormat:@"共加载%d条记录",(int)self.favouriteJobs.count];
                                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                [self.tableView.mj_header endRefreshing];
                                [self.tableView.mj_footer endRefreshing];
                            }
                        } withJobId:JobId];
                    }
                    if(array.count == 0){
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        [self.tableView.mj_header endRefreshing];
                        [self.tableView.mj_footer endRefreshing];
                        self.footView.text = [NSString stringWithFormat:@"共加载%d条记录",(int)self.favouriteJobs.count];
                    }
                    break;
                }else{
                    if(i == array.count - 1){
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        [self.tableView.mj_header endRefreshing];
                        [self.tableView.mj_footer endRefreshing];
                    }
                }
            }
        }
    }else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }
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
