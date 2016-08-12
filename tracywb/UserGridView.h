//
//  UserGridView.h
//  tracywb
//
//  Created by wangjl on 16/7/17.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboBaseUser.h"

@interface UserGridView : UIView

@property(nonatomic,retain)WeiboBaseUser *user;

@property (strong, nonatomic) IBOutlet UIButton *headImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *fansNumber;
- (IBAction)clickAction:(id)sender;

@end
