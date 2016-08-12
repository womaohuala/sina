//
//  BaseTableView.m
//  tracywb
//
//  Created by jimmy on 16/7/4.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseTableView.h"
#import "UIViewExt.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if(self){
        [self _initBaseTableView];
    }
    return self;

}

//如果是根据xib则会调用该方法
- (void)awakeFromNib{
    [self _initBaseTableView];
    
}

//初始化
- (void)_initBaseTableView{
    self.refreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    self.refreshHeaderView.delegate = self;
    self.refreshHeaderView.backgroundColor=[UIColor clearColor];
    
    
    self.isRreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    
    _loadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [_loadMoreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
    _loadMoreButton.backgroundColor = [UIColor clearColor];
    
    [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loadMoreButton addTarget:self action:@selector(loadMoreData) forControlEvents:UIControlEventTouchUpInside];
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.frame = CGRectMake(20, 5, 30, 30);
    indicatorView.tag = 2016103;
    [indicatorView stopAnimating];
    [_loadMoreButton addSubview:indicatorView];
    self.tableFooterView = _loadMoreButton;
}

#pragma mark - actions
- (void)loadMoreData{
    if([self.eventDelegate respondsToSelector:@selector(pullUp:)]){
        [self.eventDelegate pullUp:self];
        
        
        [self _beginLoadData];
    }

}

//开始加载数据
- (void)_beginLoadData{

    [_loadMoreButton setTitle:@"加载数据中....." forState:UIControlStateNormal];
    _loadMoreButton.enabled = NO;
    UIActivityIndicatorView *view = [_loadMoreButton viewWithTag:2016103];
    [view startAnimating];
    
}

//停止加载数据
- (void)_stopLoadData{
    [_loadMoreButton setTitle:@"上拉加载更多...." forState:UIControlStateNormal];
    _loadMoreButton.enabled = YES;
    UIActivityIndicatorView *view = [_loadMoreButton viewWithTag:2016103];
    [view stopAnimating];
    
}

- (void)setIsRreshHeader:(BOOL)isRreshHeader{
    
    _isRreshHeader = isRreshHeader;
    
    if(_isRreshHeader){
        [self addSubview:self.refreshHeaderView];
    }else{
        if([self.refreshHeaderView superview]){
            [self.refreshHeaderView removeFromSuperview];
        }
    }
    
}

//override
- (void)reloadData{
    [super reloadData];
    [self _stopLoadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.data.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString *identifier = @"baseTableViewCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
    
}



#pragma mark -
#pragma mark UIScrollViewDelegate Methods

//当滑动时，实时调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}
//当手指停止拖拽时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    CGFloat y = scrollView.contentOffset.y;
    CGFloat scrollHeight = scrollView.height;
    CGFloat height =  scrollView.contentSize.height;
    //内容未超出屏幕大小时，上拉的距离即为拉动量,超出了则计算偏差值
    if(height<scrollHeight){
        if(y>30){
            [self _beginLoadData];
            if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
                [self.eventDelegate pullUp:self];
            }
        }
    }else{
        CGFloat sub = scrollHeight -y;
        if((y-sub)>30){
            [self _beginLoadData];
            if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
                [self.eventDelegate pullUp:self];
            }
        
        }
    
    }
    
    
    NSLog(@"yyyyyy:%f",y);
    NSLog(@"height:%f",height);
    NSLog(@"scrollHeight:%f",scrollHeight);
    
    
    
}

//下拉弹回去
//注：这个需要声明为公开方法
- (void)doneLoadingTableViewData{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

#pragma mark - 下拉相关的方法
- (void)reloadTableViewDataSource{
    _reloading = YES;
    
}

//下拉刷新微博列表
- (void)autoRefreshData{
    [_refreshHeaderView initLoading:self];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    
    //停止加载，弹回下拉
    //[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    //使用代理
    if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];
    }
    
}

/*
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading;
    
}
*/

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date];
    
}



@end
