//
//  FriendshipsCell.m
//  tracywb
//
//  Created by wangjl on 16/7/19.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "FriendshipsCell.h"
#import "SDWebImage/UIButton+WebCache.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation FriendshipsCell


//override
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self _initViews];
    }
    return self;
}




//override
- (void)layoutSubviews{
    [super layoutSubviews];
    for(int i=0;i<3;i++){
        UserGridView *userView = [self viewWithTag:2016+i];
        if(self.data.count>=(i+1)){
            WeiboBaseUser *user = [self.data objectAtIndex:i];
            if(user!=nil){
                userView.hidden = NO;
                userView.user = user;
                [userView setNeedsLayout];
            }
        }
        
        
        
        
    }
   
}

//override
- (void)setData:(NSArray *)data{
    if(_data!=data){
        _data = data;
    }
    for(int i=0;i<3;i++){
        UserGridView *userView = [self viewWithTag:2016+i];
        userView.hidden = YES;
    }

}

//初始化视图
- (void)_initViews{
    for(int i=0;i<3;i++){
        UserGridView *info = [[UserGridView alloc] initWithFrame:CGRectZero];
        info.frame = CGRectMake(100*i, 5, 96, 96);
        info.tag = 2016 + i;
        [self.contentView addSubview:info];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
