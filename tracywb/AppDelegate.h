//
//  AppDelegate.h
//  tracywb
//
//  Created by jimmy on 16/6/20.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "DDMenu/DDMenuController.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)MainViewController *main;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@property (retain,nonatomic) DDMenuController *ddMenu;

@end

