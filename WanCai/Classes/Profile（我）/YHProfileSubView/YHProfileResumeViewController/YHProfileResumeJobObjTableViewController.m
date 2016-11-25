//
//  YHProfileResumeJobObjTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeJobObjTableViewController.h"
#import "YHJobObjectiveInfo.h"
#import "YHJobObjectiveTool.h"
#import "MBProgressHUD.h"
#import "YHReturnMsg.h"
#import "YHResultItem.h"
#import "YHPickerViewHelper.h"

@interface YHProfileResumeJobObjTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *expectIndustry;
@property (weak, nonatomic) IBOutlet UITextField *expectJob;
@property (weak, nonatomic) IBOutlet UITextField *expectLocation;
@property (weak, nonatomic) IBOutlet UITextField *jobNature;
@property (weak, nonatomic) IBOutlet UITextField *expectSalary;

@property (nonatomic, strong) UIButton      *rightButton;
@property (nonatomic, strong) YHPickerViewHelper *pickHelper;
@end

@implementation YHProfileResumeJobObjTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem:self.rightButtonItem];
    self.pickHelper = [[YHPickerViewHelper alloc]init];
    [self netdata];
}

- (void)netdata {
    [YHJobObjectiveTool getJobObjectiveInfo:^(YHResultItem *result) {
        YHJobObjectiveInfo *info = (YHJobObjectiveInfo *)result.rows[0];
        self.expectIndustry.text = info.ExpectIndustryType;
        self.expectJob.text = info.ExpectJob;
        self.expectLocation.text = info.ExpectLocation;
        self.jobNature.text = info.JobNature;
        self.expectSalary.text = info.ExpectSalary;
        
        self.expectIndustry.inputView = [self.pickHelper sharedInstance:YHProfileInfomationExpectJob
                                                              initValue:info.ExpectJob];
        
        
        self.jobNature.inputView = [self.pickHelper sharedInstance:YHProfileInfomationJobNature
                                                         initValue:info.JobNature];
        
        self.expectSalary.inputView = [self.pickHelper sharedInstance:YHProfileInfomationExpectSalary
                                                            initValue:info.ExpectSalary];
        
        [self.pickHelper returnText:^(UIPickerView *picker, NSString *showText, YHProfileInfomationType type) {
            switch (type) {
                case YHProfileInfomationJobNature:
                    self.jobNature.text = showText;
                    break;
                case YHProfileInfomationExpectJob:
                    self.expectIndustry.text = showText;
                    break;
                case YHProfileInfomationExpectSalary:
                    self.expectSalary.text = showText;
                    break;
                default:
                    break;
            }
        }];
        
    } withResumeId:self.profileResume.resumeId];
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
    if (self.expectIndustry.text.length == 0 ||
        self.expectJob.text.length == 0 ||
        self.expectLocation.text.length == 0 ||
        self.jobNature.text.length == 0 ||
        self.expectSalary.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"信息未填写完整" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [YHJobObjectiveTool updateJobObjective:^(YHReturnMsg *result) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeCustomView;
            hud.label.textColor = [UIColor blackColor];
            hud.bezelView.layer.cornerRadius = 10;
            hud.bezelView.layer.masksToBounds = YES;
            if ([result.result isEqualToString:@"true"]) {
                hud.label.text = @"添加成功";
                hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
                
                
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                hud.label.text = @"网络错误";
            }
        }
                                  withResumeId:self.profileResume.resumeId
                            expectIndustryType:self.expectIndustry.text
                                     expectjob:self.expectJob.text
                                expectlocation:self.expectLocation.text
                                     jobnature:self.jobNature.text
                                  expectSalary:self.expectSalary.text];
    }
    
}

@end
