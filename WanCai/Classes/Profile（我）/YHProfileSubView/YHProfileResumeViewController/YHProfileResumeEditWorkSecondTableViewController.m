//
//  YHProfileResumeEditWorkSecondTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeEditWorkSecondTableViewController.h"
#import "YHReturnMsg.h"
#import "MBProgressHUD.h"


@interface YHProfileResumeEditWorkSecondTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *companyNature;
@property (weak, nonatomic) IBOutlet UITextField *companySize;
@property (weak, nonatomic) IBOutlet UITextField *companyIndustry;
@property (weak, nonatomic) IBOutlet UITextField *subFunction;
@property (weak, nonatomic) IBOutlet UITextField *responsiblity;

@property (nonatomic, strong) UIButton      *rightButton;

@end

@implementation YHProfileResumeEditWorkSecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startDate.text = self.item.StartDate;
    self.endDate.text = self.item.EndDate;
    self.companyName.text = self.item.CompanyName;
    self.companyNature.text = self.item.CompanyNature;
    self.companySize.text = self.item.CompanySize;
    self.companyIndustry.text = self.item.CompanyIndustry;
    self.subFunction.text = self.item.SubFunction;
    self.responsiblity.text = self.item.Responsiblity;
    
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
    if (self.startDate.text.length == 0 ||
        self.endDate.text.length == 0 ||
        self.companyName.text.length == 0 ||
        self.companyIndustry.text.length == 0 ||
        self.companySize.text.length == 0 ||
        self.companyNature.text.length == 0 ||
        self.subFunction.text.length == 0 ||
        self.responsiblity.text.length == 0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"信息未填写完整" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else  {
        [YHWorkExperienceTool updateWorkExperience:^(YHReturnMsg *result) {
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
                                        withWorkId:self.item.WorkId
                                         startdate:self.startDate.text
                                           enddate:self.endDate.text
                                       companyName:self.companyName.text
                                     companyNature:self.companyNature.text
                                       companySize:self.companySize.text
                                   companyIndustry:self.companyIndustry.text
                                       subFunction:self.subFunction.text
                                     responsiblity:self.responsiblity.text];
    }
}



@end
