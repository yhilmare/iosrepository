//
//  YHNotificationViewController.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/3.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHNotificationViewController.h"
#import "YHNotificationTableViewCell.h"
#import "YHNotificationViewControllerInCell.h"
#import "YHMenuView.h"
#import "YHDialogueViewController.h"
#import "YHDialogue.h"
#import "YHDialogueFrame.h"

#define scoreViewHeight 40;

@interface YHNotificationViewController ()<YHNotificationViewControllerInCellDelgate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *tableviewArray;

@property (nonatomic, strong) YHMenuView *scoreView;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation YHNotificationViewController

- (YHMenuView *) scoreView{
    if(!_scoreView){
        CGFloat height = scoreViewHeight;
        _scoreView = [[YHMenuView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, height)];
        _scoreView.showsVerticalScrollIndicator = NO;
        _scoreView.showsHorizontalScrollIndicator = NO;
        [_scoreView setBackgroundColor:[UIColor whiteColor]];
    }
    return _scoreView;
}

- (UITableView *) tableView{
    if(!_tableView){
        CGFloat x = self.view.frame.origin.x;
        CGFloat y = 64 + scoreViewHeight;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height - 64 - scoreViewHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.transform = CGAffineTransformMakeRotation(270 * M_PI / 180);
        _tableView.frame = CGRectMake(x, y, width, height);
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *) tableviewArray{
    if(!_tableviewArray){
        _tableviewArray = [NSMutableArray array];
        for(int i = 0; i < self.buttonArray.count; i++){
            YHNotificationViewControllerInCell *table = [[YHNotificationViewControllerInCell alloc] init];
            table.viewTag = i;
            table.delgate = self;
            [_tableviewArray addObject:table];
        }
    }
    return _tableviewArray;
}

- (NSMutableArray *) buttonArray{
    if(!_buttonArray){
        _buttonArray = [NSMutableArray array];
        NSArray *array = @[@"我的私信", @"面试通知"];
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



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"消息";
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [self setSubViews];
    
    [self setSubButton];
    
}

- (void) setSubButton{
    
    CGFloat height = scoreViewHeight;
    CGFloat buttonHeight = height * 0.8;
    CGFloat y = (height - buttonHeight) / 2.0;
    CGFloat offset = 100;
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
        [self.scoreView addSubview:button];
        x = CGRectGetMaxX(button.frame) + temp;
    }

    self.scoreView.contentSize = CGSizeMake(x , height);
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.view.frame.size.width;
}

- (void) setSubViews{
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.scoreView];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.buttonArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"test_notification";
    YHNotificationTableViewCell *cell = [YHNotificationTableViewCell cellFromTableView:tableView withIdentifier:identifier];
    cell.tableView = self.tableviewArray[indexPath.row];
    return cell;
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

- (void) didSelectedAtIndexPath:(NSIndexPath *)path withTag:(NSInteger)viewTag andDialogueModel:(YHDialogue *)dia{
    
    YHDialogueFrame *frame = [[YHDialogueFrame alloc] init];
    dia.ShowTime = YES;
    frame.dia = dia;
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[frame]];
    YHDialogueViewController *dialogue = [[YHDialogueViewController alloc] initWithArray:array];
    dialogue.title = dia.comName;
    [self.navigationController pushViewController:dialogue animated:YES];
}


@end
