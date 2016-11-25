//
//  YHSearchResultViewController.m
//  WanCai
//
//  Created by CheungKnives on 16/7/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSearchResultViewController.h"
#import "MenuView.h"
#import "YHJobsTool.h"
#import "YHResultItem.h"
#import "MJRefresh.h"
#import "YHJobs.h"
#import "YHJobSearchTextFild.h"
#import "YHDetailInfoOfJobViewController.h"
#import "YHSearchTableViewCell.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "YHPositionViewController.h"
#import "YHIndustryTool.h"
#import "YHResultHeaderView.h"
#import "YHSearchSelectViewController.h"


#import "YHIndustry.h"
#import "YHIndusToImageTool.h"

@interface YHSearchResultViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, copy) NSMutableArray *statusArr;

@property (nonatomic, strong) YHJobSearchTextFild *BYsearchTextFd;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int pageIndex;

@property (nonatomic, strong) UILabel *footView;

@property (nonatomic, strong) YHResultHeaderView *header;

@property (nonatomic, strong) UIButton *jobButton;//选择职位

@property (nonatomic, strong) UIButton *salaryButton;//薪资

@property (nonatomic, strong) UIButton *jobNatureButton;//工作性质

@property (nonatomic, strong) UIButton *levelButton;//学历

@end

@implementation YHSearchResultViewController

