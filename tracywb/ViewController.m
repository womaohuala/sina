//
//  ViewController.m
//  tracywb
//
//  Created by jimmy on 16/6/20.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self _initMainView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化主界面
- (void)_initMainView{
    MainViewController *main = [[MainViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:main];
    [self.view addSubview:_navigationController.view];
    [self.view sendSubviewToBack:_navigationController.view];

}

@end
