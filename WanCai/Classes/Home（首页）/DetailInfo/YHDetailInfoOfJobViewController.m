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
 
 
#import "YHDetailInfoOfJobViewController.h"
#import "YHJobs.h"
#import "YHButtomView.h"
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
#import "YHMyFavoriteJob.h"
#import "YHCompanyDetailInfoViewController.h"
#import "Reachability.h"
#import "YHIndusToImageTool.h"
#import "YHAlertView.h"
#import "YHResume.h"
#import "YHResumeTool.h"
#import "YHStringTools.h"


@import Accelerate;

@interface YHDetailInfoOfJobViewController ()<YHAlertViewDelgate,YHButtomViewDelgate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) YHJobs *Job;

@property (nonatomic, strong) YHButtomView *bottomView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YHCompanyMsg *companyInfo;

@property (nonatomic, copy) NSMutableArray *favouriteArray;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray *resumeArray;//所有已知简历存放在这个数组中

@end

@implementation YHDetailInfoOfJobViewController

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

- (NSMutableArray *) resumeArray{
    if(!_resumeArray){
        _resumeArray = [NSMutableArray array];
    }
    return _resumeArray;
}

- (UIImageView *) imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (NSMutableArray *) favouriteArray{
    if(!_favouriteArray){
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *location = [NSString stringWithFormat:@"%@/favouriteLists.plist", path];
        _favouriteArray = [NSMutableArray arrayWithContentsOfFile:location];
        if(_favouriteArray.count == 0){
            _favouriteArray = [NSMutableArray array];
        }
    }
    return _favouriteArray;
}

- (YHCompanyMsg *)companyInfo{
    
    if(!_companyInfo){
        _companyInfo = [[YHCompanyMsg alloc] init];
        [_companyInfo setCompanyRequired:[YHStringTools htmlEntityDecode:_Job.JobRequirements]];
        [_companyInfo setCompanyDescribtion:_Job.JobDescription];
        [_companyInfo setCompanyAddress:_Job.CompanyAddress];
        [_companyInfo setCompanyContactPerson:_Job.CompanyContact];
        [_companyInfo setCompanyContact:_Job.Contact];
        [_companyInfo setCompanyIndustryName:_Job.IndustryName];
    }
    return _companyInfo;
}

- (YHButtomView *) bottomView{
    if(!_bottomView){
        CGFloat itemHeight = 49 / YHScreenHeight;
        CGFloat itemYPer = 1 - itemHeight;
        _bottomView = [[YHButtomView alloc] initWithFrame:[self calculateFramUtils:1 itemHeight:itemHeight itemY:itemYPer itemX:0]];
        _bottomView.backgroundColor = YHColor(240, 240, 240);
        _bottomView.delgate = self;
    }
    return _bottomView;
}


- (UITableView *) tableView{
    if(!_tableView){
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat tableViewHeight = screenHeight - screenHeight * 49 / YHScreenHeight - 64;
        CGRect frame = CGRectMake(0, 64, self.view.frame.size.width, tableViewHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 12);
    }
    return _tableView;
}

- (void) showImageInViewWithBlur:(CGFloat) blur{//显示模糊背景并显示简历选择
    
    if(blur < 0 || blur > 1){
        blur = 0.5;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIImage *image = [self getImage];
    image = [self blurryImage:image withBlurLevel:blur];
    [self.imageView setImage:image];
    [window addSubview:self.imageView];
    self.imageView.frame = window.frame;
    
    image = [self getImage];
    [self.imageView removeFromSuperview];
    image = [self blurryImage:image withBlurLevel:blur];
    [self.imageView setImage:image];
    
    CGFloat width = (YHScreenWidth <= 320) ? YHScreenWidth - 50 : 330;
    CGFloat height = 80;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - width) / 2.0;
    CGFloat y = (self.imageView.frame.size.height - height) / 2.0;
    
    YHAlertView *view = [[YHAlertView alloc] initWithFrame:CGRectMake(x, y, width, height) andResumeArray:self.resumeArray];
    view.delgate = self;
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = self.imageView.frame;
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(cancelFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView addSubview:button];
    [self.imageView addSubview:view];
    [window addSubview:self.imageView];
    
    view.transform = CGAffineTransformMakeTranslation(0, - self.view.frame.size.height);

    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
}
- (void) clickFunction:(NSInteger)tag{//点击具体简历时调用这个函数
    
    NSLog(@"%@", self.resumeArray[tag]);
    YHResume *resume = self.resumeArray[tag];
    CGFloat rate = [resume.ResumeIntergrity floatValue];
    if(rate < 40){
        [self cancelFunction];
        [self showErrorWithHUD:@"简历的完成度必须大于40％才可以投递"];
    }else{//此处简历已经可以投递，do something
        [self cancelFunction];
        NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        MBProgressHUD *hud = [self showMessage:@"申请中..."];
        [hud showAnimated:YES];
        [YHJobsTool applyJob:^(YHReturnMsg *result) {
            [hud hideAnimated:YES];
            if([result.msg isEqualToString:@"申请职位成功！"]){
                [self showSuccessInfoWithHUD:@"恭喜您，职位申请成功！"];
            }else{
                [self showErrorWithHUD:result.msg];
            }
        } withuserId:[userId stringValue] jobIds:self.Job.JobId resumeId:resume.ResumeId];
    }
}

