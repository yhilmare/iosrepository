//
//  YHProfileInfomationViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/6/1.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileInfomationViewController.h"
#import "Masonry.h"
#import "YHProfileInfomationTableViewCell.h"
#import "YHUserInfo.h"
#import "YHProvinceTool.h"
#import "YHCityTool.h"
#import "YHCity.h"
#import "YHProvince.h"
#import "YHResultItem.h"
#import "MBProgressHUD.h"
#import "YHUserBasicInfoTool.h"
#import "YHReturnMsg.h"
#import "Reachability.h"
#import "YHUserBasicInfo.h"
#import "YHUserDefaultHelper.h"
#import "YHUserIconTool.h"
#import "UINavigationBar+YHAwesome.h"


#import "QiniuSDK.h"
#import "QiniuPutPolicy.h"
#import "UIImage-Extensions.h"
#import "UIImageView+WebCache.h"


static NSString *QiniuAccessKey = @"lsO2flqtT5rY8zXE4W9z4djNf5fdQ4tuvhM7yOb3";
static NSString *QiniuSecretKey = @"QccyuV0Fg-G2npA1WbBx4W7ctK-898RN-juHROaa";
static NSString *QiniuBucketName = @"knives";
static NSString *QiniuBaseURL = @"obkurs5wg.bkt.clouddn.com";

const CGFloat HEADER_HEIGHT = 250;

typedef NS_ENUM(NSUInteger, YHProfileInfomationType)  {
    YHProfileInfomationName = 0,
    YHProfileInfomationSex,
    YHProfileInfomationMaritalStatus,
    YHProfileInfomationBirthday,
    YHProfileInfomationEducate,
    YHProfileInfomationLocation,
    YHProfileInfomationWorkTime,
    YHProfileInfomationPhone,
    YHProfileInfomationEmail
};

#define kDocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]

@interface YHProfileInfomationViewController() <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIView        *backgroundView;
@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) UIButton      *nameLabel;
@property (nonatomic, strong) UIButton      *rightButton;
@property (nonatomic, strong) UIImageView   *avator;
@property (nonatomic, copy)   NSMutableDictionary *dic;
@property (nonatomic, copy)   NSMutableArray *array;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *sexPickerView;
@property (nonatomic, strong) UIPickerView *marriagePickerView;
@property (nonatomic, strong) UIPickerView *eduPickerView;
@property (nonatomic, strong) UIPickerView *workYearPickerView;
@property (nonatomic, strong) UIPickerView *locationPickerView;
@property (nonatomic, assign) NSInteger    index;
@property (nonatomic, copy) NSDictionary *tempDic;
@property (nonatomic, copy) YHUserInfo *info;
@property (nonatomic, strong) UIActivityIndicatorView *flower;
@property (nonatomic, strong) UIToolbar *bar;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation YHProfileInfomationViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:YHGray];
    
    self.navigationItem.title = @"我的信息";
    [self loadUserBasicInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppearanceFunction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 插入tableview
    [self.view addSubview: self.tableView];
    // 增加头像设置View
    [self.view addSubview: self.headView];
    [self.view addSubview: self.avator];
    [self.view addSubview: self.nameLabel];
    [self.view addSubview:self.flower];
    [self.view addSubview:self.bar];
    // nav按钮
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
    
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_back" highImage:@"navigationbar_back" target:self action:@selector(backToRootController)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 布局调整
    [self layout];
}

