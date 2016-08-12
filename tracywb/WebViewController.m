//
//  WebViewController.m
//  tracywb
//
//  Created by wangjl on 16/7/11.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
       
        
    }
    return self;

}


- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"加载中.....";
    NSURL *nsurl = [NSURL URLWithString:_url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:nsurl];
    _webView.delegate = self;
    [_webView loadRequest:request];
}

//初始化
- (id)initWithUrl:(NSString *)url{
    self = [super  init];
    if(_url != url){
        _url = url;
    }
    return self;
}



- (IBAction)backButton:(id)sender {
    
    if([_webView canGoBack]){
        [_webView goBack];
    }

}

- (IBAction)forwordButton:(UIButton *)sender {

    if([_webView canGoForward]){
        [_webView goForward];
    }

}

- (IBAction)refreshButton:(UIButton *)sender {

    [_webView reload];

}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];

}

@end
