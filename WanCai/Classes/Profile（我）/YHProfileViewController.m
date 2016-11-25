//
//  YHProfileViewController.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileViewController.h"
#import "YHProfileInfomationViewController.h"
#import "YHProfileResumeViewController.h"
#import "YHProfileCollectViewController.h"
#import "YHLoginViewController.h"
#import "YHRegisteViewController.h"
#import "YHUserBasicInfoTool.h"
#import "YHUserBasicInfo.h"
#import "YHResultItem.h"
#import "YHReturnMsg.h"
#import "YHUserInfo.h"
#import "Reachability.h"
#import "Masonry.h"
#import "UIImage+YHResize.h"
#import "AGSimpleImageEditorView.h"
#import "YHUserBasicInfoTool.h"
#import "YHUserBasicInfo.h"
#import "YHResultItem.h"
#import "YHProfileCareViewController.h"
#import "YHProfileSettingViewController.h"
#import "YHProfileApplyViewViewController.h"
#import "YHNotificationViewController.h"
#import "YHUserIconTool.h"
#import "UIImageView+WebCache.h"
#import "UINavigationBar+YHAwesome.h"

// 图床相关
const CGFloat BACKGROUND_HEIGHT = 235;

typedef NS_ENUM(NSUInteger, YHProfileSubViewType) {
    YHProfileInfomationView = 0,
    YHProfileResumeView,
    YHProfileAttentionView,
    YHProfileApplicationView,
    YHProfileCollectView,
    YHProfileMessageView
};

@interface YHProfileViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIView        *backgroundView;
@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UIImageView      *avator;  //头像
@property (nonatomic, strong) UIButton      *loginButton;
@property (nonatomic, strong) UIButton      *infoButton;
@property (nonatomic, strong) UIButton      *telAndMailButton;
@property (nonatomic, strong) YHUserInfo    *info;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation YHProfileViewController

#pragma mark - QINIU Method


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YHGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 插入tableview
    [self.view addSubview: self.tableView];
    
    // 增加头像设置View
    [self.view addSubview: self.headView];
    [self.view addSubview: self.avator];
    [self.view addSubview: self.loginButton];
    [self.view addSubview: self.infoButton];
    [self.view addSubview: self.telAndMailButton];
    
    [self.loginButton addTarget:self action:@selector(loginFunction) forControlEvents:UIControlEventTouchUpInside];
    
    // nav按钮
    UIBarButtonItem *rightButton = [UIBarButtonItem barButtonItemWithImage:@"profile_set" highImage:@"" target:self action:@selector(clickSettingButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    // 布局调整
    [self layout];
}

- (UIButton *)telAndMailButton {
    if(!_telAndMailButton) {
        _telAndMailButton = [[UIButton alloc] init];
        [_telAndMailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _telAndMailButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _telAndMailButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _telAndMailButton;
}

- (UIButton *)infoButton{
    if(!_infoButton){
        _infoButton = [[UIButton alloc] init];
        [_infoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _infoButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _infoButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoButton;
}

- (void) loginFunction{
    
    YHLoginViewController *loginController = [[YHLoginViewController alloc] init];
    [self presentViewController:loginController animated:YES completion:^{
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar yhSetBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage: [[UIImage alloc] init]];
    //判断是否已经登录
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userId = [defaults objectForKey:@"userId"];
    if(userId == nil){
        self.infoButton.hidden = YES;
        self.loginButton.hidden = NO;
        self.telAndMailButton.hidden = YES;
        [self.avator setImage:[UIImage imageNamed:@"place_holder"]];
    }else{
        self.loginButton.hidden = YES;
        self.infoButton.hidden = NO;
        self.telAndMailButton.hidden = NO;
        NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
        if(status == NotReachable){
            NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *path = [NSString stringWithFormat:@"%@/%@.plist", dir, userId];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            UIImage *img = [[manager imageCache] imageFromDiskCacheForKey:@"touxiang"];
            [self.avator setImage:img == nil?[UIImage imageNamed:@"place_holder"]:img];
            self.info = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            [self.infoButton setTitle:self.info.userName forState:UIControlStateNormal];
        }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            [YHUserBasicInfoTool getUserBasicInfo:^(YHResultItem *result) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                YHUserBasicInfo *info = [result.rows firstObject];
                if(info.Photo.length == 0){
                    [self.avator setImage:[UIImage imageNamed:@"place_holder"]];
                }else{
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    UIImage *img = [[manager imageCache] imageFromDiskCacheForKey:@"touxiang"];
                    if(img){
                        [self.avator setImage:img];
                    }
                    [[manager imageDownloader] downloadImageWithURL:[NSURL URLWithString:info.Photo] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                        if(image && ![img isEqual:image]){
                            [self.avator setImage:image];
                            [[manager imageCache] storeImage:image forKey:@"touxiang" toDisk:YES];
                        }else{
                            UIImage *img = [[manager imageCache] imageFromDiskCacheForKey:@"touxiang"];
                            [self.avator setImage:img == nil?[UIImage imageNamed:@"place_holder"]:img];
                        }
                    }];
                }
                [self.infoButton setTitle:info.UserName forState:UIControlStateNormal];
                [self.telAndMailButton setTitle:[NSString stringWithFormat:@"%@ | %@",info.Mobile,info.Email] forState:UIControlStateNormal];
            } withuserId:[userId stringValue]];
        }
    }
}

- (YHUserInfo *)info{
    if(!_info){
        _info = [[YHUserInfo alloc] init];
    }
    return _info;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar yhSetBackgroundColor:YHBlue];
    [super viewWillDisappear:animated];
}

- (void) layout {
    [self.avator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headView).with.offset(0);
        make.top.equalTo(self.avator.mas_bottom).with.offset(10);
    }];
    [self.telAndMailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headView.mas_centerX);
        make.top.equalTo(self.infoButton.mas_top).with.offset(20);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headView).with.offset(0);
        make.top.equalTo(self.avator.mas_bottom).with.offset(10);
    }];
}

