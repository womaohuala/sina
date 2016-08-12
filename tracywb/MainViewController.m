//
//  MainViewController.m
//  tracywb
//
//  Created by jimmy on 16/6/21.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoveryViewController.h"
#import "ProfileViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "ThemeButton.h"
#import "ThemeManager.h"
#import "UIFactory.h"
#import "ThemeImageView.h"
#import "UIViewExt.h"
#import "WBHttpRequest.h"
#import "JSONKit.h"



@interface MainViewController ()

@end


@implementation MainViewController

@synthesize wbHttprequest;

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonWidth = kScreenWidth/5.0;
    [self  _initViewController];
    [self _initTabBarView];
    /*
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(_showUnreadWeiboCount) userInfo:nil repeats:YES];
    */
}


//在微博图标上显示未读微博数量
- (void) _showUnreadWeiboCount{
    NSLog(@"_showUnreadWeiboCount");
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    //NSString *token = [data valueForKey:kUserToken];
    NSString *userId = [data valueForKey:kUserId];
    //NSLog(@"token:%@,userId:%@",token,userId);
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        NSLog(@"userToken:%@",userToken);
        [param setObject:userToken forKey:@"access_token"];
        [param setObject:userId forKey:@"uid"];
        [param setObject:kAppKey forKey:@"source"];
        self.wbHttprequest = [WBHttpRequest requestWithURL:kGetUnreadWeiboCount
                                                httpMethod:kGetMethod
                                                    params:param
                                                  delegate:self withTag:@"3"];
    }


}

#pragma mark - WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)erro{
    NSLog(@"failerror");
    
}


- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result:%@",result);
    NSString *tag = request.tag;
    NSDictionary *dic = [result objectFromJSONString];
    if(tag != nil){
        if([tag isEqualToString:@"3"]){
            long status = [[dic valueForKey:@"status"] longValue];
            NSLog(@"status:%ld",status);
            [self _addBadgeOfUnreadWeiboCount:status];
        }
        
    }
    
}


//往主页的微博图标上添加未读微博数标签
- (void) _addBadgeOfUnreadWeiboCount:(long)count{
    if(_badgeImage == nil){
        _badgeImage = [[UIFactory alloc] createImageView:@"main_badge"];
        _badgeImage.frame = CGRectMake((kScreenWidth/4)-30, 0, 20, 20);
        [_tabBarView addSubview:_badgeImage];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:_badgeImage.bounds];
        label.tag = 20161;
        label.font = [UIFont systemFontOfSize:14.0f];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [_badgeImage addSubview:label];
    }
    
    if(count > 0){
        UILabel *label = [_badgeImage viewWithTag:20161];
        if(count>99){
            label.text = @"99+";
        }else{
            label.text = [NSString stringWithFormat:@"%ld",count];
        }
        _badgeImage.hidden = NO;
    }else{
        _badgeImage.hidden = YES;
    
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化主界面
- (void) _initViewController {
    HomeViewController *home = [[HomeViewController alloc] init];
    MessageViewController *message = [[MessageViewController alloc] init];
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    DiscoveryViewController *discovery = [[DiscoveryViewController alloc] init];
    MoreViewController *more = [[MoreViewController alloc] init];
    
    NSArray *views = [[NSArray alloc] initWithObjects:home,message,profile,discovery,more, nil];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for(int i = 0;i < views.count ;i++){
        BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:[views objectAtIndex:i]];
        base.delegate = self;
        [viewControllers addObject:base];
    }
    self.viewControllers = viewControllers;
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSInteger count = navigationController.viewControllers.count;
    if(count>=2){
        [self _showTabBar:NO];
    }else if(count==1){
        [self _showTabBar:YES];
    }

}

//是否显示tabbar
- (void)_showTabBar:(BOOL)show{
    if(show){
        [UIView animateWithDuration:0.25 animations:^{
            _tabBarView.left = 0;
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            _tabBarView.left = -kScreenWidth;
        }];
    }
    [self _resizeTableView:show];
}


//重新定义tableview的高度
- (void)_resizeTableView:(BOOL)show{
    NSArray *array = self.view.subviews;
    for(UIView *view in array){
        if([view isKindOfClass:NSClassFromString(@"UITransitionView")]){
            if(show){
                view.height = kScreenHeight-20-49;
            }else {
                view.height = kScreenHeight-20;
            }
        
        }
    }
    
}


//初始化tabbar
- (void) _initTabBarView{
    
    _tabBarView = [[UIView alloc] initWithFrame:CGRectZero];
    _tabBarView.frame = CGRectMake(0, kScreenHeight-kTabBarHeight, kScreenWidth, kTabBarHeight);
    //_tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    ThemeImageView *backImage = [[UIFactory alloc] createImageView:@"tabbar_background.png"];
    backImage.frame = _tabBarView.bounds;
    [_tabBarView addSubview:backImage];
    
    NSArray *views = [[NSArray alloc] initWithObjects:@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png",nil];
    
    NSArray *highViews = [[NSArray alloc] initWithObjects:@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png", nil];
    
    for(int i=0;i<views.count;i++){
        UIButton *button = [[UIFactory alloc] createButtonWithImageName:[views objectAtIndex:i] withHighlightImageName:[highViews objectAtIndex:i]];
        button.showsTouchWhenHighlighted = YES;
        button.tag = i;
        button.frame = CGRectMake((self.buttonWidth-30)/2+i*self.buttonWidth-12, (kTabBarHeight-30)/2-5, self.buttonWidth, kTabBarHeight);
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:button];
    }
    [self.view addSubview:_tabBarView];
    //添加下滑的线条
    _sliderView = [[UIFactory alloc] createImageView:@"tabbar_slider"];
    _sliderView.frame = CGRectMake((self.buttonWidth-15)/2+5, 5, 15, 44);
    _sliderView.backgroundColor = [UIColor clearColor];
    [_tabBarView addSubview:_sliderView];
    
    
}

//选择tabbar上的按钮
- (void)selectedTab:(UIButton *)button {
    NSLog(@"tag:%ld",button.tag);
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left = button.left+(self.buttonWidth-15)/2;
    }];

    //重复点击tabbar上的微博按钮刷新页面
    if(button.tag == self.selectedIndex && button.tag == 0){
        UINavigationController *homeNav =  [self.viewControllers objectAtIndex:0];
        HomeViewController *homeCtrl = [homeNav.viewControllers objectAtIndex:0];
        [homeCtrl autorefreshWeibo];
    }
    self.selectedIndex = button.tag;
    
}

//是否显示新微博图标
- (void)showBadge:(BOOL)show{
    _badgeImage.hidden = !show;
}



@end
