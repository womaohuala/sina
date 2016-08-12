//
//  UserGridView.m
//  tracywb
//
//  Created by wangjl on 16/7/17.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "UserGridView.h"
#import "SDWebImage/UIButton+WebCache.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UserViewController.h"
#import "UIView+Addition.h"
#import "UIViewExt.h"

@implementation UserGridView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //从xib中加载进来
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"UserGridView" owner:self options:nil] lastObject];
        view.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.size = view.size;
        [self addSubview:view];
        //加底部图片
        UIImage *image = [UIImage imageNamed:@"profile_button3_1.png"];
        UIImageView *backView = [[UIImageView alloc] initWithImage:image];
        backView.frame = self.bounds;
        [self insertSubview:backView atIndex:0];
        
        
    }
    return self;
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    NSString *headImageStr = self.user.profile_image_url;
    [self.headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:headImageStr] forState:UIControlStateNormal];
    //[self.headImage sd_setImageWithURL: [NSURL URLWithString:headImageStr]forState:UIControlStateNormal];
    self.userName.text = self.user.screen_name;
    self.fansNumber.text = [NSString stringWithFormat:@"%@",self.user.followers_count];
    
}

#pragma mark - headimage action
- (IBAction)clickAction:(id)sender {
    UserViewController *userView = [[UserViewController alloc] init];
    userView.nickName = self.user.screen_name;
    [self.viewController.navigationController pushViewController:userView animated:YES];
    
}
@end
