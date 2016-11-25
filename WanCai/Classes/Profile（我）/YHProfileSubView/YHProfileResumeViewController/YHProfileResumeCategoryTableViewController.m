//
//  YHProfileResumeCategoryTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/7/29.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeCategoryTableViewController.h"
#import "YHProfileResumeEditTableViewController.h"
#import "YHProfileResumeEditDegreeTableViewController.h"
#import "YHProfileResumeEditWorkExpTableViewController.h"
#import "YHProfileResumeTrainTableViewController.h"
#import "YHProfileResumeJobObjTableViewController.h"
#import "YHProfileResumeLanAbiTableViewController.h"

@interface YHProfileResumeCategoryTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userMsg;
@property (weak, nonatomic) IBOutlet UILabel *userContact;

@end

@implementation YHProfileResumeCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName.text = self.profileResume.userName;
    self.userMsg.text = self.msg;
    self.userContact.text = [NSString stringWithFormat:@"%@ | %@", self.profileResume.mobile, self.profileResume.email];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0:
            [self updateResumeBasicInfo:nil];
            break;
        case 1:
            [self updateJobObjective:nil];
            break;
        case 2:
            [self updateTrainExperience:nil];
            break;
        case 3:
            [self updateEduInfoByEduId:nil];
            break;
        case 4:
            [self updateWorkExperience:nil];
            break;
        case 5:
            [self updateLanguage:nil];
            
        default:
            break;
    }
}

- (IBAction)updateResumeBasicInfo:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"YHProfileResumeJobObj" bundle:nil];
    YHProfileResumeJobObjTableViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeJobObjTableViewController"];
    vc.profileResume = self.profileResume;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)updateJobObjective:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"YHProfileResumeJobObj" bundle:nil];
    YHProfileResumeTrainTableViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeJobObjTableViewController"];
    vc.profileResume = self.profileResume;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)updateTrainExperience:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"YHProfileResumeTrainExp" bundle:nil];
    YHProfileResumeTrainTableViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeTrainTableViewController"];
    vc.profileResume = self.profileResume;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)updateEduInfoByEduId:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResumeEdit" bundle:nil];
    YHProfileResumeEditDegreeTableViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeEditDegreeTableViewController"];
    vc.profileResume = self.profileResume;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)updateWorkExperience:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResumeWorkExp" bundle:nil];
    YHProfileResumeEditWorkExpTableViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeEditWorkExpTableViewController"];
    vc.profileResume = self.profileResume;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)updateLanguage:(id)sender {
    NSLog(@"修改语言能力");
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"YHProfileResumeLanAbi" bundle:nil];
    YHProfileResumeLanAbiTableViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeLanAbiTableViewController"];
    vc.profileResume = self.profileResume;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
