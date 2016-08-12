//
//  RightViewController.m
//  tracywb
//
//  Created by jimmy on 16/6/22.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "RightViewController.h"
#import "SendViewController.h"
#import "BaseNavigationController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)button:(UIButton *)sender {
    
    NSInteger tag = [sender tag];
    NSLog(@"tag:%ld",tag);
    if(tag == 2016100){
        SendViewController *sendView = [[SendViewController alloc] init];
        BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:sendView];
        [self.appDelegate.ddMenu presentViewController:base animated:YES completion:nil];
    
    }
}
@end
