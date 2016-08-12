//
//  CommentTableView.m
//  tracywb
//
//  Created by wangjl on 16/7/6.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
#import "CommentModel.h"

@implementation CommentTableView


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if(self){
        
    }
    return self;
}

#pragma mark - tableview delegate
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"commentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] lastObject];
    }
    CommentModel *model = [self.data objectAtIndex:indexPath.row];
    cell.commentModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model = [self.data objectAtIndex:indexPath.row];
    CGFloat height = [CommentCell getCommentCellHeiht:model];
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40.0f;
    
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSNumber *total = [self.dic valueForKey:@"total_number"];
    if((total!=nil)&&(![total isKindOfClass:[NSNull class]])){
        NSLog(@"section:%ld",section);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        view.backgroundColor = [UIColor grayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth-10, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        NSString *totalNumber = [total stringValue];
        label.text = [NSString stringWithFormat:@"评论:%@",totalNumber];
        [view addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, kScreenWidth, 1)];
        imageView.image = [UIImage imageNamed:@"userinfo_header_separator.png"];
        imageView.backgroundColor = [UIColor clearColor];
        [view addSubview:imageView];
        return view;
    }else{
        return nil;
    }
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
