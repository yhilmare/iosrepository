//
//  YHProfileCareViewController.m
//  WanCai
//
//  Created by abing on 16/7/21.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileCareViewController.h"
#import "YHAttentionToMeCommpanyTool.h"
#import "YHResultItem.h"
#import "YHAttentionToMeCompany.h"
#import "MJRefresh.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "YHProfileCareTableViewCell.h"
#import "YHCareFromDetailViewController.h"
#import "YHJobsTool.h"
#import "YHFavoriteJobTool.h"
#import "YHMyFavoriteJob.h"

@interface YHProfileCareViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int pageIndex;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,copy) NSMutableArray *careArray;

@property (nonatomic, strong) UILabel *footView;

@property (nonatomic, strong) UILabel *headerView;

@end

@implementation YHProfileCareViewController

- (UILabel *) footView{
    if(!_footView){
        _footView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _footView.textAlignment = NSTextAlignmentCenter;
        _footView.font = [UIFont systemFontOfSize:14];
        [_footView setTextColor:[UIColor grayColor]];
    }
    return _footView;
}

- (UILabel *) headerView{
    if(!_headerView){
        _headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _headerView.textAlignment = NSTextAlignmentCenter;
        _headerView.font = [UIFont systemFontOfSize:14];
        [_headerView setTextColor:[UIColor grayColor]];
        _headerView.textAlignment = NSTextAlignmentLeft;
    }
    return _headerView;
}

- (NSMutableArray *) careArray{
    if(!_careArray){
        _careArray = [NSMutableArray array];
    }
    return _careArray;
}

- (UITableView *) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 1;
    
    [self setNav];
    
    [self.view setBackgroundColor:YHGray];
    
    [self setSubViews];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void) setNav{
    
    self.navigationItem.title = @"谁看过我";
    self.navigationItem.rightBarButtonItem = nil;
}

- (void) setSubViews{
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footView;
    self.tableView.mj_header = [self getHeader];
    self.tableView.mj_footer = [self getFooter];
    
    [self.view addSubview:self.tableView];
}

