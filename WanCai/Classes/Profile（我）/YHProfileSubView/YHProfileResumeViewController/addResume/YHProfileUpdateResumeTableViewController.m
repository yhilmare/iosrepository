//
//  YHProfileUpdateResumeTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileUpdateResumeTableViewController.h"
#import "YHResumeTool.h"
#import "MBProgressHUD.h"
#import "YHReturnMsg.h"

@interface YHProfileUpdateResumeTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resumeID;
@property (weak, nonatomic) IBOutlet UILabel *resumeIntegrity;
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
@property (weak, nonatomic) IBOutlet UITextField *resumeName;
@property (weak, nonatomic) IBOutlet UISwitch *privacy;

@property (nonatomic, strong) UIButton      *rightButton;

@end

@implementation YHProfileUpdateResumeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
    self.resumeID.text = self.profileResume.resumeId;
    self.resumeIntegrity.text = self.profileResume.resumeIntergrity;
    self.updateTime.text = self.profileResume.updateTime;
    self.resumeName.text = self.profileResume.resumeName;
    
    if ([self.profileResume.privacy isEqualToString:@"1"]) {
        self.privacy.on = YES;
    } else  {
        self.privacy.on = NO;
    }
}


- (UIBarButtonItem *) rightButtonItem {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
        [_rightButton setTitle: @"修改" forState: UIControlStateNormal];
        [_rightButton setTitleColor: YHWhite forState: UIControlStateNormal];
        [_rightButton addTarget: self action: @selector(saveEduExp) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithCustomView: _rightButton];
    return res;
}

- (void)saveEduExp {
    if (self.resumeName.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"未填写简历名称" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [YHResumeTool updateResumeBasicInfo:^(YHReturnMsg *result) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeCustomView;
            hud.label.textColor = [UIColor blackColor];
            hud.bezelView.layer.cornerRadius = 10;
            hud.bezelView.layer.masksToBounds = YES;
            if ([result.result isEqualToString:@"true"]) {
                hud.label.text = @"修改成功";
                hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
            } else {
                hud.label.text = @"网络错误";
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
                               withResumeId:self.profileResume.resumeId
                                 resumeName:self.resumeName.text
                                   userName:self.profileResume.userName
                                     gender:self.profileResume.gender
                                   marriage:self.profileResume.marriage
                                   birthday:self.profileResume.birthday
                                     degree:self.profileResume.degree
                                   location:self.profileResume.location
                                   workyear:self.profileResume.workyear
                                     mobile:self.profileResume.mobile
                                      email:self.profileResume.email
                            politicalStatus:self.profileResume.policicalstatus
                              selfEvalation:self.profileResume.selfEvaluation];
    }
}

@end