#pragma mark - 设置点击事件
- (void) clickSettingButton {
    YHProfileSettingViewController *setting = [[YHProfileSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 2;
    }else{
        return 4;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return 15;
    }
    return 10;
}

//注：由于分组，在section1中的枚举值要减去2才能得到正确的结果

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case YHProfileInfomationView: {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSNumber *userId = [defaults objectForKey:@"userId"];
                if(userId == nil){
                    YHLoginViewController *loginView = [[YHLoginViewController alloc] init];
                    [self presentViewController:loginView animated:YES completion:^{
                        
                    }];
                }else{
                    YHProfileInfomationViewController *profileInfomationViewController = [[YHProfileInfomationViewController alloc] init];
                    [self.navigationController pushViewController: profileInfomationViewController animated: YES];
                }
                break;
            }
            case YHProfileResumeView: {
                YHProfileResumeViewController *profileResumeViewController = [[YHProfileResumeViewController alloc] init];
                [self.navigationController pushViewController: profileResumeViewController animated: YES];
            }
        }
        
    }else{
        switch (indexPath.row) {
                
            case YHProfileAttentionView - 2: {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSNumber *userId = [defaults objectForKey:@"userId"];
                if(userId == nil){
                    YHLoginViewController *loginView = [[YHLoginViewController alloc] init];
                    [self presentViewController:loginView animated:YES completion:^{
                        
                    }];
                }else{
                    YHProfileCareViewController *careViewController = [[YHProfileCareViewController alloc] init];
                    [self.navigationController pushViewController: careViewController animated: YES];
                }
                break;
            }
            case YHProfileApplicationView - 2:{//查看我的申请
                NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
                if(userId == nil){
                    YHLoginViewController *loginView = [[YHLoginViewController alloc] init];
                    [self presentViewController:loginView animated:YES completion:^{
                        
                    }];
                }else{
                    YHProfileApplyViewViewController *view = [[YHProfileApplyViewViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
                break;
            }
            case YHProfileCollectView - 2: {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSNumber *userId = [defaults objectForKey:@"userId"];
                if(userId == nil){
                    YHLoginViewController *loginView = [[YHLoginViewController alloc] init];
                    [self presentViewController:loginView animated:YES completion:^{
                        
                    }];
                }else{
                    YHProfileCollectViewController  *profileCollectViewController = [[YHProfileCollectViewController alloc] init];
                    [self.navigationController pushViewController: profileCollectViewController animated: YES];
                }
                break;
            }
            case YHProfileMessageView - 2: {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSNumber *userId = [defaults objectForKey:@"userId"];
                if(userId == nil){
                    YHLoginViewController *loginView = [[YHLoginViewController alloc] init];
                    [self presentViewController:loginView animated:YES completion:^{
                        
                    }];
                }else{
                    YHNotificationViewController  *notification = [[YHNotificationViewController alloc] init];
                    [self.navigationController pushViewController: notification animated: YES];
                }
                break;
            }
            default: break;
        }
    }
}



#pragma mark - DataSourceDelegate
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: @"cell"];
    cell = [tableView dequeueReusableCellWithIdentifier: @"cell" forIndexPath: indexPath];
    
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case YHProfileInfomationView: {
                cell.imageView.image = [UIImage imageNamed:@"myprofile2"];
                cell.textLabel.text = @"个人资料";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case YHProfileResumeView: {
                cell.imageView.image = [UIImage imageNamed:@"my_resume2"];
                cell.textLabel.text = @"我的简历";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            default: break;
        }
        
    }else{
        switch (indexPath.row) {
            case YHProfileAttentionView - 2: {
                cell.imageView.image = [UIImage imageNamed:@"attention_to_me2"];
                cell.textLabel.text = @"谁看过我";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case YHProfileApplicationView - 2: {
                cell.imageView.image = [UIImage imageNamed:@"my_application2"];
                cell.textLabel.text = @"我的申请";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case YHProfileCollectView - 2: {
                cell.imageView.image = [UIImage imageNamed:@"my_collect2"];
                cell.textLabel.text = @"职位收藏夹";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case YHProfileMessageView - 2: {
                cell.imageView.image = [UIImage imageNamed:@"circular2"];
                cell.textLabel.text = @"消息通知";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            default: break;
        }
        
    }
    return cell;

    
}

#pragma mark -UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat hei = -offsetY;
    CGFloat rate = offsetY / 235;
    self.headView.frame = CGRectMake(0, 0, self.view.frame.size.width, hei);
    self.imgView.frame = CGRectMake(self.imgView.frame.origin.x, 0, self.imgView.frame.size.width, hei);
    if(-rate >= 1){
        self.imgView.transform = CGAffineTransformMakeScale(-rate, 1);
    }

    CGFloat x0 = BACKGROUND_HEIGHT - self.navigationController.navigationBar.frame.size.height - 20;
    CGFloat x1 = hei - self.navigationController.navigationBar.frame.size.height - 20;
    
    if (x1 / x0 < 1) {
        self.avator.alpha = x1 / x0;
        self.loginButton.alpha = x1 / x0;
        self.infoButton.alpha = x1 / x0;
        self.telAndMailButton.alpha = x1 / x0;
    }
}


#pragma mark - Lazy Initial
- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(BACKGROUND_HEIGHT, 0, 0, 0);
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = YHGray;
        [_tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"cell"];
    }
    return _tableView;
}


- (UIView *) headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, BACKGROUND_HEIGHT)];
        self.imgView.frame = _headView.frame;
        [_headView addSubview:self.imgView];
    }
    return _headView;
}

- (UIImageView *) imgView{
    if(!_imgView){
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"background"]];
    }
    return _imgView;
}

- (UIImageView *) avator {
    if (!_avator) {
        _avator = [[UIImageView alloc] init];
        _avator.frame = CGRectMake(0, 0, 100, 100);
        _avator.layer.cornerRadius = _avator.frame.size.height / 2.f;
        _avator.layer.masksToBounds = YES;
        _avator.layer.borderWidth = 2;
        _avator.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
    return _avator;
}

- (UIButton *)loginButton{
    if(!_loginButton){
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        [_loginButton setTitle:@"请登录/注册" forState:UIControlStateNormal];
        _loginButton.titleLabel.textColor = [UIColor whiteColor];
    }
    return _loginButton;
}

@end
