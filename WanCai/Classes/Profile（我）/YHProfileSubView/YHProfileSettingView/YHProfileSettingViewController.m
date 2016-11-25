//
//  YHProfileSettingViewController.m
//  WanCai
//
//  Created by abing on 16/7/21.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileSettingViewController.h"
#import "MBProgressHUD.h"
#import "YHSettingTableViewCell.h"
#import "YHLoginViewController.h"
#import "YHPwdModifyViewController.h"
#import "YHVersionViewController.h"
#import "UIImageView+WebCache.h"
#import "YHDialogueViewController.h"
#import "YHDialogueFrame.h"
#import "YHDialogue.h"


@interface YHProfileSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YHProfileSettingViewController

- (UITableView *) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:YHGray];
    
    [self setNav];
    
    [self setSubViews];
}

- (void) setSubViews{
    
    [self.view addSubview:self.tableView];
}

- (void) setNav{
    
    self.navigationItem.title = @"设置";
    self.navigationItem.rightBarButtonItem = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 15;
    }
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 2;
    }else if(section == 2){
        return 1;
    }else{
        return 1;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 3){
        YHSettingTableViewCell *cell = [YHSettingTableViewCell cellFromTableView:tableView withIdentifier:@"setting_logout_list"];
        cell.name = @"退出登录";
        return cell;
    }else if(indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting_list"];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setting_list"];
        }
        cell.textLabel.text = @"修改密码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting_list"];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setting_list"];
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"问题反馈";
        }else{
            cell.textLabel.text = @"关于万才网与帮助";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting_list"];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"setting_list"];
        }
        cell.textLabel.text = @"清理缓存";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%luMB",(unsigned long)[[SDWebImageManager sharedManager].imageCache getSize]/1024/1024];
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 3){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *userId = [defaults objectForKey:@"userId"];
        if(userId == nil){
            [self showErrorWithHUD:@"您还没有登录"];
        }else{
            defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"userId"];
            [defaults synchronize];
            [self showSuccessWithHUD:@"注销成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    }else if(indexPath.section == 2){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *userId = [defaults objectForKey:@"userId"];
        if(userId == nil){
            YHLoginViewController *loginView = [[YHLoginViewController alloc] init];
            [self presentViewController:loginView animated:YES completion:^{
                
            }];
        }else{
            YHPwdModifyViewController *pwdModify = [[YHPwdModifyViewController alloc] init];
            [self presentViewController:pwdModify animated:YES completion:^{
                
            }];
        }
    }else if (indexPath.section == 1){
        if(indexPath.row == 0){
            YHVersionViewController *version = [[YHVersionViewController alloc] init];
            [self.navigationController pushViewController:version animated:YES];
        } else if(indexPath.row == 1) {
            YHDialogue *dia = [[YHDialogue alloc] init];
            dia.date = @"2016/7/28 15:34:45";
            dia.iconName = @"icon_version";
            dia.comName = @"万才小秘书";
            dia.detailMsg = @"尊敬的客户您好，欢迎您使用我们公司的app。万才网是江苏省无锡市人民政府与万才信息共建的一个项目。从今天起我们就要日夜为您服务咯，有什么需要的尽管给我们说，我们会尽量解答您的疑问，也祝您在万才网找到您心仪的工作。";
            YHDialogueFrame *frame = [[YHDialogueFrame alloc] init];
            dia.ShowTime = YES;
            frame.dia = dia;
            NSMutableArray *array = [NSMutableArray arrayWithArray:@[frame]];
            YHDialogueViewController *dialogue = [[YHDialogueViewController alloc] initWithArray:array];
            dialogue.title = @"万才小秘书";
            [self.navigationController pushViewController:dialogue animated:YES];
        }
    }else if (indexPath.section == 0){
        [self showAlertView];
    }
}

- (void) showErrorWithHUD:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    [hud hideAnimated:YES afterDelay:1];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aio_face_store_button_canceldown.png"]];
    hud.label.text = msg;
}

- (void) showSuccessWithHUD:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    [hud hideAnimated:YES afterDelay:1];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
    hud.label.text = msg;
}

- (void)showAlertView {
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"确定清空缓存吗？" message:@"删除缓存不可恢复" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 停止所有下载
        [[SDWebImageManager sharedManager] cancelAll];
        // 清空内存缓存
        [[SDWebImageManager sharedManager].imageCache clearMemory];
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        [self showSuccessWithHUD:@"清除成功"];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertControl addAction:commitAction];
    [alertControl addAction:cancleAction];
    
    [self presentViewController:alertControl animated:YES completion:nil];
}
@end
