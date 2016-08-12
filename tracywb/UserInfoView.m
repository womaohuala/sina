//
//  UserInfoView.m
//  tracywb
//
//  Created by wangjl on 16/7/9.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "UserInfoView.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIViewExt.h"
#import "FriendshipdViewController.h"

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self _initView];
    
    }
    return self;

}

//初始化视图
- (void)_initView{

     UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] objectAtIndex:0];
    
    [self addSubview:view];
    self.size = view.size;

}


//override
- (void)layoutSubviews{
    [super layoutSubviews];
    NSURL *url = [NSURL URLWithString:self.user.profile_image_url];
    [self.headImage sd_setImageWithURL:url];
    self.nickName.text = self.user.screen_name;
    NSString *address = self.user.location;
    NSString *gender = self.user.gender;
    if([gender isEqualToString:@"m"]){
        gender = @"男";
    }else if([gender isEqualToString:@"f"]){
        gender = @"女";
    }else if([gender isEqualToString:@"n"]){
        gender = @"未知";
    }
    self.address.text = [NSString stringWithFormat:@"%@   %@",gender,address];
    NSLog(@"description:%@",self.user.descriptionSummary);
    self.summary.text = self.user.descriptionSummary;
    
    self.focusCount.title = @"关注1";
    self.focusCount.subtitle = [NSString stringWithFormat:@"%@",self.user.friends_count];
    
    self.fansCount.title = @"粉丝1";
    self.fansCount.subtitle = [NSString stringWithFormat:@"%@",self.user.followers_count];
    
    self.weiboCount.text = [NSString stringWithFormat:@"微博数:%@",self.user.statuses_count];

}


- (IBAction)goFansView:(id)sender {
    FriendshipdViewController *friendships = [[FriendshipdViewController alloc] init];
    friendships.screenName = self.user.idstr;
    [self.viewController.navigationController pushViewController:friendships animated:YES];
    
}

- (IBAction)goFriendships:(id)sender {
    FriendshipdViewController *friendships = [[FriendshipdViewController alloc] init];
    friendships.screenName = self.user.idstr;
    [self.viewController.navigationController pushViewController:friendships animated:YES];
}
@end
