//
//  YHProfileResumeEditDegreeAddTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/8.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeEditDegreeAddTableViewController.h"
#import "YHReturnMsg.h"
#import "MBProgressHUD.h"

@interface YHProfileResumeEditDegreeAddTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *end;
@property (weak, nonatomic) IBOutlet UITextField *school;
@property (weak, nonatomic) IBOutlet UITextField *pro;
@property (weak, nonatomic) IBOutlet UITextField *degree;

@property (nonatomic, strong) UIButton      *rightButton;

@property (nonatomic, strong) YHEducation *data;
@end

@implementation YHProfileResumeEditDegreeAddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (UIBarButtonItem *) rightButtonItem {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
        [_rightButton setTitle: @"保存" forState: UIControlStateNormal];
        [_rightButton setTitleColor: YHWhite forState: UIControlStateNormal];
        [_rightButton addTarget: self action: @selector(saveEduExp) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithCustomView: _rightButton];
    return res;
}

- (void)saveEduExp {
    if (self.time.text.length == 0 ||
        self.school.text.length == 0 ||
        self.pro.text.length == 0 ||
        self.degree.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"信息未填写完整" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [YHEducationTool addEducation:^(YHReturnMsg *result) {
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
            [hud hideAnimated:YES afterDelay:0.4];
        }
                         withResumeId:self.profileResume.resumeId
                            startDate:self.time.text
                              endDate:self.end.text
                           schoolName:self.school.text
                                major:self.pro.text
                               degree:self.degree.text];
    }
    
}

@end
