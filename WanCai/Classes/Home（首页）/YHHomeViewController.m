//
//  YHHomeViewController.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHHomeViewController.h"
#import "MJRefresh.h"
#import "YHJobsTool.h"
#import "YHJobs.h"
#import "YHResultItem.h"
#import "YHJobInfoCell.h"
#import "YHJobSearchController.h"
#import "PingTransition.h"
#import "ZYBannerView.h"
#import "YHPositionViewController.h"
#import "YHDetailInfoOfJobViewController.h"
#import "YHSearchTableViewcell.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "YHHomeButton.h"
#import "YHSearchResultViewController.h"
#import "YHADInfo.h"
#import "Masonry.h"
#import "YHArticleDetailViewController.h"
#import "YHIndusToImageTool.h"

//#define randomColor [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0]
#define BannerHeight 192
#define HeaderViewHeight 300
#define CollectButtonParam 30

@interface YHHomeViewController () <ZYBannerViewDataSource, ZYBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *statusArr;
//bannerview
@property (nonatomic, strong) ZYBannerView *banner;
@property (nonatomic, strong) NSArray *BannerDataArray;
@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) UIView * headerView; // headerView
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) NSArray *adInfoArr;

@end

@implementation YHHomeViewController

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *location = [defaults objectForKey:@"currentLocation"];
    UIBarButtonItem *position;
    
    if(location == nil || location.length == 0){
        position = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_position" highImage:@"navigationbar_position_highlighted" target:self action:@selector(position)];
    }else{
        CGSize size = [location boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil].size;
        UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [locationButton setTitle:location forState:UIControlStateNormal];
        locationButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [locationButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [locationButton addTarget:self action:@selector(position) forControlEvents:UIControlEventTouchUpInside];
        position = [[UIBarButtonItem alloc] initWithCustomView:locationButton];
    }
    self.navigationItem.leftBarButtonItem = position;
}

- (NSArray *)BannerDataArray {
    if (!_BannerDataArray) {
        _BannerDataArray = @[@"ad_0.jpg", @"ad_1.jpg", @"ad_2.jpg", @"ad_3.jpg"];
    }
    return _BannerDataArray;
}

- (UILabel *) footerLabel{
    if(!_footerLabel){
        _footerLabel = [[UILabel alloc] init];
        [_footerLabel setBackgroundColor:YHGray];
    }
    return _footerLabel;
}


- (NSMutableArray *)statusArr {
    if (_statusArr == nil) {
        _statusArr = [NSMutableArray array];
    }
    return _statusArr;
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(YHScreenWidth, -10, 50, 50)];
        self.button = _button;
    }
    return _button;
}

- (NSArray *)adInfoArr {
    if (!_adInfoArr) {
        _adInfoArr = [YHADInfo getADInfoList];
    }
    return _adInfoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YHGray;
    // 设置tableview
    [self setUpTableViewStyle];
    // 设置导航条的内容
    [self setUpNavBar];
    // 添加刷新控件
    [self setUpRefreshView];
    // 添加mask按钮
    [self.view addSubview:self.button];
    // 设置headerView
    [self setupHeaderView];
    
    
    self.pageIndex = 1;
}

#pragma mark - 初始化头部视图
- (void)setupHeaderView
{
    UIView * headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeaderViewHeight);
    
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = self.headerView;
    
    // 设置bannerView
    [self setupBanner];
    // 初始化广告视图
    [self setupAD];
}
- (void)setupAD
{
    // HeaderViewH - BannerH;
    CGFloat adViewH = HeaderViewHeight - BannerHeight;
    CGFloat screenW = YHScreenWidth;
    
    
    UIScrollView * adView = [[UIScrollView alloc] init];
    adView.showsHorizontalScrollIndicator = NO;
    adView.frame = CGRectMake(0, BannerHeight, [UIScreen mainScreen].bounds.size.width, adViewH);
    [self.headerView addSubview:adView];
    
    CGFloat buttonH = adViewH - CollectButtonParam;
    CGFloat buttonW = buttonH;
    for (int i = 0; i < self.adInfoArr.count; i++) {
        YHADInfo *adInfo = [self.adInfoArr objectAtIndex:i];
        YHHomeButton *button = [[YHHomeButton alloc] init];
        //[button setBackgroundColor:randomColor];
        if (screenW <= 320) {
            button.frame = CGRectMake(CollectButtonParam * 0.5 + i * adViewH, CollectButtonParam * 0.5, buttonW, buttonH);
        }else{
            button.frame = CGRectMake(CollectButtonParam * 0.5 + i * (adViewH - 20), CollectButtonParam * 0.5, buttonW, buttonH);
        }
        button.imageView.image = [UIImage imageNamed:adInfo.adImage];
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:adInfo.adDesc forState:UIControlStateNormal];
        [button addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        [adView addSubview:button];
        
    }
    
    if (screenW <= 320) {
        adView.contentSize = CGSizeMake(adViewH * self.adInfoArr.count, 0);
    }else {
        adView.contentSize = CGSizeMake((adViewH - 20) * self.adInfoArr.count + 20, 0);
    }
    
    [self addArrowIcon];
}

