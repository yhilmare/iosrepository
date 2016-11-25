//
//  YHProfileResumeEditTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/7/31.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeEditTableViewController.h"

@interface YHProfileResumeEditTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *marriage;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *degree;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *workyear;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *policticalstatus;
@property (weak, nonatomic) IBOutlet UITextField *seleveluation;

@end

@implementation YHProfileResumeEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName.text = self.profileResume.userName;
    self.gender.text = self.profileResume.gender;
    self.marriage.text = self.profileResume.marriage;
    self.birthday.text = self.profileResume.birthday;
    self.degree.text = self.profileResume.degree;
    self.location.text = self.profileResume.location;
    self.workyear.text = self.profileResume.workyear;
    self.mobile.text = self.profileResume.mobile;
    self.email.text = self.profileResume.email;
    self.policticalstatus.text = self.profileResume.policicalstatus;
    self.seleveluation.text = self.profileResume.seleveluation;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
