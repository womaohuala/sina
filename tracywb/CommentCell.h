//
//  CommentCell.h
//  tracywb
//
//  Created by wangjl on 16/7/6.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "UIViewExt.h"
#import "CommentModel.h"


@interface CommentCell : UITableViewCell{
    
    UIImageView *_headImageView; //头像
    
    UILabel *_nickName;   //昵称
    
    UILabel *_createTime;  //创建时间
    
    RTLabel *_contentLabel;  //评价内容
    
}

@property(nonatomic,retain)CommentModel *commentModel;


+ (CGFloat)getCommentCellHeiht:(CommentModel *)model;

@end
