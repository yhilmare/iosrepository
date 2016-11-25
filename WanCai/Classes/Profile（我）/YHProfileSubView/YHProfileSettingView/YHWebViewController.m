//
//  YHWebViewController.m
//  WanCai
//
//  Created by abing on 16/7/23.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHWebViewController.h"

@interface YHWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIActivityIndicatorView *flower;

@end

@implementation YHWebViewController

-(UIWebView *) webView{
    if(!_webView){
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIActivityIndicatorView *) flower{
    if(!_flower){
        _flower = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_flower hidesWhenStopped];
        _flower.center = self.view.center;
    }
    return _flower;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.title = @"万才网";
    NSURL *url = [NSURL URLWithString:@"http://wap.cithr.cn/?plg_nld=1&plg_uin=1&plg_nld=1&plg_usr=1&plg_vkey=1&plg_dev=1"];
    self.view.backgroundColor = YHGray;
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.flower];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

}
- (void) webViewDidStartLoad:(UIWebView *)webView{
    self.webView.hidden = YES;
    [self.flower startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.hidden = NO;
    [self.flower stopAnimating];
}

@end
