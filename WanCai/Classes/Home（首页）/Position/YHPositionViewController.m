//
//  YHPositionViewController.m
//  WanCai
//
//  Created by abing on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHPositionViewController.h"
#import "YHPositionHeaderView.h"
#import "YHTableViewHeaderView.h"
#import "YHTableViewCell.h"
#import "YHButtonModelFrame.h"
#import "YHButtonModel.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MBProgressHUD.h"

@interface YHPositionViewController () <YHPositionHeaderViewdelgate, UITableViewDataSource, UITableViewDelegate, YHTableViewHeaderViewDelgate, YHTableViewCellDelgate, CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *cityList;//得到整个tableview的城市列表
@property (nonatomic, copy) NSMutableArray *positionArray;//得到历史选择，热门城市等
@property (nonatomic, strong) YHTableViewHeaderView *headerView;//搜索栏，整个tableview的headview
@property (nonatomic, strong) YHPositionHeaderView *position;//模拟导航栏
@property (nonatomic ,strong) CLLocationManager *locationManager;
@property (nonatomic, strong)   UIButton *locationButton;

@end

@implementation YHPositionViewController

- (NSMutableArray *)positionArray{
    if(!_positionArray){
        NSMutableArray *result = [NSMutableArray array];
        //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityList"];
        NSArray *temp = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityList"];
        if(temp.count == 0){
            NSString *path = [[NSBundle mainBundle] pathForResource:@"position.plist" ofType:nil];
            temp = [NSArray arrayWithContentsOfFile:path];
        }
        for (NSDictionary *dic in temp){
            YHButtonModel *model = [[YHButtonModel alloc] init];
            YHButtonModelFrame *modelFrame = [[YHButtonModelFrame alloc] init];
            NSArray *buttonName = dic[@"buttonName"];
            int i = 1;
            for (NSString *item in buttonName){
                NSString *itemName = [NSString stringWithFormat:@"hotcity%d",(i++)];
                [model setValue:item forKey:itemName];
            }
            modelFrame.model = model;
            [result addObject:modelFrame];
        }
        _positionArray = result;
    }
    return _positionArray;
}

- (YHPositionHeaderView *) position{
    if(!_position){
        _position = [[YHPositionHeaderView alloc] init];
        _position.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        _position.delgate = self;
        [_position setBackgroundColor:[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]];
    }
    return _position;
}

- (YHTableViewHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[YHTableViewHeaderView alloc] init];
        _headerView.delgate = self;
    }
    return _headerView;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *) cityList{
    if(!_cityList){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil];
        _cityList = [NSArray arrayWithContentsOfFile:path];
    }
    return _cityList;
}


- (void) viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.position];
    [self.view addSubview:self.tableView];
    
}

- (void) cancelFunction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == 1 || section == 2){
        return 1;
    }
    NSDictionary *dic = self.cityList[section - 3];
    NSArray *temp = dic[@"city"];
    return temp.count - 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityList.count + 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2){
        YHButtonModelFrame *modelFrame = self.positionArray[indexPath.section];
        return modelFrame.rowHeight;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
        YHTableViewCell *cell = [YHTableViewCell getTableViewCellWithIdentifier:@"identifier" tableView:tableView inSection:indexPath];
        cell.modelFrame = self.positionArray[indexPath.section];
        cell.delgate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *reusableIdentifier = @"position_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusableIdentifier];
    }
    NSDictionary *dic = self.cityList[indexPath.section - 3];
    NSArray *temp = dic[@"city"];
    cell.textLabel.text = temp[indexPath.row + 1];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"定位";
    }else if(section == 1){
        return @"历史选择";
    }else if(section == 2){
        return @"热门城市";
    }
    NSDictionary *dic = self.cityList[section - 3];
    return dic[@"province"];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    self.tableView.sectionIndexColor = [UIColor colorWithRed:0/255.0 green:194/255.0 blue:175/255.0 alpha:1];
    self.tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    return @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"#", @"!", @"@", @"$", @"%", @"^", @"&", @"*"];
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}


//以下代码更新所在城市时调用

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2){
        return;
    }
    NSDictionary *dic = self.cityList[indexPath.section - 3];
    NSArray *array = dic[@"city"];
    
    [self updateHistoryLoction:array[indexPath.row + 1]];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    return;
}

//搜索城市时，调用这个方法。遍历location.plist的城市列表。如果命中则刷新当前城市。并且更改历史选择。
- (void) didClickSearchButton:(UITextField *)textFiled{
    
    NSString *keyWord = textFiled.text;
    for(NSDictionary *dic in self.cityList){
        for(NSString *cityName in dic[@"city"]){
            if([cityName isEqualToString:keyWord]){
                self.headerView.textLabel.text = [NSString stringWithFormat:@"当前城市:%@", cityName];
                [self updateHistoryLoction:cityName];
                return;
            }
        }
    }
    for(NSDictionary *dic in self.cityList){
        for(NSString *cityName in dic[@"city"]){
            if([cityName isEqualToString:[NSString stringWithFormat:@"%@市",keyWord]]){
                self.headerView.textLabel.text = [NSString stringWithFormat:@"当前城市:%@", cityName];
                [self updateHistoryLoction:cityName];
                return;
            }
        }
    }
    for(NSDictionary *dic in self.cityList){
        for(NSString *cityName in dic[@"city"]){
            if([cityName isEqualToString:[NSString stringWithFormat:@"%@地区",keyWord]]){
                self.headerView.textLabel.text = [NSString stringWithFormat:@"当前城市:%@", cityName];
                [self updateHistoryLoction:cityName];
                return;
            }
        }
    }
    for(NSDictionary *dic in self.cityList){
        for(NSString *cityName in dic[@"city"]){
            if([cityName isEqualToString:[NSString stringWithFormat:@"%@特别行政区",keyWord]]){
                self.headerView.textLabel.text = [NSString stringWithFormat:@"当前城市:%@", cityName];
                [self updateHistoryLoction:cityName];
                return;
            }
        }
    }
    for(NSDictionary *dic in self.cityList){
        for(NSString *cityName in dic[@"city"]){
            if([cityName isEqualToString:[NSString stringWithFormat:@"%@自治州",keyWord]]){
                self.headerView.textLabel.text = [NSString stringWithFormat:@"当前城市:%@", cityName];
                [self updateHistoryLoction:cityName];
                return;
            }
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:0.9]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor blackColor];
    hud.bezelView.layer.cornerRadius = 10;
    hud.bezelView.layer.masksToBounds = YES;
    [hud hideAnimated:YES afterDelay:1];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aio_face_store_button_canceldown.png"]];
    hud.label.text = @"没有搜索到记录";
    YHLog(@"没有搜索到结果");
}