- (MJRefreshNormalHeader *) getHeader{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
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

- (MJRefreshAutoNormalFooter *) getFooter{
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    footer.refreshingTitleHidden = NO;
    return footer;
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

- (void) loadNewData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    
    
    //本地数据测试，
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.plist" ofType:nil];
//    NSArray *array = [NSArray arrayWithContentsOfFile:path];
//    NSMutableArray *row = [NSMutableArray array];
//    for(int i = 0; i < array.count; i++){
//        NSDictionary *dic = array[i];
//        YHAttentionToMeCompany *company = [[YHAttentionToMeCompany alloc] init];
//        [company setValuesForKeysWithDictionary:dic];
//        [row addObject:company];
//    }
//    int y = 0;int j = 0;
//        for(YHAttentionToMeCompany *item in row){
//            for(int i = 0; i < self.careArray.count; i++){
//                NSDictionary *dic = self.careArray[i];
//                NSString *time = dic[@"time"];
//                if([self compareDateOfDay:time withDate:item.ViewDate]){
//                    NSMutableArray *array = dic[@"rows"];
//                    for(int k = 0; k < array.count; k++){
//                        YHAttentionToMeCompany *temp = array[k];
//                        if(![self compareOfDate:temp.ViewDate withDate:item.ViewDate] || (k == (array.count - 1))){
//                            if(k == (array.count - 1) && [self compareOfDate:temp.ViewDate withDate:item.ViewDate]){
//                                [array addObject:item];
//                            }else{
//                                [array insertObject:item atIndex:k];
//                            }
//                            break;
//                        }
//                    }
//                    j = 1;
//                    break;
//                }
//            }
//            if(j == 0 && self.careArray.count != 0){
//                NSMutableArray *array = [NSMutableArray arrayWithArray:@[item]];
//                NSDictionary *dics = @{@"time":[self getDate:item.ViewDate], @"rows":array};
//                for(int i = 0; i < self.careArray.count; i++){
//                    NSDictionary *dic = self.careArray[i];
//                    NSString *datestr = dic[@"time"];
//                    if(![self compareOfDateWithShortStyle:datestr withDate:[self getDate:item.ViewDate]] || (i == self.careArray.count - 1)){
//                        if((i == self.careArray.count - 1) && [self compareOfDateWithShortStyle:datestr withDate:[self getDate:item.ViewDate]]){
//                            [self.careArray addObject:dics];
//                        }else{
//                            [self.careArray insertObject:dics atIndex:i];
//                        }
//                        break;
//                    }
//                }
//                j = 0;
//            }
//            if(self.careArray.count == 0){
//                NSMutableArray *array = [NSMutableArray arrayWithArray:@[item]];
//                NSDictionary *dic = @{@"time":[self getDate:item.ViewDate], @"rows":array};
//                [self.careArray addObject:dic];
//            }
//            j = 0;
//        }
//        for(int i = 0; i < self.careArray.count; i++){
//            NSDictionary *dic = self.careArray[i];
//            NSMutableArray *array = dic[@"rows"];
//            for(int k = 0; k < array.count; k++){
//                y ++;
//            }
//        }
//        
//        if(self.careArray.count != 0){
//            self.pageIndex ++;
//        }
//        [self.tableView.mj_footer endRefreshing];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView reloadData];
//        self.headerView.text = [NSString stringWithFormat:@"   总的关注度：%d", y];
//        self.footView.text = [NSString stringWithFormat:@"共加载%d条浏览记录", y];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//
//===========================================================================================================//
    //时间排序,更进一步的排序，使同一天内被查看的情况在一个section中
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [YHAttentionToMeCommpanyTool getAttentionToMeCommpanyList:^(YHResultItem *result) {
        int y = 0;int j = 0;
        for(YHAttentionToMeCompany *item in result.rows){
            for(int i = 0; i < self.careArray.count; i++){
                NSDictionary *dic = self.careArray[i];
                NSString *time = dic[@"time"];
                if([self compareDateOfDay:time withDate:item.ViewDate]){
                    NSMutableArray *array = dic[@"rows"];
                    for(int k = 0; k < array.count; k++){
                        YHAttentionToMeCompany *temp = array[k];
                        if(![self compareOfDate:temp.ViewDate withDate:item.ViewDate] || (k == (array.count - 1))){
                            if(k == (array.count - 1) && [self compareOfDate:temp.ViewDate withDate:item.ViewDate]){
                                [array addObject:item];
                            }else{
                                [array insertObject:item atIndex:k];
                            }
                            break;
                        }
                    }
                    j = 1;
                    break;
                }
            }
            if(j == 0 && self.careArray.count != 0){
                NSMutableArray *array = [NSMutableArray arrayWithArray:@[item]];
                NSDictionary *dics = @{@"time":[self getDate:item.ViewDate], @"rows":array};
                for(int i = 0; i < self.careArray.count; i++){
                    NSDictionary *dic = self.careArray[i];
                    NSString *datestr = dic[@"time"];
                    if(![self compareOfDateWithShortStyle:datestr withDate:[self getDate:item.ViewDate]] || (i == self.careArray.count - 1)){
                        if((i == self.careArray.count - 1) && [self compareOfDateWithShortStyle:datestr withDate:[self getDate:item.ViewDate]]){
                            [self.careArray addObject:dics];
                        }else{
                            [self.careArray insertObject:dics atIndex:i];
                        }
                        break;
                    }
                }
                j = 0;
            }
            if(self.careArray.count == 0){
                NSMutableArray *array = [NSMutableArray arrayWithArray:@[item]];
                NSDictionary *dic = @{@"time":[self getDate:item.ViewDate], @"rows":array};
                [self.careArray addObject:dic];
            }
            j = 0;
        }
        for(int i = 0; i < self.careArray.count; i++){
            NSDictionary *dic = self.careArray[i];
            NSMutableArray *array = dic[@"rows"];
            for(int k = 0; k < array.count; k++){
                y ++;
            }
        }
        
        if(self.careArray.count != 0){
            self.pageIndex ++;
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        self.headerView.text = [NSString stringWithFormat:@"   总的关注度：%d", y];
        self.footView.text = [NSString stringWithFormat:@"共加载%d条浏览记录", y];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } withuserId:userId pagesize:[NSNumber numberWithInt:30] pageindex:[NSNumber numberWithInt:self.pageIndex]];
    //算法完
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.careArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = self.careArray[section];
    NSMutableArray *array = dic[@"rows"];
    return  array.count + 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"care_identifier";
    static NSString *identifier1 = @"care_identifier1";
    
    NSDictionary *dic = self.careArray[indexPath.section];
    if(indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
        }
        NSString *str = dic[@"time"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [self getDateWithFormat:str];
        return cell;
    }else{
        YHProfileCareTableViewCell *cell = [YHProfileCareTableViewCell cellFromTableView:tableView withIdentifier:identifier];
        NSArray *array = dic[@"rows"];
        YHAttentionToMeCompany *company = array[indexPath.row - 1];
        cell.attCom = company;
        cell.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        return;
    }
    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    NSDictionary *dic = self.careArray[indexPath.section];
    NSMutableArray *array = dic[@"rows"];
    YHAttentionToMeCompany *com = array[indexPath.row - 1];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    hud.label.text = @"加载中...";
    [hud showAnimated:YES];
    
    [YHJobsTool getJobInfo:^(YHResultItem *result) {
        YHJobs *item = [result.rows firstObject];
        YHCareFromDetailViewController *detail = [YHCareFromDetailViewController detailInfoViewWithJob:item andResumeId:com.ResumeId];
        [hud hideAnimated:YES];
        [self.navigationController pushViewController:detail animated:YES];
    } withJobId:com.JobId];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 44;
    }
    return 60;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section != 0){
        return 7;
    }
    return 3;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row != 0){
        return YES;
    }
    return NO;
}
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSDictionary *dic = self.careArray[indexPath.section];
        NSMutableArray *array = dic[@"rows"];
        [array removeObjectAtIndex:indexPath.row - 1];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

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

