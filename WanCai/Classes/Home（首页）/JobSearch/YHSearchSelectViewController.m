//
//  YHSearchSelectViewController.m
//  WanCai
//
//  Created by yh_swjtu on 16/7/27.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSearchSelectViewController.h"

@interface YHSearchSelectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, copy) NSMutableArray *array;

@property (nonatomic, strong) UIButton *button;

@end

@implementation YHSearchSelectViewController

- (NSMutableArray *) array{
    if(!_array){
        _array = [NSMutableArray array];
        if(_button.tag == 0){//工作性质按钮
            NSString *path = [[NSBundle mainBundle] pathForResource:@"industry.plist" ofType:nil];
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
            NSArray *temp = dic[@"rows"];
            for(NSDictionary *tempDic in temp){
                [_array addObject:tempDic[@"IndName"]];
            }
        }else if(_button.tag == 1){//工作薪资按钮
            [_array addObjectsFromArray:@[@"1000-2000元", @"2000-3000元", @"3000-5000元", @"5000-8000元", @"8000-10000元", @"10000元以上"]];
        }else if(_button.tag == 2){
            [_array addObjectsFromArray:@[@"全职", @"兼职", @"实习"]];
        }else{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"education.plist" ofType:nil];
            [_array addObjectsFromArray:[NSArray arrayWithContentsOfFile:path]];
            [_array removeObjectAtIndex:0];
        }
    }
    return _array;
}

- (UITableView *) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if(self.button.tag == 0){
        self.navigationItem.title = @"行业";
    }else if(self.button.tag == 1){
        self.navigationItem.title = @"薪资";
    }else if(self.button.tag == 2){
        self.navigationItem.title = @"工作性质";
    }else{
        self.navigationItem.title = @"学历";
    }

    self.navigationItem.rightBarButtonItem = nil;
    [self.view addSubview:self.tableView];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count + 1;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"请选择%@",self.navigationItem.title];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"list_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"不限";
    }else{
        cell.textLabel.text = self.array[indexPath.row - 1];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row != 0){
        [self.button setTitle:self.array[indexPath.row - 1] forState:UIControlStateNormal];
    }else{
        if(self.button.tag == 0){
            [self.button setTitle:@"选择行业" forState:UIControlStateNormal];
        }else if(self.button.tag == 1){
            [self.button setTitle:@"薪资" forState:UIControlStateNormal];
        }else if(self.button.tag == 2){
            [self.button setTitle:@"工作性质" forState:UIControlStateNormal];
        }else{
            [self.button setTitle:@"学历" forState:UIControlStateNormal];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (instancetype) initWithButton:(UIButton *)button{
    if(self = [super init]){
        _button = button;
    }
    return self;
}

@end
