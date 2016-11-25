//
//  YHLoginViewController.m
//  WanCai
//
//  Created by abing on 16/7/1.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHLoginViewController.h"
#import "YHRegisteViewController.h"
#import "YHloginFormMessage.h"
#import "YHLogintool.h"
#import "MBProgressHUD.h"
#import "YHRegisteTableViewCell.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"

@interface YHLoginViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITextField *userNameField;
@property(nonatomic, strong) UITextField *passwordField;
@property(nonatomic, strong) UIButton *submitButton;
@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UIButton *helpButton;
@property(nonatomic, strong) UIActivityIndicatorView *flower;
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIButton *returnButton;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation YHLoginViewController

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

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = 54;
        _tableView.separatorColor = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
        _tableView.layer.borderColor = [[UIColor colorWithRed:231 / 255.0 green:231 / 255.1 blue:231 / 255.0 alpha:1] CGColor];
        _tableView.layer.borderWidth = 0.6;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15);
        CGFloat height = 54 * 2 - 1;
        CGFloat hp = height / [UIScreen mainScreen].bounds.size.height;
        _tableView.frame = [self calculateFramUtils:1 itemHeight:hp itemY:0.301 itemX:0.5];
    }
    return _tableView;
}

- (UIButton *)returnButton{
    if(!_returnButton){
        _returnButton = [[UIButton alloc] init];
        [_returnButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_close.png"] forState:UIControlStateNormal];
    }
    return _returnButton;
}

- (UILabel *)textLabel{
    if(!_textLabel){
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont systemFontOfSize:19];
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



- (UITextField *) userNameField{
    
    if(_userNameField == nil){
        _userNameField = [[UITextField alloc] init];
    }
    return _userNameField;
}

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"place_holder"];
        _iconView.frame = [self calculateFramUtils:0.241 itemHeight:0.136 itemY:0.08 + 0.05 itemX:0.5];
        _iconView.layer.cornerRadius = _iconView.frame.size.height / 2.0;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.borderWidth = 3;
        _iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _iconView;
}

-(UITextField *)passwordField{
    if(!_passwordField){
        _passwordField = [[UITextField alloc] init];
    }
    return _passwordField;
}

-(UIButton *) submitButton{
    if(!_submitButton){
        _submitButton = [[UIButton alloc] init];
        _submitButton.backgroundColor = [UIColor colorWithRed:65/255.0 green:178/255.0 blue:251/255.0 alpha:1];
        _submitButton.layer.cornerRadius = 3;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.userInteractionEnabled = NO;
    }
    return _submitButton;
}

- (UIButton *)helpButton{
    if(!_helpButton){
        _helpButton = [[UIButton alloc] init];
        [_helpButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_helpButton setTitleColor:[UIColor colorWithRed:108/255.0 green:148/255.0 blue:189/255.0 alpha:1] forState:UIControlStateNormal];
        _helpButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _helpButton;
}

- (void) viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginMessage:) name:@"loginMessage" object:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self setFrame];
    
    [self setSubView];
    
    [self setTarget];
    
}

- (void) setTarget{
    [self.helpButton addTarget:self action:@selector(helpFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton addTarget:self action:@selector(loginFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.returnButton addTarget:self action:@selector(returnFunction) forControlEvents:UIControlEventTouchUpInside];
}

- (void) setSubView{
    [self.submitButton addSubview:self.flower];
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.submitButton];
    [self.view addSubview:self.helpButton];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.returnButton];
}

- (void) setFrame{
    self.submitButton.frame = [self calculateFramUtils:0.9 itemHeight:0.065 itemY:0.5 itemX:0.5];
    self.helpButton.frame = [self calculateFramUtils:0.241 itemHeight:0.068 itemY:0.93 itemX:0.5];
    CGRect frame = [self calculateFramUtils:0.072 itemHeight:0.041 itemY:0.04 itemX:0.04];
    self.returnButton.frame = CGRectMake(frame.origin.x, frame.origin.y, 30, 30);
    CGFloat centerX = self.submitButton.frame.size.width / 2.0;
    CGFloat centerY = self.submitButton.frame.size.height / 2.0;
    [self.submitButton addSubview:self.textLabel];
    self.textLabel.frame = CGRectMake(0.65 * centerX, 0.2 * centerY, centerX * 0.7, centerY * 1.6);
    self.textLabel.text = @"登录";
    self.flower.center = CGPointMake(self.textLabel.frame.origin.x - 2, centerY);
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"login_identifier";
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
            cell.textFieldName = @"请输入密码";
            cell.textField.secureTextEntry = YES;
            _passwordField = cell.textField;
            cell.textField.delegate = self;
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) returnFunction{
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(self.userNameField.text.length != 0 && self.passwordField.text.length != 0){
        self.submitButton.userInteractionEnabled = YES;
    }else{
        self.submitButton.userInteractionEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) helpFunction{
    
    YHRegisteViewController *regis = [[YHRegisteViewController alloc] init];
    [self presentViewController:regis animated:YES completion:^{
        
    }];
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

-(void) loginFunction{
    
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络连接"];
        return;
    }
    
    self.submitButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:104/255.0 blue:143/255.0 alpha:1];
    self.textLabel.text = @"正在登录";
    [self.flower startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *username = self.userNameField.text;
    NSString *password = self.passwordField.text;
    
    NSDictionary *dic = @{@"userName":username, @"password":password};
    
    YHloginFormMessage *loginForm = [YHloginFormMessage formMessageWithDictionary:dic];
    [YHLogintool getLoginResult:loginForm];
}

- (void) loginMessage:(NSNotification *) notice{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.submitButton.backgroundColor = [UIColor colorWithRed:65/255.0 green:178/255.0 blue:251/255.0 alpha:1];
    NSString *condition = notice.userInfo[@"Condition"];
    NSNumber *userId = notice.userInfo[@"userId"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    [hud hideAnimated:YES afterDelay:1];
    
    if([condition isEqualToString:@"success"]){
        hud.label.text = @"登陆成功";
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
//                [YHUserDefaultHelper saveUserDefaultDataWithUserName:self.userNameField.text
//                                                            password:self.passwordField.text
//                                                              userId:[NSString stringWithFormat:@"%@", userId]];
            }];
        });
        YHLog(@"登陆成功,id是%@", userId);
    }else if([condition isEqualToString:@"fail"]){
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aio_face_store_button_canceldown.png"]];
        hud.label.text = @"账号或密码错误";
        YHLog(@"账号或密码错误,%@",userId);
    }else{
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aio_face_store_button_canceldown.png"]];
        hud.label.text = @"请检查网络连接";
        YHLog(@"登陆错误,%@", userId);
    }
    self.textLabel.text = @"登录";
    [self.flower stopAnimating];
}


-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
