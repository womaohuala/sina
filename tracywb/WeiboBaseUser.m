//
//  WeiboBaseUser.m
//  tracywb
//
//  Created by jimmy on 16/6/27.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WeiboBaseUser.h"

@implementation WeiboBaseUser

- (NSDictionary *)attributeMapDictionary{
    NSDictionary *dic = @{
                          @"idstr":@"idstr",
                          @"screen_name":@"screen_name",
                          @"name":@"name",
                          @"location":@"location",
                          @"url":@"url",
                          @"profile_image_url":@"profile_image_url",
                          @"avatar_large":@"avatar_large",
                          @"gender":@"gender",
                          @"followers_count":@"followers_count",
                          @"friends_count":@"friends_count",
                          @"statuses_count":@"statuses_count",
                          @"favourites_count":@"favourites_count",
                          @"verified":@"verified",
                          @"descriptionSummary":@"description"
                          
                          };
    return dic;
}

@end
