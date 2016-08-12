//
//  WeiboView.h
//  tracywb
//
//  Created by jimmy on 16/6/28.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "RTLabel.h"
#import "ThemeImageView.h"

@interface WeiboView : UIView<RTLabelDelegate>{

    RTLabel *_weiboLabel;   //微博视图部分
    
    UIImageView *_loadImage;  //加载图片

    ThemeImageView *_backgroundImage; //背景图
       
    WeiboView *_postWeibo;        //转发的微博
    
    NSString *_convertStr;        //转换字符串
}

@property(nonatomic,retain)WeiboModel *weiboModel;

@property(nonatomic,assign)BOOL isDetail;  //是否为详情页面

@property(nonatomic,assign)BOOL isPost;   //本微博是否为转发的微博

//根据是否为转发和是否为详情页面判断字体大小
+ (float)getFontSizeWithIsDetail:(BOOL)isDetail andIsPost:(BOOL)isPost;

//获取微博视图高度
+ (float)getWeiboViewHeight:(WeiboModel *)weiboModel isPost:(BOOL)isPost isDetail:(BOOL)isDetail;

@end
