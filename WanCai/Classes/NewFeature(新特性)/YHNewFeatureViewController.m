//
//  YHNewFeatureViewController.m
//  WanCai
//  1.初始化的时候设置布局参数
//  2.collectionView注册cell
//  3.自定义cell
//  修改总页数： 1.修改setupPageControl 2.修改UICollectionView数据源
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHNewFeatureViewController.h"
#import "YHNewFeatureCell.h"
#define YHNewFeatureCount 3

@interface YHNewFeatureViewController ()

@property (nonatomic,weak) UIPageControl *control;

@end

@implementation YHNewFeatureViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置cell尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    //清空行距
    layout.minimumLineSpacing = 0;
    
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [self initWithCollectionViewLayout:layout];
}

// self.collectionView != self.view
// 注意： self.collectionView 是 self.view的子控件

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell，创建自定义的cell
    [self.collectionView registerClass:[YHNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //添加pageController(跟着动的小点)
    [self setupPageControl];
}

#pragma mark -添加pageController，设定一些页数等基本信息,可自定义修改
- (void)setupPageControl{
    //添加pageController，只需要设置位置，不需要设置尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    //设置小点颜色
    control.numberOfPages = 3;
    control.pageIndicatorTintColor = [UIColor grayColor];
    control.currentPageIndicatorTintColor = YHBlue;
    
    //设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height - 20);
    _control = control;
    [self.view addSubview:control];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView代理
//只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取当前的偏移量，计算当前处于第几页
    int page = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    
    //设置页数
    _control.currentPage = page;
}

#pragma mark UICollectionView数据源和代理
//返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//返回有第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return YHNewFeatureCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //从缓冲池中取出cell
    YHNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    
//#ifndef __IPHONE_8_0 // xcode6就不需要编译
//    if (inch4) {
//        imageName = [imageName stringByAppendingString:@"-568h"];
//    }
//#endif
    
    cell.image = [UIImage imageNamed:imageName];
    // 判断是否是最后一页
    [cell setIndexPath:indexPath count:3];
    
    return cell;
}

@end
