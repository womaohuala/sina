//
//  UserViewController.h
//  tracywb
//
//  Created by wangjl on 16/7/9.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBHttpRequest.h"
#import "UserInfoView.h"
#import "WeiboTableView.h"

@interface UserViewController : UIViewController<WBHttpRequestDelegate>

@property (retain,nonatomic) NSString *nickName;   //昵称

@property (retain,nonatomic) UserInfoView *userInfoView;//用户简介视图


@property (strong, nonatomic) IBOutlet WeiboTableView *tableView;

@property (retain,nonatomic) WBHttpRequest *wbHttprequest;
@end
