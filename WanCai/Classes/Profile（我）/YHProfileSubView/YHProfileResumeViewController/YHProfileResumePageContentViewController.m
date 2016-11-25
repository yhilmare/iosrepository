//
//  YHProfileResumePageContentViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/7/25.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumePageContentViewController.h"
#import "YHProfileResumeCategoryTableViewController.h"
#import "PNChart.h"
#import "PNCircleChart.h"
#import "Masonry.h"

@interface YHProfileResumePageContentViewController ()
@property (weak, nonatomic) IBOutlet UIView *profileBgView;

@property (weak, nonatomic) IBOutlet UILabel *resumeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expectJobLabel;
@property (weak, nonatomic) IBOutlet UILabel *basicMsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *seleveluationLabel;
@property (weak, nonatomic) IBOutlet UILabel *expectSalaryLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileResumeViewHeight;
@end

@implementation YHProfileResumePageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileResumeViewHeight.constant = ([UIScreen mainScreen].bounds.size.height) * 440.f / 667.f - 10;
    
    self.profileBgView.layer.cornerRadius = 40;
    self.profileBgView.layer.masksToBounds = YES;
    
    [self.profileBgView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.profileBgView.layer setShadowOpacity:0.5];
    [self.profileBgView.layer setShadowOffset:CGSizeMake(0, 2.0)];
    
    self.resumeNameLabel.text = self.resumenName;
    self.userNameLabel.text = self.userName;
    
    if (self.expectJob && self.expectJob.length > 0)
        self.expectJobLabel.text = [NSString stringWithFormat:@"意向：%@", self.expectJob];
    if (self.msgArr && self.msgArr.count > 0) {
        int cnt = 0;
        NSMutableString *msgs = [NSMutableString stringWithString:@""];
        for (NSString *msg in self.msgArr) {
            if (cnt == 0) {
                [msgs appendString:msg];
            } else {
                [msgs appendString:[NSString stringWithFormat:@" | %@", msg]];
            }
            cnt ++;
        }
        if (msgs.length > 0) self.basicMsgLabel.text = msgs;
    }
    if (self.selfEvaluation && self.selfEvaluation.length > 0) {
        self.seleveluationLabel.text = self.selfEvaluation;
    }
    if (self.expectSalary && self.expectSalary.length > 0) {
        self.expectSalaryLabel.text = self.expectSalary;
    }
    
    
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(self.chartView.frame.size.width / 2, 30, 80, 80) total:@100 current:@60 clockwise:YES];
    circleChart.backgroundColor = [UIColor clearColor];
    [circleChart setStrokeColor:YHBlue];
    [circleChart strokeChart];
    [self.chartView addSubview:circleChart];
}
- (IBAction)toProfileResumeCategoryTVC:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResume" bundle:nil];
    YHProfileResumeCategoryTableViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeCategoryTableViewController"];
    vc.profileResume = self.profileResume;
    vc.msg = self.basicMsgLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
