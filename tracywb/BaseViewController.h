//
//  BaseViewController.h
//  tracywb
//
//  Created by jimmy on 16/6/21.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface BaseViewController : UIViewController

@property(nonatomic,retain)AppDelegate *appDelegate;

@property (nonatomic,retain)UIWindow *statusTipWindow;

- (void)showStatusTip:(BOOL)show withTitle:(NSString *)title;

@end
