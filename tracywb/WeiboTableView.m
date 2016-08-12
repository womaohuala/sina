//
//  WeiboTableView.m
//  tracywb
//
//  Created by jimmy on 16/7/4.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"


@implementation WeiboTableView


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if(self){
        
    }
    return self;
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"weibocell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    WeiboModel *model = [self.data objectAtIndex:indexPath.row];
    cell.weiboModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboModel *model = [self.data objectAtIndex:indexPath.row];
    NSInteger height = [WeiboView getWeiboViewHeight:model isPost:NO isDetail:NO];
    return height + 60;
}


@end
