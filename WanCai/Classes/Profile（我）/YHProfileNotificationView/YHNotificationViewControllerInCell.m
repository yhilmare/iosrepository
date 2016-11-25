//
//  YHNotificationViewControllerInCell.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHNotificationViewControllerInCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "YHDialogue.h"
#import "YHDialogueTableViewCell.h"

@interface YHNotificationViewControllerInCell ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *msgArray;

@property (nonatomic, strong) UILabel *footer;

@end

@implementation YHNotificationViewControllerInCell

- (UILabel *) footer{
    if(!_footer){
        _footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 110)];
        _footer.font = [UIFont systemFontOfSize:15];
        _footer.textAlignment = NSTextAlignmentCenter;
    }
    return _footer;
}

- (NSMutableArray *) msgArray{
    if(!_msgArray){
        _msgArray = [NSMutableArray array];
    }
    return _msgArray;
}

- (UITableView *) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = self.footer;
        _tableView.rowHeight = 70;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 80, 0, 0);
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:YHGray];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [self getHeader];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void) viewDidDisappear:(BOOL)animated{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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

- (void) loadMoreData{//刷新
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        return;
    }
    
    
    if(self.viewTag == 0){//加载私信
        NSString *path = [[NSBundle mainBundle] pathForResource:@"notice.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for(NSDictionary *dic in array){
            YHDialogue *dialogue =  [YHDialogue getObjectWithDictionary:dic];
            [self.msgArray addObject:dialogue];
        }
    }else{//加载面试通知
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dialogue.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for(NSDictionary *dic in array){
            YHDialogue *dialogue =  [YHDialogue getObjectWithDictionary:dic];
            [self.msgArray addObject:dialogue];
        }
    }
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.msgArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"notification_identifier";
    static NSString *identifier2 = @"notification_identifier2";

    if(self.viewTag == 0){
        YHDialogueTableViewCell *cell = [YHDialogueTableViewCell cellFromTableView:tableView withIdentifier:identifier];
        cell.dialogue = self.msgArray[indexPath.row];
        return cell;
    }else{
        YHDialogueTableViewCell *cell = [YHDialogueTableViewCell cellFromTableView:tableView withIdentifier:identifier2];
        cell.dialogue = self.msgArray[indexPath.row];
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.delgate respondsToSelector:@selector(didSelectedAtIndexPath:withTag:andDialogueModel:)]){
        [self.delgate didSelectedAtIndexPath:indexPath withTag:self.viewTag andDialogueModel:self.msgArray[indexPath.row]];
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


@end