- (void) didClickButton:(UIButton *)button{
    
    
    if (![button.titleLabel.text isEqualToString:@"点击定位"]){
        
        [self updateHistoryLoction:button.titleLabel.text];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else {
        //此处是点击定位后进行位置更新的按钮，获得定位城市名称后调用updateHistoryLocation方法，更新历史选择，并且更新当前位置
        self.locationButton = button;
        [self initializeLocationService];
    }
    
}

- (void) updateHistoryLoction:(NSString *) location{
    
    //在userdefaults中以关键字currentLocation存储当前的地点名称
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityMappingFile.plist" ofType:nil];
    NSDictionary *locations = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *result = locations[location];
    if(result != nil && result.length != 0){
        [defaults setObject:result forKey:@"locationCode"];
        [defaults synchronize];
    }
    [defaults setObject:location forKey:@"currentLocation"];
    [defaults synchronize];
    
    
    self.headerView.textLabel.text = [NSString stringWithFormat:@"当前城市:%@", location];
    //更新文件，更新历史选择
    //[defaults removeObjectForKey:@"cityList"];
    NSMutableArray *positions = [defaults objectForKey:@"cityList"];
    if(positions.count == 0){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"position.plist" ofType:nil];
        positions = [NSMutableArray arrayWithContentsOfFile:path];
    }
    NSMutableArray *positionArrays = [NSMutableArray arrayWithArray:positions];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:positionArrays[1]];
    NSMutableArray *arrays = [NSMutableArray arrayWithArray:dic[@"buttonName"]];
    
    for(NSString *item in arrays){
        if([location isEqualToString:item]){
            return;
        }
    }
    [arrays replaceObjectAtIndex:0 withObject:arrays[1]];
    [arrays replaceObjectAtIndex:1 withObject:arrays[2]];
    [arrays replaceObjectAtIndex:2 withObject:location];
    [dic setObject:arrays forKey:@"buttonName"];
    [positionArrays replaceObjectAtIndex:1 withObject:dic];
    [defaults setObject:positionArrays forKey:@"cityList"];
    [defaults synchronize];
}

//定位
- (void)initializeLocationService {
    //初始化定位服务
    self.locationManager = [[CLLocationManager alloc] init];
    
    //设置定位的精确度和更新频率
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10.f;
    
    self.locationManager.delegate = self;
    
    //授权状态是没有做过选择
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [self.locationButton setTitle:@"正在定位..." forState:UIControlStateNormal];
        [self.locationManager startUpdatingLocation];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        YHLog(@"开启成功");
    } else {
        YHLog(@"请开启定位功能！");
    }
    if ([[[UIDevice currentDevice]systemVersion] doubleValue] >8.0)
    {
        // 设置定位权限仅iOS8以上有意义,而且iOS8以上必须添加此行代码
        [self.locationManager requestWhenInUseAuthorization];//前台定位
        // [self.locationManager requestAlwaysAuthorization];//前后台同时定位
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    // 1.既然已经定位到了用户当前的经纬度了,那么可以让定位管理器 停止定位了
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.locationManager stopUpdatingLocation];
    // 2.然后,取出第一个位置,根据其经纬度,通过CLGeocoder反向解析,获得该位置所在的城市名称,转成城市对象,用工具保存
    CLLocation *loc = [locations firstObject];
    // 3.CLGeocoder反向通过经纬度,获得城市名
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            NSString *str = [NSString stringWithFormat:@"%@-%@",placemark.administrativeArea,placemark.locality];
            NSLog(@"--name--%@",placemark.name);
            NSLog(@"--locality--%@",placemark.locality);
            
            NSLog(@"--administrativeArea--%@",placemark.administrativeArea);
            NSLog(@"----%@",str);
            NSLog(@"--country--%@",placemark.country);
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }

            NSLog(@"city = %@", city);
            [self.locationButton setTitle:city forState:UIControlStateNormal];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            self.headerView.textLabel.text = [NSString stringWithFormat:@"当前城市：%@", city];
            [self updateHistoryLoction:city];
        }else if (error == nil && [array count] == 0){
            [self.locationButton setTitle:@"点击定位" forState:UIControlStateNormal];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSLog(@"No results were returned.");
        }else if (error != nil){
            [self.locationButton setTitle:@"点击定位" forState:UIControlStateNormal];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

//定位失败的方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self showErrorWithHUD:@"定位失败"];
    [self.locationButton setTitle:@"点击定位" forState:UIControlStateNormal];
    NSLog(@"定位失败的方法=====%@", error);
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

//授权状态改变的方法
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"授权状态改变的方法---%d", status);
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
