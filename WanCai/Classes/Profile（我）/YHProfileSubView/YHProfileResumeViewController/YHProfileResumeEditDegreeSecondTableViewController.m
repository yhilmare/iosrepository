//
//  YHProfileResumeEditDegreeSecondTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeEditDegreeSecondTableViewController.h"


@interface YHProfileResumeEditDegreeSecondTableViewController ()

@property (nonatomic, strong) UIButton      *rightButton;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextField *schoolName;
@property (weak, nonatomic) IBOutlet UITextField *proName;
@property (weak, nonatomic) IBOutlet UITextField *degree;

@end

@implementation YHProfileResumeEditDegreeSecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
    
    self.startTime.text = self.item.StartDate;
    self.endTime.text = self.item.EndDate;
    self.schoolName.text = self.item.SchoolName;
    self.proName.text = self.item.Major;
    self.degree.text = self.item.ChineseName;
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
    if (self.startTime.text.length == 0 ||
       self.endTime.text.length == 0 ||
       self.schoolName.text.length == 0 ||
       self.proName.text.length == 0 ||
       self.degree.text.length == 0 ) {
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"信息未填写完整" message:@"" preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
       [alertController addAction:cancelAction];
       [self presentViewController:alertController animated:YES completion:nil];
    } else {
       [YHEducationTool updateEduInfoByEduId:^(YHReturnMsg *result) {
           NSLog(@"%@", result.result);
           if ([result.result isEqualToString:@"true"]) {
               [self.navigationController popViewControllerAnimated:YES];
           } else {
               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
               [alertController addAction:cancelAction];
               [self presentViewController:alertController animated:YES completion:nil];
           }
       }
                                   withEduId:self.item.EduId
                                   startdate:self.startTime.text
                                  schoolName:self.schoolName.text
                                       major:self.proName.text
                                      degree:self.degree.text];
    }
    
}

@end
