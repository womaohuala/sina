//
//  BaseViewController.m
//  tracywb
//
//  Created by jimmy on 16/6/21.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseViewController.h"
#import "UIFactory.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "Contants.h"
#import "UIViewExt.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackImage];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
}

- (BOOL) prefersStatusBarHidden{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AppDelegate *)appDelegate{

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;

}

//override
- (void) setTitle:(NSString *)title{
    [super setTitle:title];
    
    //UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    //label.textColor = [UIColor blackColor];
    ThemeLabel *label = [[UIFactory alloc] createThemeLable:kNavigationBarTitleLabel];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0f];
    label.text = title;
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
}

//自定义导航栏返回图标
- (void)setBackImage{
    NSArray *array = self.navigationController.viewControllers;
    if(array.count>1){
        //[ThemeManager shareThemeManager].themeName = @"blue";
        UIButton *button = [[UIFactory alloc] createButtonWithImageName:@"navigationbar_back.png" withHighlightImageName:@"navigationbar_back_highlighted.png"];
        button.frame = CGRectMake(0, 0, 24, 24);
        [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
}

- (void)showStatusTip:(BOOL)show withTitle:(NSString *)title{
    if(_statusTipWindow == nil){
        _statusTipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _statusTipWindow.backgroundColor = [UIColor blackColor];
        _statusTipWindow.windowLevel = UIWindowLevelStatusBar;
        UILabel *label = [[UILabel alloc] initWithFrame:_statusTipWindow.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.tag = 2016;
        [_statusTipWindow addSubview:label];
    }
    
    UIImageView *progress = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"queue_statusbar_progress.png"]];
    progress.frame = CGRectMake(0, 20-4, 100, 6);
    progress.left = 0;
    progress.tag = 2016101;
    [_statusTipWindow addSubview:progress];
    [UIView beginAnimations:nil context:nil];
    progress.animationDuration = 3;
    progress.animationRepeatCount = 100;
    progress.left = kScreenWidth;
    [UIView commitAnimations];

    
    if(show){
        UILabel *tmp = [_statusTipWindow viewWithTag:2016];
        tmp.text = title;
        _statusTipWindow.hidden = NO;
    
    }else{
        UILabel *tmp = [_statusTipWindow viewWithTag:2016];
        tmp.text = title;
        [self performSelector:@selector(_hideWindow:) withObject:nil afterDelay:2];
    
    }
    
}


//隐藏窗口
- (void)_hideWindow:(NSString *)title{
    
    
    _statusTipWindow.hidden = YES;
    _statusTipWindow = nil;

}


//返回上一页
- (void)goBack:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