- (void)addArrowIcon {
    UIImageView *iconL = [UIImageView new];
    iconL.image = [UIImage imageNamed:@"ad_arrow_left"];
    [self.headerView addSubview:iconL];
    [iconL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 40));
        make.bottom.mas_equalTo(self.headerView).offset(-34);
        make.left.mas_equalTo(self.headerView).offset(0);
    }];
    
    UIImageView *iconR = [UIImageView new];
    iconR.image = [UIImage imageNamed:@"ad_arrow_right"];
    [self.headerView addSubview:iconR];
    [iconR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 40));
        make.bottom.mas_equalTo(self.headerView).offset(-34);
        make.right.mas_equalTo(self.headerView).offset(0);
    }];
}

- (void)search:(UIButton *)button{
    YHSearchResultViewController *search = [YHSearchResultViewController new];
    search.title = button.titleLabel.text;
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - 设置导航条的内容
- (void)setUpNavBar {
    //右侧搜索图标
    UIBarButtonItem *search = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_search" highImage:@"navigationbar_search_highlighted" target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = search;
    //设置title
    self.navigationItem.title = @"万才招聘";
}

#pragma mark -设置tableviewStyle
- (void)setUpTableViewStyle {
    self.tableView.backgroundColor = YHGray;
    //    self.tableView.sectionHeaderHeight = 20;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = 90;
    self.tableView.tableFooterView = self.footerLabel;
}

#pragma mark - 定位&职位搜索
- (void)position {
    YHPositionViewController *position = [[YHPositionViewController alloc] init];
    [self presentViewController:position animated:YES completion:^{
    }];
}

-(void)search {
    YHLog(@"职位搜索ing...");
    UIViewController *vc = [[YHJobSearchController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 刷新控件
- (void)setUpRefreshView {
    //添加下啦刷新
    self.tableView.mj_header = [self getHeader];
    [self.tableView.mj_header beginRefreshing];
    //加载更多
    self.tableView.mj_footer = [self getFooter];
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
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    footer.refreshingTitleHidden = NO;
    return footer;
}

/**
 *  加载新数据
 */
- (void)loadMoreData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showErrorWithHUD:@"请检查网络连接"];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        return;
    }
    
    [YHJobsTool getJobs:^(YHResultItem *result) {
        
        [self.statusArr addObjectsFromArray:result.rows];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
//        if(self.statusArr.count != 0){
//            NSLog(@"%d", (int)self.pageIndex);
//            self.pageIndex ++;
//        }
        self.pageIndex ++;

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.tableView reloadData];
    } pagesize:@"10" pageindex:[NSString stringWithFormat:@"%d", self.pageIndex] industryId:@"0" jobFunctionId:@"0" workLocationId:@"3202" keywords:@"" degreeId:@"0" workexperienceId:@"0" salaryRangeId:@"0" jobNatureId:@"0"];
}
- (void)loadNewData {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showErrorWithHUD:@"请检查网络连接"];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        return;
    }
    
    [YHJobsTool getJobs:^(YHResultItem *result) {
        
        for (YHJobs *jobs in result.rows) {
            if(jobs != nil){
                [self.statusArr insertObject:jobs atIndex:0];
            }
        }
        //        NSLog(@"%@", result.rows);
        //        [self.statusArr addObjectsFromArray:result.rows];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
//        if(self.statusArr.count != 0){
//            NSLog(@"%d", (int)self.pageIndex);
//            
//            self.pageIndex ++;
//        }
        self.pageIndex ++;

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.tableView reloadData];
    } pagesize:@"10" pageindex:[NSString stringWithFormat:@"%d", self.pageIndex] industryId:@"0" jobFunctionId:@"0" workLocationId:@"3202" keywords:@"" degreeId:@"0" workexperienceId:@"0" salaryRangeId:@"0" jobNatureId:@"0"];
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

