//
//  HomeViewController.h
//  tracywb
//
//  Created by jimmy on 16/6/21.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboSDK.h"
#import "WeiboTableView.h"
#import "UIFactory.h"
#import "ThemeImageView.h"

@interface HomeViewController : BaseViewController<WBHttpRequestDelegate,TableViewRefreshDeleage>{


    ThemeImageView *_barView;   //横条显示新的微博数量
    
}


@property(nonatomic,retain) WBHttpRequest *wbHttprequest;

@property(nonatomic,retain)NSMutableArray *data;

@property(retain, nonatomic)WeiboTableView *tableView;

@property(nonatomic,copy)NSString *lastWeiboId;  //最后一个微博id,即id最大的一个微博

@property(nonatomic,copy)NSString *firstWeiboId;  //最前的一个微博id，即id最小的一个微博

- (void)autorefreshWeibo;

@end
