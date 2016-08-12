//
//  CommentCell.m
//  tracywb
//
//  Created by wangjl on 16/7/6.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "CommentModel.h"
#import "UIUtils.h"
#import "UIViewExt.h"


@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImageView = [self viewWithTag:2016100];
    _headImageView.layer.cornerRadius = 5;
    _headImageView.layer.masksToBounds = YES;
    _nickName = [self viewWithTag:2016101];
    _nickName.font = [UIFont systemFontOfSize:14.0f];
    _createTime = [self viewWithTag:2016102];
    _createTime.font = [UIFont systemFontOfSize:14.0f];
    _contentLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    _contentLabel.frame = CGRectMake(_headImageView.right+10, _nickName.bottom+5, 200, 20);
    //设置链接的颜色
    _contentLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    //设置点击链接的高亮显示
    _contentLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.commentModel.user.profile_image_url]];
    _nickName.text = self.commentModel.user.screen_name;
    NSString *format = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *date = [UIUtils dateFromFomate:self.commentModel.created_at formate:format];
    NSString *dateStr = [UIUtils stringFromFomate:date formate:@"HH:mm yyyy-MM-dd"];
    _createTime.text = dateStr;
    if((self.commentModel.text==nil)||(self.commentModel.text.length<6)){
        self.commentModel.text = [self.commentModel.text stringByAppendingString:@"      "];
    }
    _contentLabel.text = self.commentModel.text;
    _contentLabel.font = [UIFont systemFontOfSize:14.0f];
    _contentLabel.height = _contentLabel.optimumSize.height;
    [self.contentView addSubview:_contentLabel];
}

+ (CGFloat)getCommentCellHeiht:(CommentModel *)model{
    NSString *text = model.text;
    RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(0,0,200,0)];
    label.font = [UIFont systemFontOfSize:14.0f];
    if((text==nil)||(text.length<6)){
        text = [text stringByAppendingString:@"      "];
    }
    label.text = text;
    float height = label.optimumSize.height;
    return height+60;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    
}

@end
