//
//  YHOpportunityViewController.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHOpportunityViewController.h"
#import "CCDraggableContainer.h"
#import "YHCustomCardView.h"
#import "Masonry.h"
#import "YHAppearanceView.h"
#import "YHDeleteViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "YHJobsTool.h"
#import "YHJobs.h"
#import "YHResultItem.h"
#import "YHDetailInfoOfJobViewController.h"
#import "YHLikeViewController.h"

@interface YHOpportunityViewController ()<CCDraggableContainerDataSource,CCDraggableContainerDelegate,YHAppearanceViewDelgate>

@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (strong, nonatomic)  UIButton *disLikeBtn;
@property (strong, nonatomic)  UIButton *likeBtn;
@property (strong, nonatomic)  UIButton *detailBtn;
@property (nonatomic, strong) YHAppearanceView *AppView;
@property (nonatomic, assign) NSInteger temp;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation YHOpportunityViewController
#pragma mark - 懒加载
- (UIButton *)disLikeBtn {
    if (!_disLikeBtn) {
        _disLikeBtn = [[UIButton alloc] init];
    }
    return _disLikeBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
    }
    return _likeBtn;
}

- (YHAppearanceView *) AppView{
    if(!_AppView){
        _AppView = [[YHAppearanceView alloc] init];
        _AppView.frame = CGRectMake(0, self.navigationController.navigationBar.height + [[UIApplication sharedApplication] statusBarFrame].size.height, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height);
        _AppView.delgate = self;
    }
    return _AppView;
}

#pragma mark -viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.temp = -1;
    self.pageIndex = 1;
    [self loadData];
}

- (void)loadUI {
    self.view.backgroundColor = YHGray;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 64, CCWidth, CCHeight * 0.62) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.view addSubview:self.container];
    
    [self.container reloadData];
    [self addButtonView];
    
    // 右上角
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFunction)];
    
    self.navigationItem.rightBarButtonItem = right;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

}

- (void)addButtonView{
    // ButtonView
    CGFloat marginY = -40;
    CGFloat marginX = 20;
    CGFloat buttonViewH = 150;
    
    UIView *buttonView = [[UIView alloc] init];
    [self.view addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(YHScreenWidth - 2 * marginX, buttonViewH));
        make.bottom.mas_equalTo(self.view).offset(marginY);
        make.left.mas_equalTo(self.view).offset(marginX);
    }];
    
//    // 刷新按钮
//    CGFloat refreshBtnW = 28;
//    UIButton *refreshBtn = [[UIButton alloc] init];
//    [refreshBtn addTarget:self action:@selector(didClickedRefreshBtn) forControlEvents:UIControlEventAllTouchEvents];
//    [refreshBtn setImage:[UIImage imageNamed:@"opp_refresh"] forState:UIControlStateNormal];
//    [buttonView addSubview:refreshBtn];
//    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(buttonView);
//        make.size.mas_equalTo(CGSizeMake(refreshBtnW, refreshBtnW));
//    }];
    
    // 喜欢按钮
    CGFloat likeBtnW = 70;
    UIButton *likeBtn = [[UIButton alloc] init];
    [likeBtn addTarget:self action:@selector(didClickedLikeBtn) forControlEvents:UIControlEventTouchDown];
    [likeBtn setImage:[UIImage imageNamed:@"opp_liked"] forState:UIControlStateNormal];
    [buttonView addSubview:likeBtn];
    [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(likeBtnW, likeBtnW));
        make.centerY.mas_equalTo(buttonView.centerY);
        make.right.mas_equalTo(-30);
    }];
    _likeBtn = likeBtn;
    
    // 不喜欢按钮
    UIButton *dislikeBtn = [[UIButton alloc] init];
    [dislikeBtn addTarget:self action:@selector(didClickedDislikeBtn) forControlEvents:UIControlEventTouchDown];
    [dislikeBtn setImage:[UIImage imageNamed:@"opp_nope"] forState:UIControlStateNormal];
    [buttonView addSubview:dislikeBtn];
    [dislikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(likeBtnW, likeBtnW));
        make.left.mas_equalTo(30);
        make.centerY.mas_equalTo(buttonView.centerY);
    }];
    _disLikeBtn = dislikeBtn;
}

