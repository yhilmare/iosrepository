//
//  YHProfileAddResumeViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/7/31.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileAddResumeViewController.h"
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
#import "YHResumeTool.h"
#import "UIImageView+WebCache.h"
#import "YHProfileResumeModel.h"
#import "UINavigationBar+YHAwesome.h"


const CGFloat HEADER_HEIGHT_ADD = 250;

typedef NS_ENUM(NSUInteger, YHProfileInfomationType)  {
    YHProfileInfomationName = 0,
    YHProfileInfomationSex,
    YHProfileInfomationMaritalStatus,
    YHProfileInfomationBirthday,
    YHProfileInfomationEducate,
    YHProfileInfomationLocation,
    YHProfileInfomationWorkTime,
    YHProfileInfomationPhone,
    YHProfileInfomationEmail,
    YHProfileInfomationPolicalstatus,
    YHProfileInfomationSeleveluation,
    YHProfileInfomationExpectIndustryType,
    YHProfileInfomationExpectJob,
    YHProfileInfomationExpectLocation,
    YHProfileInfomationJobNature,
    YHProfileInfomationExpectSalary
};

@interface YHProfileAddResumeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIView        *backgroundView;
@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) UIButton      *leftButton;
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
@property (nonatomic, strong) UIPickerView *policticastatusPickerView;
@property (nonatomic, strong) UIPickerView *expectIndustryTypePickerView;
@property (nonatomic, strong) UIPickerView *expectLocationPickerView;
@property (nonatomic, strong) UIPickerView *expectJobPickerView;
@property (nonatomic, strong) UIPickerView *jobNaturePickerView;
@property (nonatomic, strong) UIPickerView *expectSalaryPickerView;
@property (nonatomic, strong) UIPickerView *IndustryPickerView;
@property (nonatomic, assign) NSInteger    index;
@property (nonatomic, copy) NSDictionary *tempDic;
@property (nonatomic, copy) YHUserInfo *info;
@property (nonatomic, strong) UIActivityIndicatorView *flower;
@property (nonatomic ,strong) UIImageView *imgView;
@property (nonatomic, strong) UIToolbar *bar;


@end

