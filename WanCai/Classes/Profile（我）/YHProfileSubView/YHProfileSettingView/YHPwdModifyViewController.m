//
//  YHRegisteViewController.m
//  WanCai
//
//  Created by abing on 16/7/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHPwdModifyViewController.h"
#import "YHRegisteTool.h"
#import "MBProgressHUD.h"
#import "YHRegisteHeadView.h"
#import "YHUserInfo.h"
#import "YHRegisteFormMessage.h"
#import "YHRegisteTableViewCell.h"
#import "Reachability.h"
#import "YHUserBasicInfoTool.h"
#import "YHReturnMsg.h"

@interface YHPwdModifyViewController () <UITextFieldDelegate, YHRegisteHeadViewdelgate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITextField *userNameField;
@property(nonatomic, strong) UITextField *passwordField;
@property(nonatomic, strong) UITextField *passwordNewField;
@property(nonatomic, strong) UITextField *passwordNewTestField;

@property(nonatomic, strong) UIButton *submitButton;
@property(nonatomic, strong) UIActivityIndicatorView *flower;
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) YHRegisteHeadView *headView;
@property(nonatomic, strong) UIButton *notice;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation YHPwdModifyViewController

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        CGFloat height = 54 * 4;
        CGFloat hp = (height - 1) / [UIScreen mainScreen].bounds.size.height;
        _tableView.frame = [self calculateFramUtils:1 itemHeight:hp itemY:0.12 itemX:0.5];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
        _tableView.layer.borderColor = [[UIColor colorWithRed:231 / 255.0 green:231 / 255.1 blue:231 / 255.0 alpha:1] CGColor];
        _tableView.layer.borderWidth = 0.6;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15);
        _tableView.rowHeight = 54;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UILabel *)textLabel{
    if(!_textLabel){
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont systemFontOfSize:19];
        _textLabel.text = @"确认更改";
        _textLabel.userInteractionEnabled = NO;
    }
    return _textLabel;
}

- (UIActivityIndicatorView *)flower{
    if(!_flower){
        _flower = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite
                   ];
        [_flower hidesWhenStopped];
    }
    return _flower;
}

- (UIButton *)submitButton{
    if(!_submitButton){
        _submitButton = [[UIButton alloc] init];
        _submitButton.backgroundColor = [UIColor colorWithRed:65/255.0 green:178/255.0 blue:251/255.0 alpha:1];
        _submitButton.layer.cornerRadius = 3;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.userInteractionEnabled = NO;
        [_submitButton addTarget:self action:@selector(submitFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (YHRegisteHeadView *)headView{
    if(!_headView){
        _headView = [[YHRegisteHeadView alloc] init];
        [_headView setBackgroundColor:[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]];
        _headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        _headView.textLabel.text = @"更改密码";
        _headView.delgate = self;
    }
    return _headView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(self.userNameField.text.length != 0 && self.passwordField.text.length != 0 && self.passwordNewField.text.length != 0 && self.passwordNewTestField.text.length != 0){
        self.submitButton.userInteractionEnabled = YES;
    }else{
        self.submitButton.userInteractionEnabled = NO;
    }
}

- (void) viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void) viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    CGRect frame = [self calculateFramUtils:0.9 itemHeight:0.065 itemY:0.55 itemX:0.5];
    CGFloat y = CGRectGetMaxY(self.tableView.frame);
    self.submitButton.frame = CGRectMake(frame.origin.x, y + 20, frame.size.width, frame.size.height);

    CGFloat centerX = self.submitButton.frame.size.width / 2.0;
    CGFloat centerY = self.submitButton.frame.size.height / 2.0;
    self.textLabel.frame = CGRectMake(0.65 * centerX, 0.2 * centerY, centerX * 0.7, centerY * 1.6);
    self.flower.center = CGPointMake(self.textLabel.frame.origin.x - 2, centerY);
    
    [self setSubViews];
    
}

- (void) setSubViews{
    
    [self.submitButton addSubview:self.textLabel];
    [self.submitButton addSubview:self.flower];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitButton];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.notice];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"modify_identifier";
    YHRegisteTableViewCell *cell = [YHRegisteTableViewCell cellFromTableView:tableView withIdentifier:identifier];
    switch (indexPath.row) {
        case 0:
            cell.iconName = @"username.png";
            cell.textFieldName = @"请输入用户名";
            _userNameField = cell.textField;
            cell.textField.delegate = self;
            break;
        case 1:
            cell.iconName = @"password.png";
            cell.textFieldName = @"请输原密码";
            cell.textField.secureTextEntry = YES;
            _passwordField = cell.textField;
            cell.textField.delegate = self;
            break;
        case 2:
            cell.iconName = @"password.png";
            cell.textFieldName = @"请输入新密码";
            cell.textField.secureTextEntry = YES;
            _passwordNewField = cell.textField;
            cell.textField.delegate = self;
            break;
        case 3:
            cell.iconName = @"querenpassword.png";
            cell.textFieldName = @"请再次输入新密码";
            cell.textField.secureTextEntry = YES;
            _passwordNewTestField = cell.textField;
            cell.textField.delegate = self;
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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

- (void)submitFunction{
    
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    
    self.submitButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:104/255.0 blue:143/255.0 alpha:1];
    [self.flower startAnimating];
    self.textLabel.text = @"正在更改";
    
    [self.userNameField resignFirstResponder];
    [self.passwordNewField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.passwordNewTestField resignFirstResponder];
    
    NSString *username = self.userNameField.text;
    NSString *password = self.passwordField.text;
    NSString *passwordNew = self.passwordNewField.text;
    NSString *passwordNewTest = self.passwordNewTestField.text;
    
    if(![passwordNewTest isEqualToString:passwordNew]){
        [self showErrorWithHUD:@"两次密码输入不一致"];
        [self.flower stopAnimating];
        self.textLabel.text = @"确认更改";
        self.submitButton.backgroundColor = [UIColor colorWithRed:65/255.0 green:178/255.0 blue:251/255.0 alpha:1];
    }else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [YHUserBasicInfoTool updatePassword:^(YHReturnMsg *result) {
            if([result.msg isEqualToString:@"修改成功"]){
                [self showSuccessInfoWithHUD:@"密码修改成功"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                });
            }else{
                [self showErrorWithHUD:[NSString stringWithFormat:@"%@",result.msg]];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            self.submitButton.backgroundColor = [UIColor colorWithRed:65/255.0 green:178/255.0 blue:251/255.0 alpha:1];
            self.textLabel.text = @"确认更改";
            [self.flower stopAnimating];
        } withUserName:username oldPwd:password newPwd:passwordNew];
    }
}

- (void) showSuccessInfoWithHUD:(NSString *)msg{
    
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



- (void) cancelFunction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (CGRect) calculateFramUtils: (CGFloat) itemWidthPercent
                   itemHeight: (CGFloat) itemHeightPercent
                        itemY: (CGFloat) itemY
                        itemX: (CGFloat) itemX{
    
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = screenFrame.size.width;
    CGFloat screenHeight = screenFrame.size.height;
    CGFloat itemWidth = itemWidthPercent * screenWidth;
    CGFloat itemHeight = itemHeightPercent * screenHeight;
    
    CGFloat x = (screenWidth - itemWidth) * itemX;
    CGFloat y = itemY * screenHeight;
    CGRect rect = CGRectMake(x, y, itemWidth, itemHeight);
    return rect;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.userNameField resignFirstResponder];
    [self.passwordNewTestField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.passwordNewField resignFirstResponder];
}

@end
