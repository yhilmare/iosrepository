//
//  YHDetailInfoOfJobViewController.m
//  WanCai
//
//  Created by abing on 16/7/16.
//  Copyright © 2016年 SYYH. All rights reserved.
//
/*
 @property (nonatomic, copy) NSString *JobFunctionName;//职能名称
 @property (nonatomic, copy) NSString *CompanyIntroduce;//公司介绍(长篇介绍)
 */


#import "YHCareFromDetailViewController.h"
#import "YHJobs.h"
#import "YHHeaderTableViewCell.h"
#import "YHMiddleHeaderTableViewCell.h"
#import "YHMiddleBottomTableViewCell.h"
#import "YHCompanyMsg.h"
#import "YHBottomTableViewCell.h"
#import "MenuView.h"
#import "YHJobsTool.h"
#import "MBProgressHUD.h"
#import "YHReturnMsg.h"
#import "YHResultItem.h"
#import "YHIndusToImageTool.h"
#import "YHCompanyDetailInfoViewController.h"
#import "Reachability.h"
#import "YHCareFromViewBottomView.h"
#import "YHStringTools.h"
#import "YHResumeTool.h"
#import "YHResumeBasicViewController.h"

@interface YHCareFromDetailViewController ()<YHCareFromViewBottomViewDelgate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) YHJobs *Job;

@property (nonatomic, strong) YHCareFromViewBottomView *bottomView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YHCompanyMsg *companyInfo;

@end

@implementation YHCareFromDetailViewController

- (CGRect) calculateFramUtils: (CGFloat) itemWidthPercent
                   itemHeight: (CGFloat) itemHeightPercent
                        itemY: (CGFloat) itemY
                        itemX: (CGFloat) itemX{
    
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = screenFrame.size.width;
    CGFloat screenHeight = screenFrame.size.height;
    CGFloat itemWidth = itemWidthPercent * screenWidth;
    CGFloat itemHeight = itemHeightPercent * screenHeight;
    
    CGFloat x = (screenWidth - itemWidth) * itemX;
    CGFloat y = itemY * screenHeight;
    CGRect rect = CGRectMake(x, y, itemWidth, itemHeight);
    return rect;
}

- (YHCompanyMsg *)companyInfo{
    if(!_companyInfo){
        _companyInfo = [[YHCompanyMsg alloc] init];
        [_companyInfo setCompanyRequired:[YHStringTools htmlEntityDecode:_Job.JobRequirements]];
        [_companyInfo setCompanyDescribtion:_Job.JobDescription];
        [_companyInfo setCompanyAddress:_Job.CompanyAddress];
        [_companyInfo setCompanyContactPerson:_Job.CompanyContact];
        [_companyInfo setCompanyContact:_Job.Contact];
    }
    return _companyInfo;
}

- (YHCareFromViewBottomView *) bottomView{
    if(!_bottomView){
        CGFloat itemHeight = 0.07;
        CGFloat itemYPer = 1 - itemHeight;
        _bottomView = [[YHCareFromViewBottomView alloc] initWithFrame:[self calculateFramUtils:1 itemHeight:itemHeight itemY:itemYPer itemX:0]];
        [_bottomView setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
        _bottomView.delgate = self;
    }
    return _bottomView;
}


- (UITableView *) tableView{
    if(!_tableView){
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat tableViewHeight = screenHeight - screenHeight * 0.07 - 64;
        CGRect frame = CGRectMake(0, 64, self.view.frame.size.width, tableViewHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 12);
    }
    return _tableView;
}


- (void) didClickButton:(UIButton *)button{
    [button setBackgroundColor:[UIColor colorWithRed:0 green:175/255.0 blue:240/255.0 alpha:1]];
    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    YHResumeBasicViewController *view = [[YHResumeBasicViewController alloc] initWithResumeId:self.resumeId];
    [self.navigationController pushViewController:view animated:YES];
    NSLog(@"查看简历,%@", self.resumeId);
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

- (void) showSuccessInfoWithHUD:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    [hud hideAnimated:YES afterDelay:1];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
    hud.label.text = msg;
    
}

- (void) viewWillAppear:(BOOL)animated{
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:@"share.png" highImage:@"" target:self action:@selector(shareFunction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSString *ID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *userId = [NSString stringWithFormat:@"%@", ID];
    
    if(ID == nil || userId.length == 0){
        return;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YHGray;
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
}

- (void)shareFunction{
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"豆瓣" iconName:@"cm2_blogo_douban" glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"微信好友" iconName:@"cm2_blogo_weixin" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"朋友圈" iconName:@"cm2_blogo_pyq" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"新浪微博" iconName:@"cm2_blogo_sina" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"QQ好友" iconName:@"cm2_blogo_qq" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"QQ空间" iconName:@"cm2_blogo_qzone" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    MenuView *centerButton = [[MenuView alloc] initWithFrame:self.view.bounds items:items];
    centerButton.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        
    };
    
    [centerButton showMenuAtView:YHWindow];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 150;
    }else if(indexPath.row == 1){
        return 70;
    }else if(indexPath.row == 2){
        return 70;
    }else{
        return self.companyInfo.rowHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"care_detailInfo_identifier";
    static NSString *identifier1 = @"care_detailInfo_identifier1";
    static NSString *identifier2 = @"care_detailInfo_identifier2";
    static NSString *identifier3 = @"care_detailInfo_identifier3";
    if (indexPath.row == 0){
        YHHeaderTableViewCell *headerCell = [YHHeaderTableViewCell cellWithIdentifier:identifier tableView:tableView];
        headerCell.iconName = [YHIndusToImageTool getIconWithIndustry:self.Job.IndustryName];
        headerCell.jobName = self.Job.JobName;
        headerCell.companyName = self.Job.CompanyName;
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }else if(indexPath.row == 1){
        YHMiddleHeaderTableViewCell *cell = [YHMiddleHeaderTableViewCell cellWithIdentifier:identifier1 withTableView:tableView];
        cell.job = self.Job;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 2){
        YHMiddleBottomTableViewCell *cell = [YHMiddleBottomTableViewCell cellFromTableView:tableView withIdentifier:identifier2];
        cell.job = self.Job;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        YHBottomTableViewCell *cell = [YHBottomTableViewCell cellFromTableView:tableView withIdentifier:identifier3];
        cell.msg = self.companyInfo;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    if(indexPath.row == 2){
        YHCompanyDetailInfoViewController *com = [[YHCompanyDetailInfoViewController alloc] initWithCompanyID:self.Job.CompanyId];
        [self.navigationController pushViewController:com animated:YES];
    }
}

//重写构造方法
+ (instancetype) detailInfoViewWithJob:(YHJobs *)job andResumeId:(NSString *)resumeId{
    return  [[self alloc] initWithJob:job andResumeId:resumeId];
}

- (instancetype)initWithJob:(YHJobs *)Job andResumeId:(NSString *) resumeId{
    if(self = [super init]){
        _Job = Job;
        _resumeId = resumeId;
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"职位详情";
    }
    return self;
}
@end
