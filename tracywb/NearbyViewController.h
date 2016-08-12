//
//  NearbyViewController.h
//  tracywb
//
//  Created by wangjl on 16/7/12.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "WBHttpRequest.h"

typedef void(^ SelectCellBlock) (NSDictionary *dic);

@interface NearbyViewController : BaseViewController<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>

@property (retain,nonatomic)WBHttpRequest *wbHttprequest;

@property (retain,nonatomic)NSArray *data;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (retain,nonatomic) CLLocationManager *manager;

@property (copy,nonatomic)SelectCellBlock selectBlock;

@end