- (UIButton *)levelButton{
    if(!_levelButton){
        _levelButton = [[UIButton alloc] init];
        _levelButton.tag = 3;
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width / 4.0;
        CGFloat maxHeight = 50;
        CGFloat width = maxWidth * 0.7;
        CGFloat height = maxHeight * 0.5;
        CGFloat x = maxWidth * 3 + (maxWidth - width) / 2.0;
        CGFloat y = (maxHeight - height) / 2.0;
        _levelButton.frame = CGRectMake(x, y, width, height);
        _levelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_levelButton setTitle:@"学历" forState:UIControlStateNormal];
        [_levelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_levelButton addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _levelButton;
}

- (UIButton *) jobNatureButton{
    if(!_jobNatureButton){
        _jobNatureButton = [[UIButton alloc] init];
        _jobNatureButton.tag = 2;
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width / 4.0;
        CGFloat maxHeight = 50;
        CGFloat width = maxWidth * 0.7;
        CGFloat height = maxHeight * 0.5;
        CGFloat x = maxWidth * 2 + (maxWidth - width) / 2.0;
        CGFloat y = (maxHeight - height) / 2.0;
        _jobNatureButton.frame = CGRectMake(x, y, width, height);
        _jobNatureButton.frame = CGRectMake(x, y, width, height);
        _jobNatureButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_jobNatureButton setTitle:@"工作性质" forState:UIControlStateNormal];
        [_jobNatureButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_jobNatureButton addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _jobNatureButton;
}

- (UIButton *) salaryButton{
    if(!_salaryButton){
        _salaryButton = [[UIButton alloc] init];
        _salaryButton.tag = 1;
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width / 4.0;
        CGFloat maxHeight = 50;
        CGFloat width = maxWidth * 0.7;
        CGFloat height = maxHeight * 0.5;
        CGFloat x = maxWidth + (maxWidth - width) / 2.0;
        CGFloat y = (maxHeight - height) / 2.0;
        _salaryButton.frame = CGRectMake(x, y, width, height);
        _salaryButton.frame = CGRectMake(x, y, width, height);
        _salaryButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_salaryButton setTitle:@"薪资" forState:UIControlStateNormal];
        [_salaryButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_salaryButton addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _salaryButton;
}

- (UIButton *) jobButton{
    if(!_jobButton){
        _jobButton = [[UIButton alloc] init];
        _jobButton.tag = 0;
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width / 4.0;
        CGFloat maxHeight = 50;
        CGFloat width = maxWidth * 0.7;
        CGFloat height = maxHeight * 0.5;
        CGFloat x = (maxWidth - width) / 2.0;
        CGFloat y = (maxHeight - height) / 2.0;
        _jobButton.frame = CGRectMake(x, y, width, height);
        _jobButton.frame = CGRectMake(x, y, width, height);
        _jobButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_jobButton setTitle:@"选择行业" forState:UIControlStateNormal];
        [_jobButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_jobButton addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _jobButton;
}

- (YHResultHeaderView *) header{
    if(!_header){
        _header = [[YHResultHeaderView alloc] init];
        [_header setBackgroundColor:[UIColor whiteColor]];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = 50;
        _header.frame = CGRectMake(0, 64, width, height);
    }
    return _header;
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


- (NSMutableArray *)statusArr{
    
    if(!_statusArr){
        _statusArr = [NSMutableArray array];
    }
    return _statusArr;
}

- (YHJobSearchTextFild *) BYsearchTextFd{
    if(!_BYsearchTextFd){
        _BYsearchTextFd = [[YHJobSearchTextFild alloc] initWithFrame:CGRectMake(50, 33, self.view.frame.size.width - 115, 31)];
        _BYsearchTextFd.placeholder = @"请输入学历/月薪/经历/其他信息";
        _BYsearchTextFd.returnKeyType = UIReturnKeySearch;
        _BYsearchTextFd.background = [UIImage imageNamed:@"search_background"];
        _BYsearchTextFd.delegate = self;
        [_BYsearchTextFd setTextColor:[UIColor grayColor]];
        _BYsearchTextFd.clearButtonMode = UITextFieldViewModeWhileEditing;
        //_BYsearchTextFd.keyboardType = UIKeyboardTypeWebSearch;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_small"]];
        img.frame = CGRectMake(10, 0, 20, 20);
        _BYsearchTextFd.leftView = img;
        _BYsearchTextFd.leftViewMode = UITextFieldViewModeAlways;
        _BYsearchTextFd.font = [UIFont fontWithName:@"Arial" size:14];
    }
    return _BYsearchTextFd;
}

- (UITableView *)tableView{
    
    if(!_tableView){
        
        CGFloat x = self.view.frame.origin.x;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height - 50;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, 50, width, height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 90;
        _tableView.backgroundColor = YHGray;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageIndex = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.mj_header = [self getHeader];
    self.tableView.mj_footer = [self getFooter];
    self.tableView.tableFooterView = self.footView;
    
    [self setSubView];
    
    [self.tableView.mj_header beginRefreshing];

}
- (void)viewWillAppear:(BOOL)animated{
    
    [self setNavBar];
}

- (MJRefreshNormalHeader *) getHeader{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadsMoreData)];
    
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
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadsData)];
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

- (NSString *)getCodeWithName:(NSString *)name withDictionary:(NSMutableDictionary *)dic{//获得代码,得到不同键值得映射代码
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"industry.plist" ofType:nil];
    NSDictionary *dics = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *tempArray = dics[@"rows"];
    for(NSDictionary *tempDic in tempArray){
        
        if ([tempDic[@"IndName"] isEqualToString:name]){
            [dic setValue:tempDic[@"IndCode"] forKey:@"industryId"];
            return nil;
        }
    }
    if([name isEqualToString:@"中技"]){
        [dic setValue:@"3" forKey:@"degreeId"];
        return @"3";
    }else if([name isEqualToString:@"中专"]){
        [dic setValue:@"4" forKey:@"degreeId"];
        return @"4";
    }else if([name isEqualToString:@"大专"]){
        [dic setValue:@"5" forKey:@"degreeId"];
        return @"5";
    }else if([name isEqualToString:@"本科"]){
        [dic setValue:@"6" forKey:@"degreeId"];
        return @"6";
    }else if([name isEqualToString:@"硕士"]){
        [dic setValue:@"7" forKey:@"degreeId"];
        return @"7";
    }else if([name isEqualToString:@"博士"]){
        [dic setValue:@"8" forKey:@"degreeId"];
        return @"8";
    }else if([name isEqualToString:@"博士后"]){
        [dic setValue:@"9" forKey:@"degreeId"];
        return @"9";
    }else if([name isEqualToString:@"1年"]){
        [dic setValue:@"3" forKey:@"workexperienceId"];
        return @"3";
    }else if([name isEqualToString:@"2年"]){
        [dic setValue:@"4" forKey:@"workexperienceId"];
        return @"4";
    }else if([name isEqualToString:@"3-4年"]){
        [dic setValue:@"5" forKey:@"workexperienceId"];
        return @"5";
    }else if([name isEqualToString:@"5-7年"]){
        [dic setValue:@"6" forKey:@"workexperienceId"];
        return @"6";
    }else if([name isEqualToString:@"8-9年"]){
        [dic setValue:@"7" forKey:@"workexperienceId"];
        return @"7";
    }else if([name isEqualToString:@"10年以上"]){
        [dic setValue:@"8" forKey:@"workexperienceId"];
        return @"8";
    }else if([name isEqualToString:@"在读学生"]){
        [dic setValue:@"1" forKey:@"workexperienceId"];
        return @"1";
    }else if([name isEqualToString:@"应届毕业生"]){
        [dic setValue:@"2" forKey:@"workexperienceId"];
        return @"2";
    }else if([name isEqualToString:@"1000-2000元"]){
        [dic setValue:@"2" forKey:@"salaryRangeId"];
        return @"2";
    }else if([name isEqualToString:@"2000-3000元"]){
        [dic setValue:@"3" forKey:@"salaryRangeId"];
        return @"3";
    }else if([name isEqualToString:@"3000-5000元"]){
        [dic setValue:@"4" forKey:@"salaryRangeId"];
        return @"4";
    }else if([name isEqualToString:@"5000-8000元"]){
        [dic setValue:@"5" forKey:@"salaryRangeId"];
        return @"5";
    }else if([name isEqualToString:@"8000-10000元"]){
        [dic setValue:@"6" forKey:@"salaryRangeId"];
        return @"6";
    }else if([name isEqualToString:@"10000元以上"]){
        [dic setValue:@"7" forKey:@"salaryRangeId"];
        return @"7";
    }else{
        [dic setValue:name forKey:@"keywords"];
        return nil;
    }
}


- (NSMutableDictionary *) getParameters:(NSString *) keyWords{
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    
    
    // 将搜索关键字中的数字提取出来;
    NSString *originalString = [NSString stringWithFormat:@"%@", keyWords];
    NSMutableString *numberString = [NSMutableString string];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:numbers intoString:nil];
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        if(tempStr){
            [numberString appendString:tempStr];
        }
        tempStr = @"";
    }
    if(numberString.length != 0){
        NSInteger number = [numberString integerValue];
        if(number <= 2000){
            keyWords = @"1000-2000元";
        }else if((number > 2000) && (number <= 3000)){
            keyWords = @"2000-3000元";
        }else if((number > 3000) && (number <= 5000)){
            keyWords = @"3000-5000元";
        }else if((number > 5000) && (number <= 8000)){
            keyWords = @"5000-8000元";
        }else if((number > 8000) && (number <= 10000)){
            keyWords = @"8000-10000元";
        }else{
            keyWords = @"10000元以上";
        }
    }
    //
    [self getCodeWithName:keyWords withDictionary:paramsDic];
    [self getCodeWithButton:paramsDic];
    /**
     *  根据条件获取最新职位列表
     *  @param industryId       所属行业id
     *  @param jobFunctionId    职位职能id
     *  @param workLocationId   城市id//
     *  @param keywords         关键字   ////
     *  @param degreeId         学历id//
     *  @param workexperienceId 工作年限id//
     *  @param salaryRangeId    薪资范围id//
     *  @param jobNatureId      职位性质id
     */
    return paramsDic;
}