- (void) backToRootController{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要保存本页信息" delegate:self cancelButtonTitle:@"保存" otherButtonTitles:@"退出", nil];
    if([self isModified]){
        [alertView show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (BOOL) isModified{
    
    NSMutableArray *keysArray = [NSMutableArray array];
    NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionary];
    for(YHProfileInfomationTableViewCell *cell in self.array){
        [cell.detailInfo resignFirstResponder];
        NSInteger index = [self.tableView indexPathForCell:cell].row;
        NSString *key = [self enumMappingToFieldName:index];
        [dics setValue:cell.detailInfo.text forKey:key];
        [keysArray addObject:key];
    }
    [dics setValue:userId forKey:@"userId"];
    [keysArray addObject:@"userId"];
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@.plist", dir, [userId stringValue]];
    YHUserInfo *info = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSMutableDictionary *dics1 = [NSMutableDictionary dictionary];
    for (NSString *key in keysArray) {
        NSString *value = [info valueForKey:key];
        [dics1 setValue:value forKey:key];
    }
    if([dics1 isEqualToDictionary:dics]){
        return NO;
    }
    return YES;
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self clickSettingButton];
    }
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loadUserBasicInfo{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"userId"];
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [NSString stringWithFormat:@"%@/%@.plist", dir, userId];
        _info = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        self.tableView.hidden = YES;
        [self.flower startAnimating];
        [YHUserBasicInfoTool getUserBasicInfo:^(YHResultItem *result) {
            YHUserBasicInfo *basicInfo = [result.rows firstObject];
            if(basicInfo == nil){
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *path = [NSString stringWithFormat:@"%@/%@.plist", dir, userId];
                _info = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            }else{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                self.info.userId = basicInfo.userId;
                self.info.userName = basicInfo.UserName;
                self.info.gender = [basicInfo.Gender isEqualToString:@"1"]?@"男":@"女";
                self.info.marriage = [basicInfo.Marrige isEqualToString:@"1"]?@"已婚":@"未婚";
                self.info.birthday = [self getFormatDate:basicInfo.Birthday];
                self.info.degree = [self antiMappingForEdu:basicInfo.Degree];
                self.info.location = [self antiMappingFunction:basicInfo.Location];
                self.info.workYear = [self antiMappingForWorkYear:basicInfo.YearOfWork];
                self.info.mobile = basicInfo.Mobile;
                self.info.email = basicInfo.Email;
                
                [YHUserDefaultHelper saveUserDefaultDataWithUserName:self.info.userName
                                                            password:nil
                                                              userId:self.info.userId
                                                                name:nil
                                                                 sex:self.info.gender
                                                       maritalStatus:self.info.marriage
                                                            birthday:self.info.birthday
                                                             educate:self.info.degree
                                                            location:self.info.location
                                                            workTime:self.info.workYear
                                                               phone:self.info.mobile
                                                               email:self.info.email];
                
            }
            [self.tableView reloadData];
            self.tableView.hidden = NO;
            [self.flower stopAnimating];
        } withuserId:userId];
    }
}

- (UIToolbar *) bar{
    if(!_bar){
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        CGFloat itemHeight = 40;
        _bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, height, width, itemHeight)];
        [_bar setBarTintColor:YHGray];
        
        CGFloat x = width - 30 - 20;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, (itemHeight - 30) / 2.0, 30, 30)];
        [button setBackgroundImage:[UIImage imageNamed:@"Checkmark"] forState:UIControlStateNormal];
        [_bar addSubview:button];
        [button addTarget:self action:@selector(clickFunction) forControlEvents:UIControlEventTouchUpInside];
        
        x = 8;
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(x, (itemHeight - 30) / 2.0, 50, 30)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:@"上一个" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bar addSubview:button];
        [button addTarget:self action:@selector(previousFunction) forControlEvents:UIControlEventTouchUpInside];
        
        x = CGRectGetMaxX(button.frame) + 5;
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(x, (itemHeight - 30) / 2.0, 50, 30)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:@"下一个" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bar addSubview:button];
        [button addTarget:self action:@selector(nextFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bar;
}



- (void) clickFunction{
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view endEditing:YES];
    }];
}

- (void) previousFunction{
    NSInteger index = 0;
    
    for(int i = 0; i < self.array.count; i++){
        YHProfileInfomationTableViewCell *cell = self.array[i];
        if([cell.detailInfo isFirstResponder]){
            index = cell.detailInfo.tag - 1;
        }
    }
    for(YHProfileInfomationTableViewCell *cell in self.array){
        if(cell.detailInfo.tag == index){
            [UIView animateWithDuration:0.25 animations:^{
                [cell.detailInfo becomeFirstResponder];
            }];
            return;
        }
    }
    [self.view endEditing:YES];
}

- (void) nextFunction{
    
    NSInteger index = 0;
    
    for(int i = 0; i < self.array.count; i++){
        YHProfileInfomationTableViewCell *cell = self.array[i];
        if([cell.detailInfo isFirstResponder]){
            index = cell.detailInfo.tag + 1;
        }
    }
    for(YHProfileInfomationTableViewCell *cell in self.array){
        if(cell.detailInfo.tag == index){
            [UIView animateWithDuration:0.25 animations:^{
                [cell.detailInfo becomeFirstResponder];
            }];
            return;
        }
    }
    [self.view endEditing:YES];
    
}

