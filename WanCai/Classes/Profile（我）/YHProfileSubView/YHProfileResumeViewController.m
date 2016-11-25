//
//  YHProfileResumeViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/6/1.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeViewController.h"
#import "YHProfileResumePageContentViewController.h"
#import "YHResumeTool.h"
#import "YHProfileResumeModel.h"
#import "YHResultItem.h"
#import "YHResume.h"
#import "YHResumeBasicInfo.h"
#import "YHProfileAddResumeViewController.h"
#import "YHNavController.h"
#import "YHProfileUpdateResumeTableViewController.h"
#import "Masonry.h"
#import "YHReturnMsg.h"

static unsigned int NOW_PAGE_INDEX = 0;

@interface YHProfileResumeViewController()<UIScrollViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong,nonatomic) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray<YHProfileResumeModel *> *netdatas;

@property (nonatomic, strong) UIButton      *rightButton;

@end

@implementation YHProfileResumeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self network];
    [self initial];
    [self initUI];
}

- (void)initUI {
    UIView *footer1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width / 2, 80)];
    footer1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footer1];
    
    UIButton *fixResume = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [footer1 addSubview:fixResume];
    fixResume.backgroundColor = YHBlue;
    fixResume.layer.cornerRadius = 10;
    fixResume.layer.masksToBounds = YES;
    [fixResume setTitle:@"修改" forState:UIControlStateNormal];
    [fixResume setTitleColor:YHWhite forState:UIControlStateNormal];
    [fixResume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(footer1).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
    [fixResume addTarget:self
                  action:@selector(fixButton)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIView *footer2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height - 80, self.view.frame.size.width / 2, 80)];
    footer2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footer2];
    
    UIButton *delResume = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [footer2 addSubview:delResume];
    delResume.backgroundColor = YHColor(31, 212, 183);
    delResume.layer.cornerRadius = 10;
    delResume.layer.masksToBounds = YES;
    [delResume setTitle:@"删除" forState:UIControlStateNormal];
    [delResume setTitleColor:YHWhite forState:UIControlStateNormal];
    [delResume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(footer2).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    [delResume addTarget:self action:@selector(deleteButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)deleteButton {
    [YHResumeTool deleteResume:^(YHReturnMsg *result) {
        [self reload];
    } withResumeId:self.netdatas[NOW_PAGE_INDEX].resumeId];
}

- (void)fixButton {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResume" bundle:nil];
    YHProfileUpdateResumeTableViewController *add = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileUpdateResumeTableViewController"];
    add.profileResume = self.netdatas[NOW_PAGE_INDEX];
    [self.navigationController pushViewController:add animated:YES];
}

- (void) initial {
    self.view.backgroundColor = YHGray;
    self.title = @"我的简历";
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
}

- (void)reload {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResume" bundle:nil];
    self.pageViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    YHProfileResumePageContentViewController *vc = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[vc];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 80);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (void)network {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userId = [defaults objectForKey:@"userId"];
    NSString *str_userId = [userId stringValue];
    
    NSMutableArray<YHProfileResumeModel *> *nedatas = [NSMutableArray array];
    [YHResumeTool getResumeList:^(YHResultItem *result) {
        for (YHResume *res in result.rows) {
            YHProfileResumeModel *one = [[YHProfileResumeModel alloc] init];
            one.userId = str_userId;
            one.resumeId = res.ResumeId;
            one.userName = res.UserName;
            one.resumeName = res.ResumeName;
            one.privacy = res.Privacy;
            one.resumeIntergrity = res.ResumeIntergrity;
            one.updateTime = res.UpdateTime;
            
            [YHResumeTool getResumeBasicInfo:^(YHResultItem *result) {
                for (YHResumeBasicInfo *res in result.rows) {
                    one.resumeName = res.ResumeName;
                    one.userName = res.UserName;
                    one.email = res.Email;
                    one.mobile = res.Mobile;
                    one.expertJob = res.ExpectJob;
                    one.expectLocation = res.ExpectLocation;
                    one.createTime = res.CreateTime;
                    one.updateTime = res.UpdateTime;
                    one.photoUrl = res.Photo;
                    
                    [one setGenderWithName:res.Gender];
                    [one setDegreeWithName:res.HighDegree];
                    [one setMarriageWithName:res.Marriage];
                    [one setLocationWithCityName:res.xjdLocaltion];
                    [one setDegreeWithName:res.HighDegree];
                    [one setPolicicalstatusWithName:res.PoliticalStatus];
                    [one setWorkyearWithName:res.WorkYears];
                    [nedatas addObject:one];
                }
                if (self.netdatas != nil) {
                    if (self.netdatas.count > 0) [self reload];
                }
                self.netdatas = nedatas;
            } withResumeId:one.resumeId];
        }
    } withuserId:str_userId];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((YHProfileResumePageContentViewController *)viewController).index;
    if (index == NSNotFound) return nil;
    NOW_PAGE_INDEX = (unsigned int)index;
    return [self viewControllerAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((YHProfileResumePageContentViewController *)viewController).index;
    if (index == NSNotFound) return nil;
    NOW_PAGE_INDEX = (unsigned int)index;
    return [self viewControllerAtIndex:index + 1];
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    YHProfileResumePageContentViewController *thisOne = (YHProfileResumePageContentViewController *)previousViewControllers[0];
    NSLog(@"%@", thisOne.profileResume);
}

- (YHProfileResumePageContentViewController *)viewControllerAtIndex: (NSUInteger)index {
    if (self.netdatas.count == 0 || index >= self.netdatas.count) {
        return nil;
    }
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResume" bundle:nil];
    YHProfileResumePageContentViewController *ppcvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumePageContentViewController"];
    
    YHProfileResumeModel *model = self.netdatas[index];
    ppcvc.resumenName = model.resumeName;
    ppcvc.userName = model.resumeName;
    ppcvc.index = index;
    ppcvc.msgArr = [NSMutableArray array];
    if (model.location.length > 0) {
        [ppcvc.msgArr addObject:model.location];
    }
    if (model.jobNature.length > 0) {
        [ppcvc.msgArr addObject:model.jobNature];
    }
    if (model.workyear.length > 0) {
        [ppcvc.msgArr addObject:model.workyear];
    }
    if (model.degree.length > 0) {
        [ppcvc.msgArr addObject:model.degree];
    }
    ppcvc.selfEvaluation = model.selfEvaluation;
    ppcvc.expectSalary = model.expectSalary;
    
    ppcvc.profileResume = model;
    
    return ppcvc;
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.netdatas.count;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void) addResume {
    NSLog(@"ADD RESUME");
    YHProfileAddResumeViewController *vs = [[YHProfileAddResumeViewController alloc] init];
    YHNavController *navigationController =
    [[YHNavController alloc] initWithRootViewController:vs];
    
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
}

- (UIBarButtonItem *) rightButtonItem {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
        [_rightButton setTitle: @"添加" forState: UIControlStateNormal];
        [_rightButton setTitleColor: YHWhite forState: UIControlStateNormal];
        [_rightButton addTarget: self action: @selector(addResume) forControlEvents: UIControlEventTouchUpInside];
    }
    UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithCustomView: _rightButton];
    return res;
}



@end
