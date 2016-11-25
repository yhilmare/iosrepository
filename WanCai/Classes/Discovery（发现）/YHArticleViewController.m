//
//  YHArticleViewController.m
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHArticleViewController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "YHArticleCell.h"
#import "YHArticleList.h"
#import "AFNetworking.h"
#import "YHArticleParameter.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "YHArticleDetailViewController.h"


static NSInteger pageIndex = 0;
@interface YHArticleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *articleArr;
// 存储从plist中获取的数据
@property (nonatomic, strong) NSArray *articleParas;

@end

@implementation YHArticleViewController

- (NSArray *)articleParas {
    if (!_articleParas) {
        _articleParas = [YHArticleParameter articleParameterList];
    }
    return _articleParas;
}

- (NSArray *)articleArr {
    if (!_articleArr) {
        _articleArr = [NSMutableArray array];
    }
    return _articleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    // 添加刷新控件
    [self setUpRefreshView];
    
    [self loadMoreArticle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 刷新控件
- (void)setUpRefreshView {
    //添加下啦刷新
    self.tableView.mj_header = [self getHeader];
    
    [self.tableView.mj_header beginRefreshing];
    //加载更多
    self.tableView.mj_footer = [self getFooter];
    [self.tableView.mj_footer endRefreshing];
}

- (void)loadArticle {
    
    NSString *URLString = @"http://www.cithr.com.cn/ui/study.aspx";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:[self getParameters] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr = [YHArticleList getNewPostsWithData:responseObject];
        [self.articleArr addObjectsFromArray:arr];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        pageIndex++ ;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)loadMoreArticle {
    NSString *URLString = @"http://www.cithr.com.cn/ui/study.aspx";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:[self getParameters] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr = [YHArticleList getNewPostsWithData:responseObject];
        [self.articleArr addObjectsFromArray:arr];
        
        [self.tableView reloadData];
        YHLog(@"yyy%li",(long)pageIndex);
        pageIndex++ ;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        YHLog(@"fffffffff");
    }];
    [self.tableView.mj_footer endRefreshing];
}

- (MJRefreshNormalHeader *) getHeader{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadArticle)];
    
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
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreArticle)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    footer.refreshingTitleHidden = NO;
    return footer;
}

- (NSDictionary *)getParameters {
    YHArticleParameter *para = [self.articleParas objectAtIndex:pageIndex];
    NSDictionary *dic = [para mj_keyValues];
    return dic;
}

#pragma mark -tableViewDateSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    YHArticleCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[YHArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.parallaxRatio = 1.2f;
    }
    
    YHArticleList *art = [self.articleArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.article = art ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHArticleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSURL *url = cell.postUrl;
    //    YHArticleList *art = [self.articleArr objectAtIndex:indexPath.row];
    //    YHArticleDetailViewController *detail = [[YHArticleDetailViewController alloc] initWithURL:url andTitle:art.title];
    
    if([self.delgate respondsToSelector:@selector(didselectURL:andImageURL:)]){
        [self.delgate didselectURL:url andImageURL:cell.imageURL];
    }
}

@end
