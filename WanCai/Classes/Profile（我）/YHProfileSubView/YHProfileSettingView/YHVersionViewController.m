//
//  YHVersionViewController.m
//  WanCai
//
//  Created by abing on 16/7/23.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHVersionViewController.h"
#import "YHWebViewController.h"
#import "YHDialogue.h"
#import "YHDialogueFrame.h"
#import "YHDialogueViewController.h"
#import "YHFunctionViewController.h"


@interface YHVersionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *versionLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *webButton;

@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation YHVersionViewController

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
        [_iconView setImage:[UIImage imageNamed:@"icon_version"]];
    }
    return _iconView;
}

- (UILabel *)versionLabel{
    if(!_versionLabel){
        _versionLabel = [[UILabel alloc] init];
        NSInteger version = [UIApplication version];
        _versionLabel.text = [NSString stringWithFormat:@"版本号v%d", (int)version];
        _versionLabel.font = [UIFont systemFontOfSize:13];
    }
    return _versionLabel;
}

- (UITableView *) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UIButton *) webButton{
    if(!_webButton){
        _webButton = [[UIButton alloc] init];
        _webButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_webButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _webButton;
}

- (UILabel *) rightLabel{
    if(!_rightLabel){
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:12];
        [_rightLabel setTextColor:[UIColor grayColor]];
    }
    return _rightLabel;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于万才网与帮助";
    self.navigationItem.rightBarButtonItem = nil;
    
    self.view.backgroundColor = YHGray;
    
    [self setFrame];
    
    [self setSubViews];
}

- (void) setSubViews{
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.webButton];
    [self.view addSubview:self.rightLabel];
}

- (void) setFrame{
    
    CGFloat iconHeightAndWidth = 80;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - iconHeightAndWidth) / 2.0;
    CGFloat y = 100;
    self.iconView.frame = CGRectMake(x, y, iconHeightAndWidth, iconHeightAndWidth);
    self.iconView.layer.cornerRadius = 15;
    self.iconView.layer.masksToBounds = YES;
    
    CGSize size = [self.versionLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    x = ([UIScreen mainScreen].bounds.size.width - size.width) / 2.0;
    y = CGRectGetMaxY(self.iconView.frame) + 5;
    self.versionLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    y = CGRectGetMaxY(self.versionLabel.frame) + 20;
    self.tableView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 44 * 3 - 1);
    
    [self.webButton setTitle:@"访问官网" forState:UIControlStateNormal];
    [self.webButton setTitleColor:[UIColor colorWithRed:108/255.0 green:148/255.0 blue:189/255.0 alpha:1] forState:UIControlStateNormal];
    CGFloat width = 100;
    CGFloat height = 20;
    x = ([UIScreen mainScreen].bounds.size.width - width) / 2.0;
    y = [UIScreen mainScreen].bounds.size.height - height - 30;
    self.webButton.frame = CGRectMake(x, y, width, height);
    
    NSString *content = @"Copyright © 2016年 SYYH. All rights reserved.";
    size = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    x = ([UIScreen mainScreen].bounds.size.width - size.width) / 2.0;
    y = CGRectGetMaxY(self.webButton.frame) + 10;
    self.rightLabel.text = content;
    self.rightLabel.frame = CGRectMake(x, y, size.width, size.height);
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"version_identifier"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"version_identifier"];
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"功能介绍";
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"帮助";
    }else{
        cell .textLabel.text = @"反馈";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        YHFunctionViewController *func = [[YHFunctionViewController alloc] init];
        func.title = @"功能介绍";
        [self.navigationController pushViewController:func animated:YES];
    }else if(indexPath.row == 1){
        YHDialogue *dia = [[YHDialogue alloc] init];
        dia.date = @"2016/7/29 15:34:45";
        dia.iconName = @"icon_version";
        dia.comName = @"小帮手";
        dia.detailMsg = @"您好，我是您的小秘书哦！有什么问题可以问我！";
        YHDialogueFrame *frame = [[YHDialogueFrame alloc] init];
        dia.ShowTime = YES;
        frame.dia = dia;
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[frame]];
        YHDialogueViewController *dialogue = [[YHDialogueViewController alloc] initWithArray:array];
        dialogue.title = @"万才小秘书";
        [self.navigationController pushViewController:dialogue animated:YES];
    }else{
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
}

- (void) clickButton{
    YHWebViewController *webView = [[YHWebViewController alloc] init];
    [self.navigationController pushViewController:webView animated:YES];
}

@end
