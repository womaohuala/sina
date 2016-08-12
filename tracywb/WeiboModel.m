//
//  WeiboModel.m
//  tracywb
//
//  Created by jimmy on 16/6/27.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel

- (NSDictionary *)attributeMapDictionary{
    NSDictionary *dic = @{
                          @"createDate":@"created_at",
                          @"wbId":@"id",
                          @"text":@"text",
                          @"source":@"source",
                          @"favorited":@"favorited",
                          @"thumbnailImage":@"thumbnail_pic",
                          @"bmiddleImage":@"bmiddle_pic",
                          @"originalImage":@"original_pic",
                          @"geo":@"geo",
                          @"repostCount":@"reposts_count",
                          @"commentsCount":@"comments_count"
                          };
    return dic;
}

//设置WeiboModel和WeiboBaseUser
- (void)setAttributes:(NSDictionary *)dataDic{
    [super setAttributes:dataDic];
    NSDictionary *weiboDic = [dataDic objectForKey:@"retweeted_status"];
    if(weiboDic != nil){
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:weiboDic];
        self.retweetedWB = weibo;
    }
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if(userDic != nil){
        WeiboBaseUser *user = [[WeiboBaseUser alloc] initWithDataDic:userDic];
        self.baseUser = user;
    }
}

@end