- (void) getCodeWithButton:(NSMutableDictionary *)dic{
    
    if(![self.salaryButton.titleLabel.text isEqualToString:@"薪资面议"] && ![self.salaryButton.titleLabel.text isEqualToString:@"薪资"]){
        [self getCodeWithName:self.salaryButton.titleLabel.text withDictionary:dic];
    }
    if(![self.jobNatureButton.titleLabel.text isEqualToString:@"工作性质"]){
        [self getCodeWithName:self.jobNatureButton.titleLabel.text withDictionary:dic];
    }
    if(![self.jobButton.titleLabel.text isEqualToString:@"选择行业"]){
        [self getCodeWithName:self.jobButton.titleLabel.text withDictionary:dic];
    }
    if(![self.levelButton.titleLabel.text isEqualToString:@"学历"]){
        [self getCodeWithName:self.levelButton.titleLabel.text withDictionary:dic];
    }
}


- (void)reloadsMoreData{
    
    NSMutableDictionary *dic = [self getParameters:self.title];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showErrorWithHUD:@"请检查网络连接"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    NSString *code = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationCode"];
    NSLog(@"%@\n%@", dic[@"keywords"], dic);
    if(code != nil){
        
        [YHJobsTool getJobs:^(YHResultItem *result) {
            for(YHJobs *item in result.rows){
                [self.statusArr insertObject:item atIndex:0];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if(self.statusArr.count != 0){
                //self.pageIndex ++;
            }else{
                self.title = @"";
            }
            self.pageIndex ++;
            self.footView.text = [NSString stringWithFormat:@"共加载%d条数据",(int) self.statusArr.count];
        }pagesize:@"10" pageindex:[NSString stringWithFormat:@"%d", self.pageIndex] industryId:dic[@"industryId"]?dic[@"industryId"]:@"0" jobFunctionId:dic[@"jobFunctionId"]?dic[@"jobFunctionId"]:@"0" workLocationId:code keywords:dic[@"keywords"]?dic[@"keywords"]:@"" degreeId:dic[@"degreeId"]?dic[@"degreeId"]:@"0" workexperienceId:dic[@"workexperienceId"]?dic[@"workexperienceId"]:@"0" salaryRangeId:dic[@"salaryRangeId"]?dic[@"salaryRangeId"]:@"0" jobNatureId:@"0"];
    }else{
        [YHJobsTool getJobs:^(YHResultItem *result) {
            for(YHJobs *item in result.rows){
                [self.statusArr addObject:item];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if(self.statusArr.count != 0){
                //self.pageIndex ++;
            }else{
                self.title = @"";
            }
            self.pageIndex ++;
            self.footView.text = [NSString stringWithFormat:@"共加载%d条数据",(int) self.statusArr.count];
        }pagesize:@"10" pageindex:[NSString stringWithFormat:@"%d", self.pageIndex] industryId:dic[@"industryId"]?dic[@"industryId"]:@"0" jobFunctionId:dic[@"jobFunctionId"]?dic[@"jobFunctionId"]:@"0" workLocationId:@"0" keywords:dic[@"keywords"]?dic[@"keywords"]:@"" degreeId:dic[@"degreeId"]?dic[@"degreeId"]:@"0" workexperienceId:dic[@"workexperienceId"]?dic[@"workexperienceId"]:@"0" salaryRangeId:dic[@"salaryRangeId"]?dic[@"salaryRangeId"]:@"0" jobNatureId:@"0"];
    }
}


- (void)reloadsData{
    
    NSMutableDictionary *dic = [self getParameters:self.title];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showErrorWithHUD:@"请检查网络连接"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    NSString *code = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationCode"];
    if(code != nil){
        [YHJobsTool getJobs:^(YHResultItem *result) {
            for(YHJobs *item in result.rows){
                [self.statusArr addObject:item];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if(self.statusArr.count != 0){
                //self.pageIndex ++;
            }else{
                self.title = @"";
            }
            self.pageIndex ++;
            self.footView.text = [NSString stringWithFormat:@"共加载%d条数据",(int) self.statusArr.count];
        }pagesize:@"10" pageindex:[NSString stringWithFormat:@"%d", self.pageIndex] industryId:dic[@"industryId"]?dic[@"industryId"]:@"0" jobFunctionId:dic[@"jobFunctionId"]?dic[@"jobFunctionId"]:@"0" workLocationId:code keywords:dic[@"keywords"]?dic[@"keywords"]:@"" degreeId:dic[@"degreeId"]?dic[@"degreeId"]:@"0" workexperienceId:dic[@"workexperienceId"]?dic[@"workexperienceId"]:@"0" salaryRangeId:dic[@"salaryRangeId"]?dic[@"salaryRangeId"]:@"0" jobNatureId:@"0"];
    }else{
        [YHJobsTool getJobs:^(YHResultItem *result) {
            for(YHJobs *item in result.rows){
                [self.statusArr addObject:item];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if(self.statusArr.count != 0){
                //self.pageIndex ++;
            }else{
                self.title = @"";
            }
            self.pageIndex ++;
            self.footView.text = [NSString stringWithFormat:@"共加载%d条数据",(int) self.statusArr.count];
        }pagesize:@"10" pageindex:[NSString stringWithFormat:@"%d", self.pageIndex] industryId:dic[@"industryId"]?dic[@"industryId"]:@"0" jobFunctionId:dic[@"jobFunctionId"]?dic[@"jobFunctionId"]:@"0" workLocationId:@"0" keywords:dic[@"keywords"]?dic[@"keywords"]:@"" degreeId:dic[@"degreeId"]?dic[@"degreeId"]:@"0" workexperienceId:dic[@"workexperienceId"]?dic[@"workexperienceId"]:@"0" salaryRangeId:dic[@"salaryRangeId"]?dic[@"salaryRangeId"]:@"0" jobNatureId:@"0"];
    }
}

- (void) setSubView{
    
    [self.header addSubview:self.jobButton];
    [self.header addSubview:self.salaryButton];
    [self.header addSubview:self.jobNatureButton];
    [self.header addSubview:self.levelButton];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.header];

}

- (void) setNavBar{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *location = [defaults objectForKey:@"currentLocation"];
    UIBarButtonItem *position;
    
    
    self.navigationItem.titleView = self.BYsearchTextFd;
    UIBarButtonItem *popRoot = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelFunction)];
    [popRoot setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = popRoot;
    
    if(location == nil || location.length == 0){
        position = [[UIBarButtonItem alloc] initWithTitle:@"全国" style:UIBarButtonItemStylePlain target:self action:@selector(position)];
    }else{
        position = [[UIBarButtonItem alloc] initWithTitle:location style:UIBarButtonItemStylePlain target:self action:@selector(position)];
    }
    [position setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = position;
}

- (void)position {
    
    [self.statusArr removeAllObjects];
    [self.tableView reloadData];
    [self.footView setText:@"共加载0条数据"];
    self.pageIndex = 1;
    YHPositionViewController *position = [[YHPositionViewController alloc] init];
    [self presentViewController:position animated:YES completion:^{
    }];
}

- (void) cancelFunction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"search_collection";
    YHSearchTableViewCell *cell = [YHSearchTableViewCell cellFromTableView:tableView withIdentifier:identifier];
    //注意，此处赋值顺序不能改变，cell中的其他控件的位置均是基于iconview得到的，因此必须先初始化icon
    YHJobs *job = self.statusArr[indexPath.row];
    cell.iconName = [YHIndusToImageTool getIconWithIndustry:job.IndustryName];
    cell.job = job;
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHJobs *job = self.statusArr[indexPath.row];
    NSLog(@"as%@dds", job.CompanyNatureName);
    YHDetailInfoOfJobViewController *detail = [YHDetailInfoOfJobViewController detailInfoViewWithJob:job];
    [self.navigationController pushViewController:detail animated:YES];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.statusArr removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        self.footView.text = [NSString stringWithFormat:@"共加载%d条数据", (int)self.statusArr.count];
    }
    return;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"不感兴趣";
}


- (void)showShareView {
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"Flickr" iconName:@"post_type_bubble_flickr" glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Googleplus" iconName:@"post_type_bubble_googleplus" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Instagram" iconName:@"post_type_bubble_instagram" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Twitter" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Youtube" iconName:@"post_type_bubble_youtube" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Facebook" iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    MenuView *centerButton = [[MenuView alloc] initWithFrame:self.view.bounds items:items];
    centerButton.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        
    };
    [centerButton showMenuAtView:YHWindow];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.BYsearchTextFd resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if(textField.text.length != 0){
        self.title = textField.text;
        [self.statusArr removeAllObjects];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.footView setText:@"共加载0条数据"];
        self.pageIndex = 1;
        [self.tableView.mj_header beginRefreshing];

    }
    return YES;
}

- (void) clickFunction:(UIButton *)button{
    
    [self.statusArr removeAllObjects];
    [self.tableView reloadData];
    [self.footView setText:@"共加载0条数据"];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    self.pageIndex = 1;
    YHSearchSelectViewController *view = [[YHSearchSelectViewController alloc] initWithButton:button];
    [self.navigationController pushViewController:view animated:YES];
}

@end
