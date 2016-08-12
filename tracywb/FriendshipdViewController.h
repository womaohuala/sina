//
//  FriendshipdViewController.h
//  tracywb
//
//  Created by wangjl on 16/7/19.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendshipsTableView.h"

typedef  NS_ENUM(NSInteger,ViewType){
    
        FriendType = 1,
        FansType
    
};


@interface FriendshipdViewController : BaseViewController<TableViewRefreshDeleage>

@property (strong, nonatomic) IBOutlet FriendshipsTableView *tableView;

@property(nonatomic,copy)NSString *screenName;

@property(nonatomic,retain)NSMutableArray *data;

@property(nonatomic,retain)NSMutableArray *allData;

@property(nonatomic,copy)NSString *moreCursor;

@property(nonatomic,copy)NSString *upCursor;

@property(nonatomic,assign)ViewType *type;

@end
