//
//  WebViewController.h
//  tracywb
//
//  Created by wangjl on 16/7/11.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>{

    NSString *_url;

}

- (id)initWithUrl:(NSString *)url;



@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)backButton:(UIButton *)sender;
- (IBAction)forwordButton:(UIButton *)sender;
- (IBAction)refreshButton:(UIButton *)sender;

@end
