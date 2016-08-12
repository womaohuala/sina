//
//  MoreViewController.h
//  tracywb
//
//  Created by jimmy on 16/6/21.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseViewController.h"

@interface MoreViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UITableView *tableView;


@end
