//
//  BaseTableView.h
//  tracywb
//
//  Created by jimmy on 16/7/4.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@protocol TableViewRefreshDeleage <NSObject>

@optional
//下拉
- (void)pullDown:(UITableView *)object;

//上拉
- (void)pullUp:(UITableView *)object;

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>{

    UIButton *_loadMoreButton;  //加载更多按钮

}

@property(nonatomic,assign)BOOL reloading;

@property(nonatomic,retain)EGORefreshTableHeaderView *refreshHeaderView;

@property(nonatomic,assign)BOOL isRreshHeader;

@property(nonatomic,retain)NSArray *data;

@property(nonatomic,assign)id<TableViewRefreshDeleage> eventDelegate;

//下拉弹回去
- (void)doneLoadingTableViewData;

//自动上拉刷新
- (void)autoRefreshData;

@end
