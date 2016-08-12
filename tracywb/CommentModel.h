//
//  CommentModel.h
//  tracywb
//
//  Created by wangjl on 16/7/6.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboBaseUser.h"
#import "CommentStatus.h"
#import "WXBaseModel.h"
/**

 created_at	string	评论创建时间
 id	int64	评论的ID
 text	string	评论的内容
 source	string	评论的来源
 user	object	评论作者的用户信息字段 详细
 mid	string	评论的MID
 idstr	string	字符串型的评论ID
 status	object	评论的微博信息字段 详细
 reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字段
 
 
*/


@interface CommentModel : WXBaseModel


@property(nonatomic,copy)NSString *created_at;

@property(nonatomic,copy)NSNumber *id;

@property(nonatomic,copy)NSString *text;

@property(nonatomic,copy)NSString *source;

@property(nonatomic,retain)WeiboBaseUser *user;

@property(nonatomic,copy)NSString *mid;

@property(nonatomic,copy)NSString *idstr;

@property(nonatomic,retain)CommentStatus *status;





@end
