//
//  BaseNavigationController.m
//  tracywb
//
//  Created by jimmy on 16/6/21.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ThemeManager.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedNotification:) name:kThemeNotification object:nil];
    }
    return self;
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeNotification object:nil];
}




//主题切换后更改导航栏底图
- (void) themeChangedNotification:(NSNotification *)notification{
    [self loadThemeImage];
    
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

//切换导航栏背景图片
- (void)loadThemeImage{
    UIImage *image = [[ThemeManager shareThemeManager] getThemeImage:@"navigationbar_background.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [[ThemeManager shareThemeManager] getThemeImage:@"navigationbar_background.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipePage:)];
    gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:gesture];
    
}

#pragma mark - actions
- (void)swipePage:(UISwipeGestureRecognizer *)gesture{
    if(gesture.direction == UISwipeGestureRecognizerDirectionRight){
        NSInteger count = self.viewControllers.count;
        if(count>1){
            [self popViewControllerAnimated:YES];
        }
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
