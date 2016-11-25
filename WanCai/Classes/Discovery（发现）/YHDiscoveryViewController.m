//
//  YHDiscoveryViewController.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDiscoveryViewController.h"
#import "YHMenuView.h"
#import "YHDiscoveryTableViewCell.h"
#import "YHArticleViewController.h"
#import "YHTopicViewController.h"
#import "YHTalkViewController.h"
#import "YHArticleDetailViewController.h"



#define scoreViewHeight 40;

@interface YHDiscoveryViewController ()<UITableViewDataSource, UITableViewDelegate, YHYHArticleViewControllerDelgate>

@property (nonatomic, strong) YHMenuView *menuView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) NSMutableArray *tableviewArray;

@end

@implementation YHDiscoveryViewController

- (NSMutableArray *) tableviewArray{
    if(!_tableviewArray){
        _tableviewArray = [NSMutableArray array];
        YHArticleViewController *article = [[YHArticleViewController alloc] init];
        article.delgate = self;
        YHTopicViewController *topic = [[YHTopicViewController alloc] init];
        YHTalkViewController *talk = [[YHTalkViewController alloc] init];
        [_tableviewArray addObject:article];
        [_tableviewArray addObject:topic];
        [_tableviewArray addObject:talk];
    }
    return _tableviewArray;
}

- (NSMutableArray *) buttonArray{
    if(!_buttonArray){
        _buttonArray = [NSMutableArray array];
        NSArray *array = @[@"文章", @"话题", @"大神"];
        for(int i = 0; i < array.count; i++){
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
            button.tag = i;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArray addObject:button];
        }
    }
    return _buttonArray;
}


- (UITableView *) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        CGFloat x = self.view.frame.origin.x;
        CGFloat y = 64 + scoreViewHeight;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height - 113 - scoreViewHeight;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.transform = CGAffineTransformMakeRotation(270 * M_PI / 180);
        _tableView.frame = CGRectMake(x, y, width, height);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
    }
    return _tableView;
}

- (YHMenuView *) menuView{
    if(!_menuView){
        CGFloat height = scoreViewHeight;
        _menuView = [[YHMenuView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, height)];
        _menuView.showsVerticalScrollIndicator = NO;
        _menuView.showsHorizontalScrollIndicator = NO;
        _menuView.scrollEnabled = NO;
        [_menuView setBackgroundColor:[UIColor whiteColor]];
    }
    return _menuView;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickButton)];
    
    [self setSubViews];
    
    [self setSubButton];
}

- (void) clickButton{
    
}

- (void) setSubViews{
    
    [self.view addSubview:self.tableView];

    [self.view addSubview:self.menuView];
}

- (void) setSubButton{
    
    CGFloat height = scoreViewHeight;
    CGFloat buttonHeight = height * 0.8;
    CGFloat y = (height - buttonHeight) / 2.0;
    CGFloat offset = 80;
    CGFloat x = offset;
    CGFloat temp = 0;
    
    for(UIButton *button in self.buttonArray){
        CGSize size = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, buttonHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        temp += size.width;
    }
    temp = [UIScreen mainScreen].bounds.size.width - 2 * offset - temp;
    temp /= (self.buttonArray.count - 1);
    
    for(UIButton *button in self.buttonArray){
        
        CGSize size = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, buttonHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        button.frame = CGRectMake(x, y, size.width, buttonHeight);
        if(button.tag == 0){
            [button setTitleColor:[UIColor colorWithRed:231 / 255.0 green:57 / 255.0 blue:26 / 255.0 alpha:1] forState:UIControlStateNormal];
            button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }
        [self.menuView addSubview:button];
        x = CGRectGetMaxX(button.frame) + temp;
    }
    self.menuView.contentSize = CGSizeMake(x , height);
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.width;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"discovery_identifier";
    
    YHDiscoveryTableViewCell *cell = [YHDiscoveryTableViewCell cellWithTableView:tableView withIdentifier:identifier];
    cell.viewController = self.tableviewArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) clickFunction:(UIButton *) button{
    
    for(UIButton *buttons in self.buttonArray){
        [buttons setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if(buttons.tag != button.tag){
            buttons.transform = CGAffineTransformMakeScale(1, 1);
        }
    }
    [button setTitleColor:[UIColor colorWithRed:231 / 255.0 green:57 / 255.0 blue:26 / 255.0 alpha:1] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.tableView.contentOffset = CGPointMake(0 ,button.tag * [UIScreen mainScreen].bounds.size.width);
    }];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:scrollView.contentOffset];
    UIButton *button = self.buttonArray[path.row];
    
    for(UIButton *buttons in self.buttonArray){
        [buttons setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if(buttons.tag != button.tag){
            buttons.transform = CGAffineTransformMakeScale(1, 1);
        }
    }
    
    [button setTitleColor:[UIColor colorWithRed:231 / 255.0 green:57 / 255.0 blue:26 / 255.0 alpha:1] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
}

- (void) didselectURL:(NSURL *)url andImageURL:(NSString *)imgurl{
    
    YHArticleDetailViewController *detail = [[YHArticleDetailViewController alloc] init];
    detail.URL = url;
    detail.imageURL = imgurl;
    [self.navigationController pushViewController:detail animated:YES];
}

@end






