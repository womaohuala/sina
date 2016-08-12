//
//  WeiboCell.h
//  tracywb
//
//  Created by jimmy on 16/6/28.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboView.h"
#import "WeiboModel.h"

@class WXImageView;
@interface WeiboCell : UITableViewCell{
    WXImageView *_headImage;  //头像
    UILabel *_nickName;       //昵称
    UILabel *_createDate;     //创建时间
    UILabel *_comment;        //评论数
    UILabel *_repostCount;    //转发数
    UILabel *_source;        //来源

}


@property(nonatomic,retain)WeiboView *weiboView;

@property(nonatomic,retain)WeiboModel *weiboModel;


@end
