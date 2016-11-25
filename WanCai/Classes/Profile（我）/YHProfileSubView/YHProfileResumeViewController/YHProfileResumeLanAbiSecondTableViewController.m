//
//  YHProfileResumeLanAbiSecondTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeLanAbiSecondTableViewController.h"

@interface YHProfileResumeLanAbiSecondTableViewController ()

@property (nonatomic, strong) UIButton      *rightButton;
@end

@implementation YHProfileResumeLanAbiSecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
}

- (UIBarButtonItem *) rightButtonItem {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
        [_rightButton setTitle: @"保存" forState: UIControlStateNormal];
        [_rightButton setTitleColor: YHWhite forState: UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(addEduExp) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithCustomView: _rightButton];
    return res;
}

- (void) addEduExp {
    
}

@end
