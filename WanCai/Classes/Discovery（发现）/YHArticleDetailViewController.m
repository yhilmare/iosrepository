//
//  YHArticleDetailViewController.m
//  WanCai
//
//  Created by CheungKnives on 16/7/24.
//  Copyright © 2016年 SYYH. All rights reserved.
//


#import "YHArticleDetailViewController.h"
#import "LWAlertView.h"
#import "Gallop.h"
#import "LWImageBrowser.h"
#import "MenuView.h"



@interface YHArticleDetailViewController ()<LWHTMLDisplayViewDelegate>

@property (nonatomic,strong) LWHTMLDisplayView* htmlView;
@property (nonatomic,strong) UILabel* coverTitleLabel;
@property (nonatomic,strong) UILabel* coverDesLabel;
@property (nonatomic,assign) BOOL isNeedRefresh;

@end

@implementation YHArticleDetailViewController

#pragma mark - ViewControllerLifeCycle

- (void)loadView {
    [super loadView];
    
    self.isNeedRefresh = YES;
    self.title = @"文章详情";
    self.view.backgroundColor = YHGray;
    self.htmlView = [[LWHTMLDisplayView alloc] initWithFrame:self.view.bounds parentVC:self];
    self.htmlView.displayDelegate = self;
    [self.view addSubview:self.htmlView];
    
    UIView* mskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250.0f)];
    mskView.backgroundColor = RGB(0, 0, 0, 0.25f);
    [self.htmlView addSubview:mskView];
    
    self.coverTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 150.0f, SCREEN_WIDTH - 20.0f, 80.0f)];
    self.coverTitleLabel.textColor = [UIColor whiteColor];
    self.coverTitleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20.0f];
    self.coverTitleLabel.numberOfLines = 0;
    self.coverTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.htmlView addSubview:self.coverTitleLabel];
    
    self.coverDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 230.0f, SCREEN_WIDTH - 20.0f, 20.0f)];
    self.coverDesLabel.textColor = [UIColor whiteColor];
    self.coverDesLabel.font = [UIFont fontWithName:@"Heiti SC" size:10.0f];
    self.coverDesLabel.numberOfLines = 0;
    self.coverDesLabel.textAlignment = NSTextAlignmentRight;
    [self.htmlView addSubview:self.coverDesLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:@"share.png" highImage:@"" target:self action:@selector(shareFunction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    if (self.isNeedRefresh) {
        self.isNeedRefresh = NO;
        [self _parsing];
    }
}


#pragma mark - Data
- (void)downloadDataCompletion:(void(^)(NSData* data))completion {
    NSURLSession* session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:self.URL];
    NSURLSessionDataTask* task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData * _Nullable data,
                                   NSURLResponse * _Nullable response,
                                   NSError * _Nullable error) {
                   completion(data);
               }];
    [task resume];
}

#pragma mark - Parsing
- (void)_parsing {
    __weak typeof(self) weakSelf = self;
    [self downloadDataCompletion:^(NSData *data) {
        __strong typeof(weakSelf) swself = weakSelf;
        swself.htmlView.data = data;
        
        LWHTMLLayout *htmlLayout = [[LWHTMLLayout alloc] init];
        LWStorageBuilder *builder = swself.htmlView.storageBuilder;
    
        /** cover  **/
        LWHTMLImageConfig* coverConfig = [[LWHTMLImageConfig alloc] init];
        coverConfig.size = CGSizeMake(SCREEN_WIDTH, 250.0f);
        [builder createLWStorageWithXPath:@"//div[@class='img-wrap']/img"
                               edgeInsets:UIEdgeInsetsMake(0.0f, 0, 5.0f, 0)
                         configDictionary:@{@"img":coverConfig}];
        [htmlLayout addStorages:builder.storages];
        
        /** cover title **/
        [builder createLWStorageWithXPath:@"//div[@class='news_title mb']"];
        NSString* coverTitle = [builder contents];
        
        /** cover description **/
        [builder createLWStorageWithXPath:@"//div[@class='learn_date left']"];
        NSString* coverDes = [builder contents];
        
        /**ImageView**/
        LWImageStorage *imageStorage = [[LWImageStorage alloc] init];
        imageStorage.contents = [NSURL URLWithString:self.imageURL];
        imageStorage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
        [htmlLayout addStorage:imageStorage];
        
        
        /** content  **/
        LWHTMLTextConfig *contentConfig = [[LWHTMLTextConfig alloc] init];
        contentConfig.font = [UIFont fontWithName:@"Heiti SC" size:15.0f];
        contentConfig.textColor = RGB(50, 50, 50, 1);
        contentConfig.linkColor = RGB(232, 104, 96,1.0f);
        contentConfig.linkHighlightColor = RGB(0, 0, 0, 0.35f);
        
        LWHTMLTextConfig* strongConfig = [[LWHTMLTextConfig alloc] init];
        strongConfig.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15.0f];
        strongConfig.textColor = [UIColor blackColor];
        
        LWHTMLImageConfig *imageConfig = [[LWHTMLImageConfig alloc] init];
        imageConfig.size = CGSizeMake(SCREEN_WIDTH - 20.0f, 240.0f);
        imageConfig.needAddToImageBrowser = YES;//将这个图片加入照片浏览器
        imageConfig.autolayoutHeight = YES;//自动按照图片的大小匹配一个适合的高度
        
        [builder createLWStorageWithXPath:@"//div[@class='news_text']/p"
                               edgeInsets:UIEdgeInsetsMake(10.0f, 20.0f, 10.0, 20.0f)
                         configDictionary:@{@"p":contentConfig,
                                            @"strong":strongConfig,
                                            @"em":strongConfig,
                                            @"img":imageConfig}];
        
        [htmlLayout addStorages:builder.storages];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            swself.htmlView.layout = htmlLayout;
            swself.coverTitleLabel.text = coverTitle;
            swself.coverDesLabel.text = coverDes;
        });
    }];
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


@end