- (MBProgressHUD *) showMessage:(NSString *)msg{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    hud.label.text = msg;
    return hud;
}

- (void) cancelFunction{
    
    for(UIView *view in self.imageView.subviews){
        [view removeFromSuperview];
    }
    [self.imageView removeFromSuperview];
}

- (void) didClickButton:(UIButton *)button{
    
    NetworkStatus status =  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    if(button.tag == 0){
        [button setBackgroundColor:[UIColor colorWithRed:0 green:175/255.0 blue:240/255.0 alpha:1]];
        NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        if(userId == nil){
            [self showErrorWithHUD:@"您还没有登录"];
            return;
        }
        [self.resumeArray removeAllObjects];
        [YHResumeTool getResumeList:^(YHResultItem *result) {
            for(YHResume *resume in result.rows){
                [self.resumeArray addObject:resume];
            }
            [self showImageInViewWithBlur:0.5];
        } withuserId:[userId stringValue]];
        NSLog(@"投递简历");
    }else if(button.tag == 1){
        [button setBackgroundColor:[UIColor colorWithRed:66 / 255.0 green:200/255.0 blue:125/255.0 alpha:1]];
        NSString *ID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        NSString *userId = [NSString stringWithFormat:@"%@", ID];
        if(ID == nil || userId.length == 0){
            [self showErrorWithHUD:@"您还没有登录"];
            return;
        }
        [YHJobsTool addFavoriteJob:^(YHReturnMsg *result) {
            if ([result.result isEqualToString:@"true"] && [result.msg isEqualToString:@"收藏职位成功！"]){
                [self showSuccessInfoWithHUD:@"收藏成功"];
                [self writeFavouriteToFile:self.Job.JobId anduserId:userId];
                [button setBackgroundColor:[UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1]];
                button.userInteractionEnabled = NO;
            }else{
                [self showErrorWithHUD:@"收藏失败"];
            }
        } withuserId:userId jobIds:self.Job.JobId];
    }
}

- (void) writeFavouriteToFile:(NSString *) jobID anduserId:(NSString *)userId{
    
    int j = 0;
    if(self.favouriteArray.count == 0){
        NSDictionary *dic = @{@"userId":userId, @"jobID":@[jobID]};
        [self.favouriteArray addObject:dic];
    }else{
        j = 1;
        int i = 0;
        for(NSDictionary *dic in self.favouriteArray){
            if ([dic[@"userId"] isEqualToString:userId]) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"jobID"]];
                [array addObject:jobID];
                NSDictionary *dic = @{@"userId":userId, @"jobID":array};
                [self.favouriteArray replaceObjectAtIndex:i withObject:dic];
                NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *location = [NSString stringWithFormat:@"%@/favouriteLists.plist", path];
                [self.favouriteArray writeToFile:location atomically:YES];
                return;
            }
            i ++;
        }
    }
    
    if(j == 1){
        NSDictionary *dic = @{@"userId":userId, @"jobID":@[jobID]};
        [self.favouriteArray addObject:dic];
    }
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *location = [NSString stringWithFormat:@"%@/favouriteLists.plist", path];
    [self.favouriteArray writeToFile:location atomically:YES];

}

- (void) showErrorWithHUD:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    [hud hideAnimated:YES afterDelay:2];
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
        
    for(NSDictionary *dic in self.favouriteArray){
        if([dic[@"userId"] isEqualToString:userId]){
            for(NSString *item in dic[@"jobID"]){
                if([item isEqualToString:self.Job.JobId]){
                    self.bottomView.collectButton.userInteractionEnabled = NO;
                    [self.bottomView.collectButton setBackgroundColor:[UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1]];
                }
            }
        }
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
    
    static NSString *identifier = @"detailInfo_identifier";
    static NSString *identifier1 = @"detailInfo_identifier1";
    static NSString *identifier2 = @"detailInfo_identifier2";
    static NSString *identifier3 = @"detailInfo_identifier3";
    if (indexPath.row == 0){
        YHHeaderTableViewCell *headerCell = [YHHeaderTableViewCell cellWithIdentifier:identifier tableView:tableView];
        headerCell.iconName = [YHIndusToImageTool getIconWithIndustry:self.companyInfo.CompanyIndustryName];
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
+ (instancetype) detailInfoViewWithJob:(YHJobs *)job{
    return  [[self alloc] initWithJob:job];
}

- (instancetype)initWithJob:(YHJobs *)Job{
    if(self = [super init]){
        _Job = Job;
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"职位详情";
    }
    return self;
}

- (UIImage *)getImage{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {//图片模糊

    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}
@end