- (void) addFunction{
    
    [YHWindow addSubview:self.AppView];
    [self.AppView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
}

- (void)loadData {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    _dataSources = [NSMutableArray array];
    [YHJobsTool getJobs:^(YHResultItem *result) {
        for (YHJobs *job in result.rows) {
            if (job) {
                [self.dataSources addObject:job];
            }
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self loadUI];
    } pagesize:@"9" pageindex:[NSString stringWithFormat:@"%d", (int)self.pageIndex] industryId:@"0" jobFunctionId:@"0" workLocationId:@"3202" keywords:@"" degreeId:@"0" workexperienceId:@"0" salaryRangeId:@"0" jobNatureId:@"0"];
}

#pragma mark -按钮事件

- (void)didClickedDislikeBtn {
    [self.container remove:^(NSInteger result) {
        [self deleteFunction:self.dataSources[result]];
    } FormDirection:CCDraggableDirectionLeft];
}

- (void)didClickedLikeBtn {
    [self.container remove:^(NSInteger result) {
        [self likeFunction:self.dataSources[result]];
    } FormDirection:CCDraggableDirectionRight];
}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    YHCustomCardView *cardView = [[YHCustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void) didRemoveFromSuperViewWithTag:(NSInteger)tag withGesture:(NSInteger)direction{
    
    if(direction == 1){
        [self deleteFunction:self.dataSources[tag]];
    }else{
        [self likeFunction:self.dataSources[tag]];
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio didSelectIndex:(NSInteger)didSelectIndex {
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
        self.disLikeBtn.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        self.likeBtn.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    YHJobs *job = [self.dataSources objectAtIndex:didSelectIndex];
    YHDetailInfoOfJobViewController *detail = [YHDetailInfoOfJobViewController detailInfoViewWithJob:job];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)reloadData:(CCDraggableContainer *) draggableContainer{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [YHJobsTool getJobs:^(YHResultItem *result) {
        for (YHJobs *job in result.rows) {
            if (job) {
                [self.dataSources removeObjectAtIndex:0];
                [self.dataSources addObject:job];
            }
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [draggableContainer reloadData];
    } pagesize:@"9" pageindex:[NSString stringWithFormat:@"%d", (int)self.pageIndex] industryId:@"0" jobFunctionId:@"0" workLocationId:@"3202" keywords:@"" degreeId:@"0" workexperienceId:@"0" salaryRangeId:@"0" jobNatureId:@"0"];
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    self.container.tag = 0;
    self.pageIndex ++;
    [self reloadData:draggableContainer];
}

#pragma mark -YHAppearanceViewDelgate
- (void) didClickTableViewAtIndexPath:(NSIndexPath *)indexPath{
    [self.AppView removeFromSuperview];
    if(indexPath.row == 0){
        YHDeleteViewController *view = [[YHDeleteViewController alloc] init];
        [self.navigationController pushViewController: view animated: YES];
    }else if (indexPath.row == 1){
        YHLikeViewController  *profileCollectViewController = [[YHLikeViewController alloc] init];
        [self.navigationController pushViewController: profileCollectViewController animated: YES];
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

- (void) deleteFunction:(YHJobs *)job{
    
    NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [NSString stringWithFormat:@"%@/deleteList.plist", path];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    if(!array){//其中还没有数据，需要创建一个数据
        array = [NSMutableArray array];
        NSMutableArray *temp = [NSMutableArray array];
        if(job.JobId != nil){
            [temp addObject:job.JobId];
        }
        NSDictionary *dic = @{@"userId":userId == nil?@"-1":[userId stringValue], @"Jobs":temp};
        [array addObject:dic];
        [array writeToFile:path atomically:YES];
    }else{
        for(int i = 0; i < array.count; i++){
            NSDictionary *dic = array[i];
            if([dic[@"userId"] isEqualToString:userId == nil?@"-1":[userId stringValue]]){
                NSMutableArray *temp = dic[@"Jobs"];
                for(int k = 0; k < temp.count; k++){
                    NSString *JobId = temp[k];
                    if([JobId isEqualToString:job.JobId]){
                        [temp removeObjectAtIndex:k];
                    }
                }
                if(job.JobId != nil){
                    [temp addObject:job.JobId];
                }
                dic = @{@"userId":userId == nil?@"-1":[userId stringValue], @"Jobs":temp};
                [array replaceObjectAtIndex:i withObject:dic];
                [array writeToFile:path atomically:YES];
                break;
            }else{
                if(i == array.count - 1){
                    NSMutableArray *temp = [NSMutableArray array];
                    if(!job.JobId){
                        [temp addObject:job.JobId];
                    }
                    NSDictionary *dic = @{@"userId": userId == nil?@"-1":[userId stringValue], @"Jobs":temp};
                    [array addObject:dic];
                    [array writeToFile:path atomically:YES];
                }
            }
        }
    }
}

- (void) likeFunction:(YHJobs *)job{
    
    NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [NSString stringWithFormat:@"%@/likeList.plist", path];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    if(!array){//其中还没有数据，需要创建一个数据
        array = [NSMutableArray array];
        NSMutableArray *temp = [NSMutableArray array];
        if(job.JobId != nil){
            [temp addObject:job.JobId];
        }
        NSDictionary *dic = @{@"userId":userId == nil?@"-1":[userId stringValue], @"Jobs":temp};
        [array addObject:dic];
        [array writeToFile:path atomically:YES];
    }else{
        for(int i = 0; i < array.count; i++){
            NSDictionary *dic = array[i];
            if([dic[@"userId"] isEqualToString:userId == nil?@"-1":[userId stringValue]]){
                NSMutableArray *temp = dic[@"Jobs"];
                for(int k = 0; k < temp.count; k++){
                    NSString *JobId = temp[k];
                    if([JobId isEqualToString:job.JobId]){
                        [temp removeObjectAtIndex:k];
                    }
                }
                if(job.JobId != nil){
                    [temp addObject:job.JobId];
                }
                dic = @{@"userId":userId == nil?@"-1":[userId stringValue], @"Jobs":temp};
                [array replaceObjectAtIndex:i withObject:dic];
                [array writeToFile:path atomically:YES];
                break;
            }else{
                if(i == array.count - 1){
                    NSMutableArray *temp = [NSMutableArray array];
                    if(!job.JobId){
                        [temp addObject:job.JobId];
                    }
                    NSDictionary *dic = @{@"userId": userId == nil?@"-1":[userId stringValue], @"Jobs":temp};
                    [array addObject:dic];
                    [array writeToFile:path atomically:YES];
                }
            }
        }
    }
}


@end