- (int) getYearNum:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    return (int)[calender ordinalityOfUnit:NSYearCalendarUnit inUnit:NSEraCalendarUnit forDate:date];
}
- (int) getMonthNum:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    return (int)[calender ordinalityOfUnit:NSMonthCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
}
- (int) getDayNum:(NSDate *)date{
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    return (int)[calender ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
}


- (NSString *) getDateWithFormat:(NSString *)dates{
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy/MM/dd";
    NSDate *date = [formate dateFromString:dates];
    
    NSDate *today = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
    
    int dateNum = [self getYearNum:date];
    int todayNum = [self getYearNum:today];
    if(dateNum < todayNum){
        formate.dateFormat = @"yy年MM月dd日";
        return [NSString stringWithFormat:@"%@", [formate stringFromDate:date]];
    }
    dateNum = [self getMonthNum:date];
    todayNum = [self getMonthNum:today];
    if(dateNum < todayNum){
        formate.dateFormat = @"MM月dd日";
        return [NSString stringWithFormat:@"%@", [formate stringFromDate:date]];
    }
    dateNum = [self getDayNum:date];
    todayNum = [self getDayNum:today];
    if(dateNum == todayNum){
        return @"今天";
    }else if(dateNum > todayNum - 5){
        return [NSString stringWithFormat:@"%d天前", todayNum - dateNum];
    }else{
        formate.dateFormat = @"MM月dd日";
        return [NSString stringWithFormat:@"%@", [formate stringFromDate:date]];
    }
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    format.dateFormat = @"yyyy/MM/dd";
//    [format setTimeZone:[NSTimeZone systemTimeZone]];
//    NSDate *dest = [format dateFromString:date];
//    
//    NSDate *today = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:today];
//    today = [today dateByAddingTimeInterval:interval];
//    
//    format.dateFormat = @"yyyy";
//    NSString *temp = [format stringFromDate:today];
//    NSString *temp1 = [format stringFromDate:dest];
//    
//    today = [format dateFromString:temp];
//    NSDate *dest1 = [format dateFromString:temp1];
//    
//    interval = [zone secondsFromGMTForDate:today];
//    today = [today dateByAddingTimeInterval:interval];
//    
//    interval = [zone secondsFromGMTForDate:dest1];
//    dest1 = [dest1 dateByAddingTimeInterval:interval];
//    
//    NSComparisonResult result = [today compare:dest1];
//    if(result == NSOrderedSame){
//        format.dateFormat = @"M月dd日";
//        return [format stringFromDate:dest];
//    }else{
//        format.dateFormat = @"yy年M月dd日";
//        return [format stringFromDate:dest];
//    }
}


@end
