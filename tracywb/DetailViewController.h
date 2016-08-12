//
//  DetailViewController.h
//  tracywb
//
//  Created by wangjl on 16/7/6.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "CommentTableView.h"
#import "WBHttpRequest.h"

@interface DetailViewController : BaseViewController<WBHttpRequestDelegate>{

    WeiboView *_weiboView;
    
}

@property(nonatomic,retain)WeiboModel *weiboModel;


@property (strong, nonatomic) IBOutlet CommentTableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *userHeaderView;  //tableview头部视图

@property (retain, nonatomic) IBOutlet UIImageView *userHeadImage;  //头像视图

@property (retain, nonatomic) IBOutlet UILabel *nickName;        //昵称

@property (retain,nonatomic) WBHttpRequest *wbHttprequest;   //微博请求

@end
