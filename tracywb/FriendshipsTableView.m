//
//  FriendshipsTableView.m
//  tracywb
//
//  Created by wangjl on 16/7/19.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "FriendshipsTableView.h"
#import "FriendshipsCell.h"


@implementation FriendshipsTableView



//override
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"friendshipsCell";
    FriendshipsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil){
        cell = [[FriendshipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.data = [self.data objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



//override
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105;

}


@end
