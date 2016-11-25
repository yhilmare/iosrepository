//
//  YHDialogueViewController.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDialogueViewController.h"
#import "YHDialogueFrame.h"
#import "YHDialogue.h"
#import "YHDialogueDetailTableViewCell.h"
#import "YHDialgueTexttField.h"

@interface YHDialogueViewController () <UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSMutableArray *msgArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation YHDialogueViewController

- (UIToolbar *) toolBar{
    if(!_toolBar){
        CGFloat x = 0;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = 49;
        CGFloat y = [UIScreen mainScreen].bounds.size.height - height;
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_toolBar setBarTintColor:YHGray];
        
        YHDialgueTexttField *textField = [[YHDialgueTexttField alloc] init];
        [_toolBar addSubview:textField];
        textField.frame = CGRectMake(20, 8, [UIScreen mainScreen].bounds.size.width - 50, 33);
        [textField setBackgroundColor:[UIColor whiteColor]];
        textField.layer.cornerRadius = 5;
        textField.layer.masksToBounds = YES;
        textField.returnKeyType = UIReturnKeySend;
        textField.delegate = self;
        textField.layer.borderColor = [[UIColor grayColor] CGColor];
        textField.layer.borderWidth = 0.3;
    }
    return _toolBar;
}

- (NSMutableArray *) msgArray{
    if(!_msgArray){
        _msgArray = [NSMutableArray array];
    }
    return _msgArray;
}

- (UITableView *) tableView{
    if(!_tableView){
        CGFloat x = self.view.frame.origin.x;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = self.view.frame.size.height - 49;
        CGFloat y = self.view.frame.origin.y;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setBackgroundColor:[UIColor colorWithRed:236 / 255.0 green:237 / 255.0 blue:241 / 255.0 alpha:1]];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFunction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.navigationItem.title = self.title;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.toolBar];
}

- (void) keyBoardFunction:(NSNotification *) notice{
    
    NSDictionary *dic =  notice.userInfo;
    CGRect frame = [dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat offset = frame.origin.y - [UIScreen mainScreen].bounds.size.height;
    
    CGFloat delay = [dic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    [UIView animateWithDuration:delay animations:^{
       
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49 + offset);
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, offset);
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.msgArray.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHDialogueFrame *frame = self.msgArray[indexPath.row];
    return frame.rowHeight;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"dialogue_controller_view_list";
    
    YHDialogueDetailTableViewCell *cell = [YHDialogueDetailTableViewCell cellFromTableView:tableView withIdentifier:identifier];
    YHDialogueFrame *frame = self.msgArray[indexPath.row];
    cell.dia = frame.dia;
    [cell setBackgroundColor:[UIColor colorWithRed:236 / 255.0 green:237 / 255.0 blue:241 / 255.0 alpha:1]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype) initWithArray:(NSMutableArray *)array{
    if(self = [super init]){
        
        YHDialogueFrame *frame = [array firstObject];
        [self.msgArray addObject:frame];
    }
    return self;
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.text.length == 0){
        return NO;
    }
    
    YHDialogueFrame *frame = [self makeDialogue:textField.text viewTag:1 withCompantName:self.title];
    [self.msgArray addObject:frame];
    NSIndexPath *path1 = [NSIndexPath indexPathForRow:self.msgArray.count - 1 inSection:0];
    frame = [self makeDialogue:@"感谢您的支持与配合，希望您工作顺利，生活幸福！" viewTag:0 withCompantName:self.title];

    [self.msgArray addObject:frame];
    NSIndexPath *path2 = [NSIndexPath indexPathForRow:self.msgArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path1, path2] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView scrollToRowAtIndexPath:path2 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    textField.text = @"";
    return YES;
}

- (YHDialogueFrame *) makeDialogue:(NSString *)msg viewTag:(NSInteger) tag withCompantName:(NSString *)comName{
    YHDialogue *dia = [[YHDialogue alloc] init];
    dia.viewTag = tag;
    if(tag == 1){
       dia.iconName = @"IMG_3988";
    }else{
        YHDialogueFrame *temp = [self.msgArray firstObject];
        dia.iconName = temp.dia.iconName;
    }
    dia.comName = comName;
    dia.detailMsg = msg;
    dia.date = [self getDate];
    YHDialogueFrame *frame = self.msgArray[self.msgArray.count - 1];
    dia.ShowTime = [self getDateStr:frame.dia.date withDate:dia.date];
    frame = [[YHDialogueFrame alloc] init];
    frame.dia = dia;
    return frame;
}

- (NSString *) getDate{
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    formate.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    return [formate stringFromDate:date];
}

- (int) YearNumFromDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];
    
    int year = (int)[calendar ordinalityOfUnit:NSYearCalendarUnit inUnit:NSEraCalendarUnit forDate:date];
    return year;
}

- (int) MonthNumFromDate:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    int month = (int)[calendar ordinalityOfUnit:NSMonthCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
    return month;
}

- (int) DayNumFromDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    int day = (int)[calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
    return day;
}

- (int) HourNumFromDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    int hour = (int)[calendar ordinalityOfUnit:NSHourCalendarUnit inUnit:NSDayCalendarUnit forDate:date];
    return hour;
}

- (int) MinNumFromDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    int hour = (int)[calendar ordinalityOfUnit:NSMinuteCalendarUnit inUnit:NSHourCalendarUnit forDate:date];
    return hour;
}

- (BOOL) getDateStr:(NSString *)date withDate:(NSString *) todays{
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setTimeZone:[NSTimeZone systemTimeZone]];
    formate.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *Date = [formate dateFromString:date];
    
    //获取当前时间
    NSDate *today = [formate dateFromString:todays];
    
    int DateNum = [self YearNumFromDate:Date];
    int todayDateNum = [self YearNumFromDate:today];
    if(DateNum < todayDateNum){
        return YES;
    }
    DateNum = [self MonthNumFromDate:Date];
    todayDateNum = [self MonthNumFromDate:today];
    if(DateNum < todayDateNum){
        return YES;
    }
    DateNum = [self DayNumFromDate:Date];
    todayDateNum = [self DayNumFromDate:today];
    if(DateNum < todayDateNum){
        return YES;
    }
    DateNum = [self HourNumFromDate:Date];
    todayDateNum = [self HourNumFromDate:today];
    if(DateNum < todayDateNum){
        return YES;
    }
    DateNum = [self MinNumFromDate:Date];
    todayDateNum = [self MinNumFromDate:today];
    if(DateNum < todayDateNum){
        return YES;
    }
    return NO;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}
@end