#pragma mark - test
- (void) test {
    
}

#pragma mark 设置Banner
- (void)setupBanner
{
    // 初始化
    self.banner = [[ZYBannerView alloc] init];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    self.banner.autoScroll = YES;
    self.banner.shouldLoop = YES;
    
    // 设置frame
    self.banner.frame = CGRectMake(0, 0, YHScreenWidth, BannerHeight);
    
    [self.headerView addSubview:self.banner];
    
}
#pragma mark - ZYBannerViewDataSource
// 返回Banner需要显示Item(View)的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return self.BannerDataArray.count;
}
// 返回Banner在不同的index所要显示的View (可以是完全自定义的view, 且无需设置frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    // 取出数据
    NSString *imageName = self.BannerDataArray[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

// 返回Footer在不同状态时要显示的文字
- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState
{
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动进入下一页";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放进入下一页";
    }
    return nil;
}
#pragma mark - ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
    if (index == 0) {
        YHArticleDetailViewController *detail = [[YHArticleDetailViewController alloc] init];
        detail.URL = [NSURL URLWithString:@"http://www.cithr.com.cn/ui/NewsContent.aspx?id=602"];
        //        detail.imageURL = @"http://www.cithr.com.cn/ui/images/index/未来五年-江苏服务外包型人才缺口近50万.jpg";
        detail.imageURL = @"http://thumbnail0.baidupcs.com/thumbnail/c728c405c78c0780f6090a83b740df55?fid=1413406208-250528-1103533340879013&time=1469534400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-zad43QcCBfGq7wojShN4p0bUejA%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4821015427309321390&dp-callid=0&size=c710_u400&quality=100";
        [self.navigationController pushViewController:detail animated:YES];
    }else if(index == 1){
        YHArticleDetailViewController *detail = [[YHArticleDetailViewController alloc] init];
        detail.URL = [NSURL URLWithString:@"http://www.cithr.com.cn/ui/NewsContent.aspx?id=601"];
        detail.imageURL = @"http://thumbnail0.baidupcs.com/thumbnail/a6f7b11466a8169959e882f1f79f5681?fid=3713189045-250528-827606559847562&time=1469534400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-RQ%2F9FGVngGdwdAjL1RYxdlpzq4A%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4820944376026799208&dp-callid=0&size=c710_u400&quality=100";
        //        detail.imageURL = @"http://www.cithr.com.cn/ui/images/index/商务部部长助理刘海泉中国服务外包产业进入黄金期.jpg";
        [self.navigationController pushViewController:detail animated:YES];
    }else if (index == 2){
        YHArticleDetailViewController *detail = [[YHArticleDetailViewController alloc] init];
        detail.URL = [NSURL URLWithString:@"http://www.cithr.com.cn/ui/NewsContent.aspx?id=621"];
        detail.imageURL = @"http://www.cithr.com.cn/images/news/144651229952482015113101237726.jpeg";
        [self.navigationController pushViewController:detail animated:YES];
    }else if (index == 3){
        YHArticleDetailViewController *detail = [[YHArticleDetailViewController alloc] init];
        detail.URL = [NSURL URLWithString:@"http://www.cithr.com.cn/ui/NewsContent.aspx?id=637"];
        detail.imageURL = @"http://www.cithr.com.cn/images/news/144783315098472015112510342452.jpg";
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        YHLog(@"没有其他项目了");
    }
    YHLog(@"点击了第%ld个项目", index);
}

// 在这里实现拖动footer后的事件处理
- (void)bannerFooterDidTrigger:(ZYBannerView *)banner
{
    YHLog(@"触发了footer");
    
    //    NextViewController *vc = [[NextViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"home_collection";
    YHSearchTableViewCell *cell = [YHSearchTableViewCell cellFromTableView:tableView withIdentifier:identifier];
    //注意，此处赋值顺序不能改变，cell中的其他控件的位置均是基于iconview得到的，因此必须先初始化icon
    YHJobs *job = self.statusArr[indexPath.row];
    cell.iconName = [YHIndusToImageTool getIconWithIndustry:job.IndustryName];
    cell.job = job;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHJobs *jobs = self.statusArr[indexPath.row];
    
    YHDetailInfoOfJobViewController *detail = [YHDetailInfoOfJobViewController detailInfoViewWithJob:jobs];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
