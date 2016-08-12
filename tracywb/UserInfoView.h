//
//  UserInfoView.h
//  tracywb
//
//  Created by wangjl on 16/7/9.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RectButton.h"
#import "WeiboBaseUser.h"

@interface UserInfoView : UIView

@property (strong,nonatomic) WeiboBaseUser *user;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;

@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet RectButton *fansCount;
@property (strong, nonatomic) IBOutlet RectButton *data;
@property (strong, nonatomic) IBOutlet RectButton *more;
@property (strong, nonatomic) IBOutlet UILabel *weiboCount;
- (IBAction)goFansView:(id)sender;

- (IBAction)goFriendships:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *summary;
@property (strong, nonatomic) IBOutlet RectButton *focusCount;
@end
