//
//  CommentModel.m
//  tracywb
//
//  Created by wangjl on 16/7/6.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "CommentModel.h"
#import "WeiboBaseUser.h"
#import "CommentStatus.h"

@implementation CommentModel


- (void)setAttributes:(NSDictionary *)dataDic{
    [super setAttributes:dataDic];
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if(userDic != nil){
        WeiboBaseUser *user = [[WeiboBaseUser alloc] initWithDataDic:userDic];
        self.user = user;
    }
    
    NSDictionary *statusDic = [dataDic objectForKey:@"status"];
    if(userDic != nil){
        CommentStatus *status = [[CommentStatus alloc] initWithDataDic:statusDic];
        self.status = status;
    }

}

@end
