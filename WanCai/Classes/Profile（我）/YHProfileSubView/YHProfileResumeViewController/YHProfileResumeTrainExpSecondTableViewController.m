//
//  YHProfileResumeTrainExpSecondTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeTrainExpSecondTableViewController.h"
#import "YHProfileResumeTrainExpAddTableViewController.h"
#import "YHTrainExperiencTool.h"
#import "YHResultItem.h"
#import "YHTrainExperience.h"
#import "YHReturnMsg.h"
#import "MBProgressHUD.h"

@interface YHProfileResumeTrainExpSecondTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (weak, nonatomic) IBOutlet UITextField *trainedOrg;
@property (weak, nonatomic) IBOutlet UITextField *trainedName;
@property (weak, nonatomic) IBOutlet UITextField *descriptionS;

@property (nonatomic, strong) UIButton      *rightButton;
@end

@implementation YHProfileResumeTrainExpSecondTableViewController

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
    if (self.startDate.text.length == 0 ||
        self.endDate.text.length == 0 ||
        self.trainedOrg.text.length == 0 ||
        self.trainedName.text.length == 0 ||
        self.descriptionS.text.length == 0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"信息未填写完整" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else  {
        [YHTrainExperiencTool updateTrainExperience:^(YHReturnMsg *result) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeCustomView;
            hud.label.textColor = [UIColor blackColor];
            hud.bezelView.layer.cornerRadius = 10;
            hud.bezelView.layer.masksToBounds = YES;
            if ([result.result isEqualToString:@"true"]) {
                hud.label.text = @"修改成功";
                hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
                
                
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                hud.label.text = @"网络错误";
            }
        }
                                        withTrainId:self.item.TrainId
                                          startdate:self.startDate.text
                                            enddate:self.endDate.text
                                           trainOrg:self.trainedOrg.text
                                          className:self.trainedName.text
                                        description:self.descriptionS.text];
    }
}

@end