- (UIActivityIndicatorView *) flower{
    if(!_flower){
        _flower = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _flower.center = self.view.center;
        [_flower hidesWhenStopped];
    }
    return _flower;
}

- (UIDatePicker *)datePicker{
    if(!_datePicker){
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        [_datePicker setBackgroundColor:[UIColor whiteColor]];
        [_datePicker addTarget:self action:@selector(datePickerChange) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (void) datePickerChange{
    for(YHProfileInfomationTableViewCell *cell in self.array){
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        if(path.row == 3){
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd"];
            cell.detailInfo.text = [format stringFromDate:self.datePicker.date];
        }
    }
}

- (UIPickerView *) sexPickerView{
    if(!_sexPickerView){
        _sexPickerView = [[UIPickerView alloc] init];
        _sexPickerView.dataSource = self;
        _sexPickerView.delegate = self;
        _sexPickerView.tag = 0;
        [_sexPickerView selectRow:0 inComponent:0 animated:YES];
        [_sexPickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _sexPickerView;
}

- (UIPickerView *) marriagePickerView{
    if(!_marriagePickerView){
        _marriagePickerView = [[UIPickerView alloc] init];
        _marriagePickerView.dataSource = self;
        _marriagePickerView.delegate = self;
        _marriagePickerView.tag = 1;
        [_marriagePickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _marriagePickerView;
}

- (UIPickerView *) eduPickerView{
    if(!_eduPickerView){
        _eduPickerView = [[UIPickerView alloc] init];
        _eduPickerView.dataSource = self;
        _eduPickerView.delegate = self;
        _eduPickerView.tag = 2;
        [_eduPickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _eduPickerView;
}

- (UIPickerView *)workYearPickerView{
    if(!_workYearPickerView){
        _workYearPickerView = [[UIPickerView alloc] init];
        _workYearPickerView.dataSource = self;
        _workYearPickerView.delegate = self;
        _workYearPickerView.tag = 4;
        [_workYearPickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _workYearPickerView;
}

- (UIPickerView *)locationPickerView{
    if(!_locationPickerView){
        _locationPickerView = [[UIPickerView alloc] init];
        _locationPickerView.dataSource = self;
        _locationPickerView.delegate = self;
        _locationPickerView.tag = 3;
        [_locationPickerView selectRow:0 inComponent:0 animated:YES];
        [_locationPickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _locationPickerView;
}

- (YHUserInfo *)info{
    if(!_info){
        _info = [[YHUserInfo alloc] init];
    }
    return _info;
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if(pickerView.tag == 3){
        return 2;
    }else{
        return 1;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 0 || pickerView.tag == 1){
        return 3;
    }else if(pickerView.tag == 2){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"education.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        return array.count;
    }else if(pickerView.tag == 4){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"workYear.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        return array.count;
    }else if(pickerView.tag == 3){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil];
        NSArray *arrays = [NSArray arrayWithContentsOfFile:path];
        if(component == 0){
            return arrays.count;
        }else if(component == 1){
            NSDictionary *dic = arrays[self.index];
            NSArray *temp = dic[@"city"];
            return temp.count;
        }
    }
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 0){
        if(row == 0){
            return @"请选择";
        }else if(row == 1){
            return @"男";
        }else{
            return @"女";
        }
    }else if(pickerView.tag == 1){
        if(row == 0){
            return @"请选择";
        }else if(row == 2){
            return @"已婚";
        }else{
            return @"未婚";
        }
    }else if(pickerView.tag == 2){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"education.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        return array[row];
    }else if(pickerView.tag == 4){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"workYear.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        return array[row];
    }else if(pickerView.tag == 3){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        if(component == 0){
            NSDictionary *dic = array[row];
            return dic[@"province"];
        }else{
            NSDictionary *dic = array[self.index];
            NSArray *temp = dic[@"city"];
            return temp[row];
        }
    }else{
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag == 0){
        if(row == 1){
            for(YHProfileInfomationTableViewCell *cell in self.array){
                NSIndexPath *path = [self.tableView indexPathForCell:cell];
                if(path.row == 1){
                    cell.detailInfo.text = @"男";
                }
            }
        }else if(row == 2){
            for(YHProfileInfomationTableViewCell *cell in self.array){
                NSIndexPath *path = [self.tableView indexPathForCell:cell];
                if(path.row == 1){
                    cell.detailInfo.text = @"女";
                }
            }
        }
    }else if(pickerView.tag == 1){
        if(row == 2){
            for(YHProfileInfomationTableViewCell *cell in self.array){
                NSIndexPath *path = [self.tableView indexPathForCell:cell];
                if(path.row == 2){
                    cell.detailInfo.text = @"已婚";
                }
            }
        }else if(row == 1){
            for(YHProfileInfomationTableViewCell *cell in self.array){
                NSIndexPath *path = [self.tableView indexPathForCell:cell];
                if(path.row == 2){
                    cell.detailInfo.text = @"未婚";
                }
            }
        }
    }else if(pickerView.tag == 2){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"education.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for(YHProfileInfomationTableViewCell *cell in self.array){
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            if(path.row == 4){
                if(![array[row] isEqualToString:@"请选择"]){
                    cell.detailInfo.text = array[row];
                }
            }
        }
    }else if(pickerView.tag == 4){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"workYear.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for(YHProfileInfomationTableViewCell *cell in self.array){
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            if(path.row == 6){
                if(![array[row] isEqualToString:@"请选择"]){
                    cell.detailInfo.text = array[row];
                }
            }
        }
    }else if(pickerView.tag == 3){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSArray *temp;
        NSString *cityName;
        NSString *province;
        if(component == 0){
            [self.locationPickerView selectRow:0 inComponent:1 animated:NO];
            self.index = row;
            self.tempDic = array[row];
        }else{
            if(self.tempDic == nil){
                self.tempDic = array[0];
            }
            temp = self.tempDic[@"city"];
            cityName = temp[row];
            province = self.tempDic[@"province"];
        }
        [self.locationPickerView reloadComponent:1];
        
        for(YHProfileInfomationTableViewCell *cell in self.array){
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            if(path.row == 5){
                if(province && cityName && ![cityName isEqualToString:@"请选择"]){
                    cell.detailInfo.text = [NSString stringWithFormat:@"%@",cityName];
                }
            }
        }
    }
}

- (NSMutableDictionary *) dic{
    if(!_dic){
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (NSMutableArray *)array{
    if(!_array){
        _array = [NSMutableArray array];
    }
    return _array;
}


- (void) keyboardAppearanceFunction:(NSNotification *)notice{
    
    NSDictionary *dic = notice.userInfo;
    
    CGRect frame = [dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat offsetY = frame.origin.y - self.view.frame.size.height;
    
    for(YHProfileInfomationTableViewCell *cell in self.array){
        if([cell.detailInfo isFirstResponder]){
            if(cell.detailInfo.tag * 44 <= frame.size.height || offsetY == 0){
                [UIView animateWithDuration:[dic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue] animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, offsetY == 0?offsetY:-(cell.detailInfo.tag) * 44);
                    CGFloat rate = -(offsetY == 0?offsetY:-(cell.detailInfo.tag) * 44) / 258;
                    [self.navigationController.navigationBar yhSetBackgroundColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:rate]];
                    if(offsetY < 0){
                        CGFloat offset = frame.size.height + 40 + (offsetY == 0?offsetY:-(cell.detailInfo.tag) * 44);
                        self.bar.transform = CGAffineTransformMakeTranslation(0, -offset);
                    }else{
                        self.bar.transform = CGAffineTransformMakeTranslation(0, 0);
                    }
                }];
            }else{
                [UIView animateWithDuration:[dic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue] animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
                    CGFloat rate = -offsetY / 258;
                    [self.navigationController.navigationBar yhSetBackgroundColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:rate]];
                    if(offsetY < 0){
                        self.bar.transform = CGAffineTransformMakeTranslation(0, -40);
                    }else{
                        self.bar.transform = CGAffineTransformMakeTranslation(0, 0);
                    }
                }];
            }
            
        }
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar yhSetBackgroundColor:[UIColor clearColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setShadowImage: [[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.navigationController.navigationBar yhSetBackgroundColor:YHBlue];
    [super viewWillDisappear:animated];
}

- (void) layout {
    [self.avator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headView);
        make.top.equalTo(self.avator.mas_bottom).with.offset(20);
    }];
}

- (NSString *) enumMappingToFieldName:(NSInteger) index{
    if(index == 0){
        return @"userName";
    }else if(index == 1){
        return @"gender";
    }else if(index == 2){
        return @"marriage";
    }else if(index == 3){
        return @"birthday";
    }else if(index == 4){
        return @"degree";
    }else if (index == 5){
        return @"location";
    }else if (index == 6){
        return @"workYear";
    }else if (index == 7){
        return @"mobile";
    }else{
        return @"email";
    }
}

- (NSString *)getFormatDate:(NSString *)date{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy/MM/dd hh:mm:ss";
    NSDate *dates = [format dateFromString:date];
    format.dateFormat = @"yyyy-MM-dd";
    return [format stringFromDate:dates];
}

- (NSString *) antiMappingFunction:(NSString *)cityCode{//根据地域代码反向得到城市字符串
    
    NSString *paths = [[NSBundle mainBundle] pathForResource:@"cityMappingFile.plist" ofType:nil];
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithContentsOfFile:paths];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for(NSString *key in temp){
        [result setValue:key forKey:temp[key]];
    }
    return result[cityCode];
}

#pragma mark - 设置点击事件
- (void) clickSettingButton {
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    for(YHProfileInfomationTableViewCell *cell in self.array){
        [cell.detailInfo resignFirstResponder];
        NSInteger index = [self.tableView indexPathForCell:cell].row;
        NSString *key = [self enumMappingToFieldName:index];
        [self.dic setValue:cell.detailInfo.text forKey:key];
    }
    [self.dic setValue:userId forKey:@"userId"];
    YHUserInfo *info = [YHUserInfo yhUserInfoWithDictionary:self.dic];
    NSString *direction = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@.plist", direction, userId];
    [NSKeyedArchiver archiveRootObject:info toFile:path];
    
    for(NSString *key in self.dic){
        NSString *value;
        if([self.dic[key] isKindOfClass:[NSNumber class]]){
            NSNumber *temp = self.dic[key];
            value = [temp stringValue];
        }else{
            value = self.dic[key];
        }
        if(value.length == 0){
            [self showErrorWithHUD:@"页面内所有信息均必须填写"];
            return;
        }
    }
    
    [self mappingDictionary:self.dic];//映射dic;
    
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(status == NotReachable){
        [self showErrorWithHUD:@"请检查网络状态"];
        return;
    }
    
    MBProgressHUD *hud = [self showNetWorkWithHUD:@"正在更新"];
    [hud showAnimated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [YHUserBasicInfoTool updateUserBasicInfo:^(YHReturnMsg *result) {//发送网络请求更改个人信息
        YHLog(@"%@",result);
        if([result.msg isEqualToString:@"更新成功"]){
            [hud hideAnimated:YES];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self showSuccessWithHUD:@"更新成功"];
        }else if([result.msg isEqualToString:@"更新失败"]){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [hud hideAnimated:YES];
            [self showErrorWithHUD:@"更新失败"];
        }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [hud hideAnimated:YES];
            [self showErrorWithHUD:@"(⊙o⊙)~服务器出错啦"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }withuserId:self.dic[@"userId"] userName:self.dic[@"userName"] gender:self.dic[@"gender"] marriage:self.dic[@"marriage"] birthday:self.dic[@"birthday"] degree:self.dic[@"degree"] workyear:self.dic[@"workYear"] mobile:self.dic[@"mobile"] email:self.dic[@"email"] location:self.dic[@"location"]];
    
}




- (void) mappingDictionary:(NSMutableDictionary *)dic{
    
    [self.dic setValue:[self getCityCodeWithCity:self.dic[@"location"]] forKey:@"location"];//地点映射
    [self.dic setValue:[self getCodeWithName:self.dic[@"gender"]] forKey:@"gender"];//性别映射
    [self.dic setValue:[self getCodeWithName:self.dic[@"marriage"]] forKey:@"marriage"];//婚姻映射
    [self.dic setValue:[self getCodeWithName:self.dic[@"degree"]] forKey:@"degree"];//学历映射
    [self.dic setValue:[self getCodeWithName:self.dic[@"workYear"]] forKey:@"workYear"];//工作年限映射
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

- (MBProgressHUD *) showNetWorkWithHUD:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    hud.label.text = msg;
    return hud;
}

- (NSString *) antiMappingForWorkYear:(NSString *)name{
    
    if([name isEqualToString:@"3"]){
        return @"1年";
    }else if([name isEqualToString:@"4"]){
        return @"2年";
    }else if([name isEqualToString:@"5"]){
        return @"3-4年";
    }else if([name isEqualToString:@"6"]){
        return @"5-7年";
    }else if([name isEqualToString:@"7"]){
        return @"8-9年";
    }else if([name isEqualToString:@"8"]){
        return @"10年以上";
    }else if([name isEqualToString:@"1"]){
        return @"在读学生";
    }else{
        return @"应届毕业生";
    }
    
}

- (NSString *) antiMappingForEdu:(NSString *)name{
    
    if([name isEqualToString:@"3"]){
        return @"中技";
    }else if([name isEqualToString:@"4"]){
        return @"中专";
    }else if([name isEqualToString:@"5"]){
        return @"大专";
    }else if([name isEqualToString:@"6"]){
        return @"本科";
    }else if([name isEqualToString:@"7"]){
        return @"硕士";
    }else if([name isEqualToString:@"8"]){
        return @"博士";
    }else{
        return @"博士后";
    }
}

- (NSString *)getCodeWithName:(NSString *)name{//获得代码,得到不同键值得映射代码
    
    if([name isEqualToString:@"男"]){
        return @"1";
    }else if ([name isEqualToString:@"女"]){
        return @"2";
    }else if([name isEqualToString:@"已婚"]){
        return @"1";
    }else if([name isEqualToString:@"未婚"]){
        return @"2";
    }else if([name isEqualToString:@"中技"]){
        return @"3";
    }else if([name isEqualToString:@"中专"]){
        return @"4";
    }else if([name isEqualToString:@"大专"]){
        return @"5";
    }else if([name isEqualToString:@"本科"]){
        return @"6";
    }else if([name isEqualToString:@"硕士"]){
        return @"7";
    }else if([name isEqualToString:@"博士"]){
        return @"8";
    }else if([name isEqualToString:@"博士后"]){
        return @"9";
    }else if([name isEqualToString:@"1年"]){
        return @"3";
    }else if([name isEqualToString:@"2年"]){
        return @"4";
    }else if([name isEqualToString:@"3-4年"]){
        return @"5";
    }else if([name isEqualToString:@"5-7年"]){
        return @"6";
    }else if([name isEqualToString:@"8-9年"]){
        return @"7";
    }else if([name isEqualToString:@"10年以上"]){
        return @"8";
    }else if([name isEqualToString:@"在读学生"]){
        return @"1";
    }else{
        return @"2";
    }
}

- (NSString *)getCityCodeWithCity:(NSString *)cityName{//获得城市的代码
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityMappingFile.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *code = dic[cityName];
    return code;
}

#pragma mark - UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"profile_information_cell";
    YHProfileInfomationTableViewCell *cell = [YHProfileInfomationTableViewCell getTableViewCell:tableView reusableIdentifier:cellIdentifier arrayPointer:self.array];
    switch (indexPath.row) {
        case YHProfileInfomationName:
            cell.detailInfo.delegate = self;
            cell.detailInfo.text = self.info.userName;
            cell.iconName = @"name";
            cell.labelMsg = @"您的姓名";
            cell.detailInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.detailInfo.returnKeyType = UIReturnKeyDone;
            cell.detailInfo.tag = 0;
            break;
        case YHProfileInfomationSex:
            
            cell.detailInfo.delegate = self;
            cell.iconName = @"sex";
            cell.labelMsg = @"性别";
            cell.detailInfo.inputView = self.sexPickerView;
            cell.detailInfo.text = self.info.gender;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 1;
            break;
        case YHProfileInfomationMaritalStatus:
            
            cell.detailInfo.delegate = self;
            cell.iconName = @"marital_status";
            cell.labelMsg = @"婚姻状况";
            cell.detailInfo.inputView = self.marriagePickerView;
            cell.detailInfo.text = self.info.marriage;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 2;
            break;
        case YHProfileInfomationBirthday:
            
            cell.detailInfo.delegate = self;
            cell.iconName = @"birth";
            cell.labelMsg = @"生日";
            cell.detailInfo.inputView = self.datePicker;
            cell.detailInfo.text = self.info.birthday;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 3;
            break;
        case YHProfileInfomationEducate:
            
            cell.detailInfo.delegate = self;
            cell.detailInfo.inputView = self.eduPickerView;
            cell.iconName = @"education_status";
            cell.labelMsg = @"受教育程度";
            cell.detailInfo.text = self.info.degree;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 4;
            break;
        case YHProfileInfomationLocation:
            
            cell.detailInfo.delegate = self;
            cell.iconName = @"residence";
            cell.labelMsg = @"现居地";
            cell.detailInfo.inputView = self.locationPickerView;
            cell.detailInfo.text = self.info.location;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 5;
            break;
        case YHProfileInfomationWorkTime:
            
            cell.detailInfo.delegate = self;
            cell.iconName = @"workinglife";
            cell.labelMsg = @"工作年限";
            cell.detailInfo.inputView = self.workYearPickerView;
            cell.detailInfo.text = self.info.workYear;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 6;
            break;
        case YHProfileInfomationPhone:
            
            cell.detailInfo.delegate = self;
            cell.detailInfo.keyboardType = UIKeyboardTypePhonePad;
            cell.iconName = @"suoshuhangye.png";
            cell.labelMsg = @"联系电话";
            cell.detailInfo.text = self.info.mobile;
            cell.detailInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.detailInfo.tag = 7;
            break;
        case YHProfileInfomationEmail:
            
            cell.detailInfo.delegate = self;
            cell.detailInfo.keyboardType = UIKeyboardTypeEmailAddress;
            cell.iconName = @"Email";
            cell.labelMsg = @"电子邮件";
            cell.detailInfo.text = self.info.email;
            cell.detailInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.detailInfo.returnKeyType = UIReturnKeyDone;
            cell.detailInfo.tag = 8;
            break;
        default:break;
    }
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat hei = -offsetY;
    self.headView.frame = CGRectMake(0, 0, self.view.frame.size.width, hei);
    CGFloat rate = offsetY / 235;
    self.imgView.frame = CGRectMake(self.imgView.frame.origin.x, 0, self.imgView.frame.size.width, hei);
    if(-rate >= 1){
        self.imgView.transform = CGAffineTransformMakeScale(-rate, 1);
    }
    
    CGFloat x0 = HEADER_HEIGHT - self.navigationController.navigationBar.frame.size.height - 20;
    CGFloat x1 = hei - self.navigationController.navigationBar.frame.size.height - 20;
    
    if (x1 / x0 < 1) {
        self.avator.alpha = x1 / x0;
        self.nameLabel.alpha = x1 / x0;
    }
}

#pragma mark - Lazy Initial
- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(HEADER_HEIGHT, 0, 0, 0);
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = YHGray;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIView *) headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT)];
        self.imgView.frame = _headView.frame;
        [_headView addSubview:self.imgView];
    }
    return _headView;
}

- (UIImageView *) imgView{
    if(!_imgView){
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"background"]];
    }
    return _imgView;
}

