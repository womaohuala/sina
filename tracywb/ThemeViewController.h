//
//  ThemeViewController.h
//  tracywb
//
//  Created by jimmy on 16/6/25.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain) NSArray *themes;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
