//
//  YHArticleCell.m
//  WanCai
//
//  Created by CheungKnives on 16/7/21.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHArticleCell.h"
#import "YHArticleList.h"
#import "UIImageView+WebCache.h"

@interface YHArticleCell()

@property (nonatomic, strong) UITableView *parentTableView;

@property (nonatomic, strong) UILabel *postDataLabel;


@end

@implementation YHArticleCell

- (UIView *) dimView{
    if(!_dimView){
        _dimView = [[UIView alloc] init];
        [_dimView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    }
    return _dimView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void) setup {
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
    self.parallaxImage = [UIImageView new];
    [self.contentView addSubview:self.parallaxImage];
    [self.contentView sendSubviewToBack:self.parallaxImage];
    self.parallaxImage.backgroundColor = [UIColor whiteColor];
    self.parallaxImage.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    
    // test
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 300, 50)];
    la.textColor = [UIColor whiteColor];
    [self.contentView addSubview:la];
    self.zLabel = la;
    
    self.parallaxRatio = 1.5f;
    
    CGFloat y = 120;
    self.dimView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 200 - y);
    self.dimView.userInteractionEnabled = NO;
    [self.contentView addSubview:self.dimView];
    
    // articleTitle
    UILabel *articleTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, y, 300, 50)];
    //    articleTitle.backgroundColor = [UIColor greenColor];
    articleTitle.textColor = [UIColor whiteColor];
    [self.contentView addSubview:articleTitle];
    self.articleTitleLabel = articleTitle;

    
    // postData
    UILabel *postData = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 300, 50)];
    //    postData.backgroundColor = [UIColor brownColor];
    postData.textColor = [UIColor whiteColor];
    postData.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:postData];
    self.postDataLabel = postData;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    
    [self safeRemoveObserver];
    
    UIView *v = newSuperview;
    while ( v ) {
        if ( [v isKindOfClass:[UITableView class]] ){
            self.parentTableView = (UITableView*)v;
            break;
        }
        v = v.superview;
    }
    [self safeAddObserver];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [self safeRemoveObserver];
}

- (void)safeAddObserver {
    if ( self.parentTableView ) {
        @try {
            [self.parentTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        } @catch(NSException *exception) {
            
        }
    }
}

- (void)safeRemoveObserver {
    if ( self.parentTableView ) {
        @try {
            [self.parentTableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
        }@catch (NSException *exception) {
            
        }@finally {
            self.parentTableView = nil;
        }
    }
}

- (void)dealloc {
    [self safeRemoveObserver];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.parallaxRatio = self.parallaxRatio;
    return;
}

- (void)setParallaxRatio:(CGFloat)parallaxRatio {
    _parallaxRatio = MAX(parallaxRatio, 1.0f);
    _parallaxRatio = MIN(parallaxRatio, 2.0f);
    
    CGRect rect = self.bounds;
    rect.size.height = rect.size.height*parallaxRatio;
    self.parallaxImage.frame = rect;
    
    [self updateParallaxOffset];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ( [keyPath isEqualToString:@"contentOffset"] ) {
        if ( ![self.parentTableView.visibleCells containsObject:self] || (self.parallaxRatio==1.0f) ) {
            return;
        }
        
        [self updateParallaxOffset];
    }
}

- (void)updateParallaxOffset {
    CGFloat contentOffset = self.parentTableView.contentOffset.y;
    
    CGFloat cellOffset = self.frame.origin.y - contentOffset;
    
    CGFloat percent = (cellOffset+self.frame.size.height)/(self.parentTableView.frame.size.height+self.frame.size.height);
    
    CGFloat extraHeight = self.frame.size.height*(self.parallaxRatio-1.0f);
    
    CGRect rect = self.parallaxImage.frame;
    rect.origin.y = -extraHeight*percent;
    self.parallaxImage.frame = rect;
}

- (void)setLabel1:(NSString *)text1 {
    _zLabel.text = text1;
}

- (void)setArticle:(YHArticleList *)article {
    [_parallaxImage sd_setImageWithURL:[NSURL URLWithString:article.imageUrl]];
    _articleTitleLabel.text = article.title;
    _postDataLabel.text = article.postDate;
    _postUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", article.postUrl]];
    _imageURL = article.imageUrl;
    
}

@end