- (UIImageView *) avator {
    if (!_avator) {
        _avator = [[UIImageView alloc] init];
        
        NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
        if(status == NotReachable){
            UIImage *img = [[[SDWebImageManager sharedManager] imageCache] imageFromDiskCacheForKey:@"touxiang"];
            [_avator setImage:img == nil?[UIImage imageNamed: @"place_holder"]:img];
        }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
            [YHUserBasicInfoTool getUserBasicInfo:^(YHResultItem *result) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                YHUserBasicInfo *info = [result.rows firstObject];
                if(info.Photo.length == 0){
                    [_avator setImage:[UIImage imageNamed: @"place_holder"]];
                }else{
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    UIImage *img = [[manager imageCache] imageFromDiskCacheForKey:@"touxiang"];
                    if(img){
                        [_avator setImage:img];
                    }
                    [[manager imageDownloader] downloadImageWithURL:[NSURL URLWithString:info.Photo] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                        if(image && ![image isEqual:img]){
                            [_avator setImage:image];
                            [[manager imageCache] storeImage:image forKey:@"touxiang" toDisk:YES];
                        }else{
                            [_avator setImage:[UIImage imageNamed:@"place_holder"]];
                        }
                    }];
                }
            } withuserId:[userId stringValue]];
        }
        _avator.frame = CGRectMake(0, 0, 100, 100);
        _avator.layer.cornerRadius = _avator.frame.size.height / 2.f;
        _avator.layer.masksToBounds = YES;
        _avator.layer.borderWidth = 2;
        _avator.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
    return _avator;
}