@implementation YHProfileAddResumeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:YHGray];
    
    self.navigationItem.title = @"创建简历";
    [self loadUserBasicInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppearanceFunction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 插入tableview
    [self.view addSubview: self.tableView];
    // 增加头像设置View
    [self.view addSubview: self.headView];
    [self.view addSubview: self.avator];
    [self.view addSubview:self.flower];
    [self.view addSubview:self.bar];
    // nav按钮
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
    [self.navigationItem setLeftBarButtonItem: self.leftButtonItem];
    
    // 布局调整
    [self layout];
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

- (UIPickerView *)policticastatusPickerView{
    if (!_policticastatusPickerView) {
        _policticastatusPickerView = [[UIPickerView alloc] init];
        _policticastatusPickerView.dataSource = self;
        _policticastatusPickerView.delegate = self;
        _policticastatusPickerView.tag = 5;
        [_policticastatusPickerView selectRow:0 inComponent:0 animated:YES];
        [_policticastatusPickerView setBackgroundColor:YHWhite];
    }
    return _policticastatusPickerView;
}

- (UIPickerView *)expectIndustryTypePickerView{
    if (!_expectIndustryTypePickerView) {
        _expectIndustryTypePickerView = [[UIPickerView alloc] init];
        _expectIndustryTypePickerView.dataSource = self;
        _expectIndustryTypePickerView.delegate = self;
        _expectIndustryTypePickerView.tag = 6;
        [_expectIndustryTypePickerView selectRow:0 inComponent:0 animated:YES];
        [_expectIndustryTypePickerView setBackgroundColor:YHWhite];
    }
    return _expectIndustryTypePickerView;
}

- (UIPickerView *)expectJobPickerView{
    if (!_expectJobPickerView) {
        _expectJobPickerView = [[UIPickerView alloc] init];
        _expectJobPickerView.dataSource = self;
        _expectJobPickerView.delegate = self;
        _expectJobPickerView.tag = 7;
        [_expectJobPickerView selectRow:0 inComponent:0 animated:YES];
        [_expectJobPickerView setBackgroundColor:YHWhite];
    }
    return _expectJobPickerView;
}

- (UIPickerView *)expectLocationPickerView{
    if (!_expectLocationPickerView) {
        _expectLocationPickerView = [[UIPickerView alloc] init];
        _expectLocationPickerView.dataSource = self;
        _expectLocationPickerView.delegate = self;
        _expectLocationPickerView.tag = 8;
        [_expectLocationPickerView selectRow:0 inComponent:0 animated:YES];
        [_expectLocationPickerView setBackgroundColor:YHWhite];
    }
    return _expectLocationPickerView;
}

- (UIPickerView *)jobNaturePickerView {
    if (!_jobNaturePickerView) {
        _jobNaturePickerView = [[UIPickerView alloc] init];
        _jobNaturePickerView.dataSource = self;
        _jobNaturePickerView.delegate = self;
        _jobNaturePickerView.tag = 9;
        [_jobNaturePickerView selectRow:0 inComponent:0 animated:YES];
        [_jobNaturePickerView setBackgroundColor:YHWhite];
    }
    return _jobNaturePickerView;
}

- (UIPickerView *)expectSalaryPickerView {
    if (!_expectSalaryPickerView) {
        _expectSalaryPickerView = [[UIPickerView alloc] init];
        _expectSalaryPickerView.dataSource = self;
        _expectSalaryPickerView.delegate = self;
        _expectSalaryPickerView.tag = 10;
        [_expectSalaryPickerView selectRow:0 inComponent:0 animated:YES];
        [_expectSalaryPickerView setBackgroundColor:YHWhite];
    }
    return _expectSalaryPickerView;
}

- (UIPickerView *)IndustryPickerView{
    if(!_IndustryPickerView){
        _IndustryPickerView = [[UIPickerView alloc] init];
        _IndustryPickerView.dataSource = self;
        _IndustryPickerView.delegate = self;
        _IndustryPickerView.tag = 11;
        [_IndustryPickerView selectRow:0 inComponent:0 animated:YES];
        [_IndustryPickerView setBackgroundColor:YHWhite];
    }
    return _IndustryPickerView;
}

- (YHUserInfo *)info{
    if(!_info){
        _info = [[YHUserInfo alloc] init];
    }
    return _info;
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if(pickerView.tag == 3 || pickerView.tag == 8){
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
    }else if(pickerView.tag == 5) {
        // 政治面貌
        NSString *path = [[NSBundle mainBundle] pathForResource:@"policicalstatus.plist" ofType:nil];
        NSArray *arrays = [NSArray arrayWithContentsOfFile:path];
        return arrays.count;
    } else if (pickerView.tag == 6) {
        // 期待行业
        NSString *path = [[NSBundle mainBundle] pathForResource:@"industry.plist" ofType:nil];
        NSArray *arrays = [NSArray arrayWithContentsOfFile:path];
        return arrays.count;
    } else if (pickerView.tag == 7) {
        // 期待职位
        
    } else if (pickerView.tag == 8) {
        // 期待地点
        NSString *path = [[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil];
        NSArray *arrays = [NSArray arrayWithContentsOfFile:path];
        if(component == 0){
            return arrays.count;
        }else if(component == 1){
            NSDictionary *dic = arrays[self.index];
            NSArray *temp = dic[@"city"];
            return temp.count;
        }
    } else if (pickerView.tag == 9) {
        // 工作性质
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jobNature.plist" ofType:nil];
        NSArray *arrays = [NSArray arrayWithContentsOfFile:path];
        return arrays.count;
    } else if (pickerView.tag == 10) {
        // 期待薪资
        NSString *path = [[NSBundle mainBundle] pathForResource:@"expectSalary.plist" ofType:nil];
        NSArray *arrays = [NSArray arrayWithContentsOfFile:path];
        return arrays.count;
    }else if(pickerView.tag == 11){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"industry.plist" ofType:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *temp = dic[@"rows"];
        NSMutableArray *arrays = [NSMutableArray array];
        for(NSDictionary *tempDic in temp){
            [arrays addObject:tempDic[@"IndName"]];
        }
        [arrays insertObject:@"请选择" atIndex:0];
        return arrays.count;
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
    }else if(pickerView.tag == 5) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"policicalstatus.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        return array[row];
    } else if (pickerView.tag == 6) {
        // 期待行业
    } else if (pickerView.tag == 7) {
        // 期待职位
    } else if (pickerView.tag == 8) {
        // 期待地点
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
    } else if (pickerView.tag == 9) {
        // 工作性质
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jobNature.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        return array[row];
    } else if (pickerView.tag == 10) {
        // 期待薪资
        NSString *path = [[NSBundle mainBundle] pathForResource:@"expectSalary.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        return array[row];
    }else if(pickerView.tag == 11){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"industry.plist" ofType:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *temp = dic[@"rows"];
        NSMutableArray *arrays = [NSMutableArray array];
        for(NSDictionary *tempDic in temp){
            [arrays addObject:tempDic[@"IndName"]];
        }
        [arrays insertObject:@"请选择" atIndex:0];
        return arrays[row];
    }
        
    return nil;
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
    } else if (pickerView.tag == 5) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"policicalstatus.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for(YHProfileInfomationTableViewCell *cell in self.array){
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            if(path.row == 9){
                if(![array[row] isEqualToString:@"请选择"]){
                    cell.detailInfo.text = array[row];
                }
            }
        }
    } else if (pickerView.tag == 6) {
        // 期待行业
    } else if (pickerView.tag == 7) {
        // 期待职位
    } else if (pickerView.tag == 8) {
        // 期待地点
        NSString *path = [[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSArray *temp;
        NSString *cityName;
        NSString *province;
        if(component == 0){
            [self.expectLocationPickerView selectRow:0 inComponent:1 animated:NO];
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
        [self.expectLocationPickerView reloadComponent:1];
        
        for(YHProfileInfomationTableViewCell *cell in self.array){
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            if(path.row == 13){
                if(province && cityName && ![cityName isEqualToString:@"请选择"]){
                    cell.detailInfo.text = [NSString stringWithFormat:@"%@",cityName];
                }
            }
        }
    } else if (pickerView.tag == 9) {
        // 工作性质
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jobNature.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for(YHProfileInfomationTableViewCell *cell in self.array){
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            if(path.row == 14){
                if(![array[row] isEqualToString:@"请选择"]){
                    cell.detailInfo.text = array[row];
                }
            }
        }
    } else if (pickerView.tag == 10) {
        // 期待薪资
        NSString *path = [[NSBundle mainBundle] pathForResource:@"expectSalary.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for(YHProfileInfomationTableViewCell *cell in self.array){
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            if(path.row == 15){
                if(![array[row] isEqualToString:@"请选择"]){
                    cell.detailInfo.text = array[row];
                }
            }
        }
    }else if(pickerView.tag == 11){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"industry.plist" ofType:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *temp = dic[@"rows"];
        NSMutableArray *arrays = [NSMutableArray array];
        for(NSDictionary *tempDic in temp){
            [arrays addObject:tempDic[@"IndName"]];
        }
        [arrays insertObject:@"请选择" atIndex:0];
        for(YHProfileInfomationTableViewCell *cell in self.array){
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            if(path.row == 11){
                if(![arrays[row] isEqualToString:@"请选择"]){
                    cell.detailInfo.text = arrays[row];
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
                    if(offsetY != 0){
                        [self.navigationController.navigationBar yhSetBackgroundColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:rate]];
                    }
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
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(cell.detailInfo.tag + 1)==16?15:(cell.detailInfo.tag + 1) inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
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



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar yhSetBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage: [[UIImage alloc] init]];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar yhSetBackgroundColor:YHBlue];
}


- (void) layout {
    [self.avator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
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
    }else if (index == 8){
        return @"email";
    }else if (index == 9) {
        return @"policticalstatus";
    }else if (index == 10) {
        return @"seleveluation";
    }else if (index == 11) {
        return @"expectIndustryType";
    }else if (index == 12) {
        return @"expectjob";
    }else if (index == 13) {
        return @"expectLocation";
    }else if (index == 14) {
        return @"jobNature";
    }else if (index == 15) {
        return @"expectSalary";
    }
    return @"";
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

#pragma mark - 取消创建简历
- (void)clickCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置点击事件
- (void) clickSettingButton {
    
    YHProfileResumeModel *one = [[YHProfileResumeModel alloc] init];
    for(YHProfileInfomationTableViewCell *cell in self.array){
        [cell.detailInfo resignFirstResponder];
        NSInteger index = [self.tableView indexPathForCell:cell].row;
        NSString *key = [self enumMappingToFieldName:index];
        [self.dic setValue:cell.detailInfo.text forKey:key];
    }
    
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

    NSArray<NSString *> *allKeys = [self.dic allKeys];
    for (NSString *key in allKeys) {
        if([key isEqualToString: @"mobile"]) {
            one.mobile = [self.dic objectForKey:key];
        } else if ([key isEqualToString:@"seleveluation"]) {
            one.seleveluation = [self.dic objectForKey:key];
        } else if ([key isEqualToString:@"birthday"]) {
            one.birthday = [self.dic objectForKey:key];
        } else if ([key isEqualToString:@"degree"]) {
            one.degree = [self.dic objectForKey:key];
            [one setDegreeWithName:one.degree];
        } else if ([key isEqualToString:@"email"]) {
            one.email = [self.dic objectForKey:key];
        } else if ([key isEqualToString:@"expectIndustryType"]) {
            one.expectIndustryType = [self.dic objectForKey:key];
        } else if ([key isEqualToString:@"expectLocation"]) {
            one.expectLocation = [self.dic objectForKey:key];
            [one setExpectLocationWithName:one.expectLocation];
        } else if ([key isEqualToString:@"expectSalary"]) {
            one.expectSalary = [self.dic objectForKey:key];
            [one setExpectSalaryWithName:one.expectSalary];
        } else if ([key isEqualToString:@"expectjob"]) {
            one.expertJob = [self.dic objectForKey:key];
        } else if ([key isEqualToString:@"gender"]) {
            one.gender = [self.dic objectForKey:key];
            [one setGenderWithName:one.gender];
        } else if ([key isEqualToString:@"jobNature"]) {
            one.jobNature = [self.dic objectForKey:key];
            [one setJobNatureWithName:one.jobNature];
        } else if ([key isEqualToString:@"location"]) {
            one.location = [self.dic objectForKey:key];
            [one setLocationWithCityName:one.location];
        } else if ([key isEqualToString:@"marriage"]) {
            one.marriage = [self.dic objectForKey:key];
            [one setMarriageWithName:one.marriage];
        } else if ([key isEqualToString:@"userName"]) {
            one.userName = [self.dic objectForKey:key];
        } else if ([key isEqualToString:@"workYear"]) {
            one.workyear = [self.dic objectForKey:key];
            [one setWorkyearWithName:one.workyear];
        } else if ([key isEqualToString:@"policticalstatus"]) {
            one.policicalstatus = [self.dic objectForKey:key];
            [one setPolicicalstatusWithName:one.policicalstatus];
        }
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"userId"];
    one.resumeName = @"默认简历";
    one.userId = userId;
    MBProgressHUD *hud = [self showMessage:@"正在创建..."];
    [hud showAnimated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [YHResumeTool createResumeByModel:one calback:^(YHReturnMsg *block) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [hud hideAnimated:YES];
        if([block.msg isEqualToString:@"创建成功"]){
            [self showSuccessWithHUD:@"简历创建成功"];
        }else{
            [self showErrorWithHUD:block.msg];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        });
    }];
}

- (MBProgressHUD *) showMessage:(NSString *)msg{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.8]];
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    hud.label.text = msg;
    return hud;
}


- (void) mappingDictionary:(NSMutableDictionary *)dic{
    
    [self.dic setValue:[self getCityCodeWithCity:self.dic[@"location"]] forKey:@"location"];//地点映射
    [self.dic setValue:[self getCodeWithName:self.dic[@"gender"]] forKey:@"gender"];//性别映射
    [self.dic setValue:[self getCodeWithName:self.dic[@"marriage"]] forKey:@"marriage"];//婚姻映射
    [self.dic setValue:[self getCodeWithName:self.dic[@"degree"]] forKey:@"degree"];//学历映射
    [self.dic setValue:[self getCodeWithName:self.dic[@"workyear"]] forKey:@"workYear"];//工作年限映射
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
    return 16;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"profile_information_cell";
    YHProfileInfomationTableViewCell *cell = [YHProfileInfomationTableViewCell getTableViewCell:tableView reusableIdentifier:cellIdentifier arrayPointer:self.array];
    switch (indexPath.row) {
        case YHProfileInfomationName:
            cell.detailInfo.delegate = self;
            cell.detailInfo.text = self.info.userName;
            //cell.iconName = @"name";
            cell.labelMsg = @"  您的姓名";
            cell.detailInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.detailInfo.returnKeyType = UIReturnKeyDone;
            cell.detailInfo.tag = 0;
            break;
        case YHProfileInfomationSex:
            
            cell.detailInfo.delegate = self;
            //cell.iconName = @"sex";
            cell.labelMsg = @"  性别";
            cell.detailInfo.inputView = self.sexPickerView;
            cell.detailInfo.text = self.info.gender;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 1;
            break;
        case YHProfileInfomationMaritalStatus:
            
            cell.detailInfo.delegate = self;
            //cell.iconName = @"marital_status";
            cell.labelMsg = @"  婚姻状况";
            cell.detailInfo.inputView = self.marriagePickerView;
            cell.detailInfo.text = self.info.marriage;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 2;
            break;
        case YHProfileInfomationBirthday:
            
            cell.detailInfo.delegate = self;
            //cell.iconName = @"birth";
            cell.labelMsg = @"  生日";
            cell.detailInfo.inputView = self.datePicker;
            cell.detailInfo.text = self.info.birthday;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 3;
            break;
        case YHProfileInfomationEducate:
            
            cell.detailInfo.delegate = self;
            cell.detailInfo.inputView = self.eduPickerView;
            //cell.iconName = @"education_status";
            cell.labelMsg = @"  学历";
            cell.detailInfo.text = self.info.degree;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 4;
            break;
        case YHProfileInfomationLocation:
            
            cell.detailInfo.delegate = self;
            //cell.iconName = @"residence";
            cell.labelMsg = @"  现居地";
            cell.detailInfo.inputView = self.locationPickerView;
            cell.detailInfo.text = self.info.location;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 5;
            break;
        case YHProfileInfomationWorkTime:
            
            cell.detailInfo.delegate = self;
            //cell.iconName = @"workinglife";
            cell.labelMsg = @"  工作年限";
            cell.detailInfo.inputView = self.workYearPickerView;
            cell.detailInfo.text = self.info.workYear;
            cell.detailInfo.tintColor = [UIColor clearColor];
            cell.detailInfo.tag = 6;
            break;
        case YHProfileInfomationPhone:
            
            cell.detailInfo.delegate = self;
            cell.detailInfo.keyboardType = UIKeyboardTypePhonePad;
            //cell.iconName = @"suoshuhangye.png";
            cell.labelMsg = @"  联系电话";
            cell.detailInfo.text = self.info.mobile;
            cell.detailInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.detailInfo.tag = 7;
            break;
        case YHProfileInfomationEmail:
            
            cell.detailInfo.delegate = self;
            cell.detailInfo.keyboardType = UIKeyboardTypeEmailAddress;
            //cell.iconName = @"Email";
            cell.labelMsg = @"  电子邮件";
            cell.detailInfo.text = self.info.email;
            cell.detailInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.detailInfo.returnKeyType = UIReturnKeyDone;
            cell.detailInfo.tag = 8;
            break;
            
        case YHProfileInfomationPolicalstatus: {
            cell.detailInfo.delegate = self;
            cell.labelMsg = @"  政治面貌";
            cell.detailInfo.inputView = self.policticastatusPickerView;
            cell.detailInfo.tag = 9;
            break;
            
        }
        case YHProfileInfomationSeleveluation: {
            cell.detailInfo.delegate = self;
            cell.labelMsg = @"  自我评价";
            cell.detailInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.detailInfo.returnKeyType = UIReturnKeyDone;
            cell.detailInfo.tag = 10;
            break;
        }
        case YHProfileInfomationExpectIndustryType: {
            cell.detailInfo.delegate = self;
            cell.labelMsg = @"  期待行业";
            cell.detailInfo.inputView = self.IndustryPickerView;
            cell.detailInfo.returnKeyType = UIReturnKeyDone;
            cell.detailInfo.tag = 11;
            break;
        }
        case YHProfileInfomationExpectJob: {
            cell.detailInfo.delegate = self;
            cell.labelMsg = @"  期待职位";
            cell.detailInfo.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.detailInfo.returnKeyType = UIReturnKeyDone;
            cell.detailInfo.tag = 12;
            break;
        }
        case YHProfileInfomationExpectLocation: {
            cell.detailInfo.delegate = self;
            cell.labelMsg = @"  期望地点";
            cell.detailInfo.inputView = self.expectLocationPickerView;
            cell.detailInfo.tag = 13;
            break;
        }
        case YHProfileInfomationJobNature: {
            cell.detailInfo.delegate = self;
            cell.labelMsg = @"  工作性质";
            cell.detailInfo.inputView = self.jobNaturePickerView;
            cell.detailInfo.tag = 14;
            break;
        }
        case YHProfileInfomationExpectSalary: {
            cell.detailInfo.delegate = self;
            cell.labelMsg = @"  期待薪资";
            cell.detailInfo.inputView = self.expectSalaryPickerView;
            cell.detailInfo.tag = 15;
            break;
        }
        default:break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    CGFloat rate = offsetY / HEADER_HEIGHT_ADD;
    self.imgView.frame = CGRectMake(self.imgView.frame.origin.x, 0, self.imgView.frame.size.width, hei);
    if(-rate >= 1){
        self.imgView.transform = CGAffineTransformMakeScale(-rate, 1);
    }
    [self.navigationController.navigationBar yhSetBackgroundColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1 + rate]];

    CGFloat x0 = HEADER_HEIGHT_ADD - self.navigationController.navigationBar.frame.size.height - 20;
    CGFloat x1 = hei - self.navigationController.navigationBar.frame.size.height - 20;
    
    if (x1 / x0 < 1) {
        self.avator.alpha = x1 / x0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark - Lazy Initial
- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(HEADER_HEIGHT_ADD, 0, 0, 0);
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = YHGray;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIView *) headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT_ADD)];
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


- (UIBarButtonItem *) leftButtonItem {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
        [_leftButton setTitle: @"取消" forState: UIControlStateNormal];
        [_leftButton setTitleColor: YHWhite forState: UIControlStateNormal];
        [_leftButton addTarget: self action: @selector(clickCancelButton) forControlEvents: UIControlEventTouchUpInside];
    }
    UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithCustomView: _leftButton];
    return res;
}

- (UIBarButtonItem *) rightButtonItem {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
        [_rightButton setTitle: @"创建" forState: UIControlStateNormal];
        [_rightButton setTitleColor: YHWhite forState: UIControlStateNormal];
        [_rightButton addTarget: self action: @selector(clickSettingButton) forControlEvents: UIControlEventTouchUpInside];
    }
    UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithCustomView: _rightButton];
    return res;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing: YES];
}

@end