- (UIButton *) nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 20)];
        [_nameLabel setTitle:@"设置头像" forState:UIControlStateNormal];
        [_nameLabel setTitleColor:YHWhite forState:UIControlStateNormal];
        _nameLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel addTarget:self action:@selector(ClickAvator) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nameLabel;
}

- (UIBarButtonItem *) rightButtonItem {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
        [_rightButton setTitle: @"保存" forState: UIControlStateNormal];
        [_rightButton setTitleColor: YHWhite forState: UIControlStateNormal];
        [_rightButton addTarget: self action: @selector(clickSettingButton) forControlEvents: UIControlEventTouchUpInside];
    }
    UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithCustomView: _rightButton];
    return res;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing: YES];
}


- (void)ClickAvator {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"从相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //        [self showAlert:@"拍照"];
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate = self;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else if (buttonIndex == 1) {
        //        [self showAlert:@"从相册选择"];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate = self;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else if(buttonIndex == 2) {
        
    }
}

-(void)showAlert:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Action Sheet选择项"
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil];
    [alert show];
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //    NSLog(@"%@", info);
    //    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //
    //    AGSimpleImageEditorView *editView = [[AGSimpleImageEditorView alloc] init];
    //    editView.image = image;
    //    editView.ratio = 1;
    //    [self.view addSubview:editView];
    //
    //    // 此处需要设置头像
    //    // self.头像Vie.image = editView.image;
    //    [self.avator setImage: editView.image forState: UIControlStateNormal];
    //    [self dismissViewControllerAnimated:YES completion:nil];
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        MBProgressHUD *hud = [self showNetWorkWithHUD:@"正在更新"];
        [hud showAnimated:YES];
        NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        UIImage *originImage = [info valueForKey:UIImagePickerControllerEditedImage];
        
        CGSize cropSize;
        cropSize.width = 180;
        cropSize.height = cropSize.width * originImage.size.height / originImage.size.width;
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        
        originImage = [originImage imageByScalingToSize:cropSize];
        
        NSData *imageData = UIImageJPEGRepresentation(originImage, 0.9f);
        
        NSString *uniqueName = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:date]];
        NSString *uniquePath = [kDocumentsPath stringByAppendingPathComponent:uniqueName];
        
        NSLog(@"uniquePath: %@",uniquePath);
        
        [imageData writeToFile:uniquePath atomically:NO];
        
        NSLog(@"Upload Image Size: %lu KB",[imageData length] / 1024);
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            NSString *token = [self tokenWithScope:QiniuBucketName];
            
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            
            NSData *data = [NSData dataWithContentsOfFile:uniquePath];
            
            NSString *key = [NSURL fileURLWithPath:uniquePath].lastPathComponent;
            
            QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
                                                       progressHandler:^(NSString *key, float percent){
                                                           
                                                       }
                                                                params:@{ @"x:foo":@"fooval" }
                                                              checkCrc:YES
                                                    cancellationSignal:nil];
            
            [upManager putData:data key:key token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          if (!info.error) {
                              NSString *contentURL = [NSString stringWithFormat:@"%@/%@",QiniuBaseURL,key];
                              [hud hideAnimated:YES];
                              NSLog(@"QN Upload Success URL= %@",contentURL);
                             
                              SDWebImageManager *manager = [SDWebImageManager sharedManager];
                              contentURL = [NSString stringWithFormat:@"http://%@", contentURL];
                              
                              [YHUserIconTool uploadUserIcon:[userId stringValue] withPath:contentURL withReturnObject:^(YHReturnMsg * returnMsg) {
                                  if([returnMsg.msg isEqualToString:@"保存成功"]){
                                      [[manager imageDownloader] downloadImageWithURL:[NSURL URLWithString:contentURL] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                          
                                      } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                          [self.avator setImage:image];
                                          if(image != nil){
                                              [[manager imageCache] storeImage:image forKey:@"touxiang" toDisk:YES];
                                              [self.avator setImage:image];
                                          }
                                      }];
                                      [self showSuccessWithHUD:@"更新成功"];
                                  }else{
                                      [self showErrorWithHUD:@"错误"];
                                  }
                              }];
                          }
                          else {
                              [hud hideAnimated:YES];
                              [self showErrorWithHUD:@"更新失败"];
                              NSLog(@"%@",info.error);
                          }
                      } option:opt];
        }];
    }
}

- (NSString *)tokenWithScope:(NSString *)scope{
    QiniuPutPolicy *policy = [QiniuPutPolicy new];
    policy.scope = scope;
    return [policy makeToken:QiniuAccessKey secretKey:QiniuSecretKey];
    
}


@end

