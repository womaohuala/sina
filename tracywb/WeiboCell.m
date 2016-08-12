//
//  WeiboCell.m
//  tracywb
//
//  Created by jimmy on 16/6/28.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WeiboCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "RTLabel.h"
#import "UIViewExt.h"
#import "UIUtils.h"
#import "UserViewController.h"
#import "RegexKitLite.h"
#import "UIView+Addition.h"
#import "WXImageView.h"

@implementation WeiboCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self _initWeiboCell];
    }
    return self;

}



- (void)setWeiboModel:(WeiboModel *)weiboModel{
    if(_weiboModel != weiboModel){
        _weiboModel = weiboModel;
    }
    __block WeiboCell  *blockSelf = self;
    _headImage.touchImage=^{
        UserViewController *viewCtrl = [[UserViewController alloc] init];
        viewCtrl.nickName = blockSelf.weiboModel.baseUser.screen_name;
        [blockSelf.viewController.navigationController pushViewController:viewCtrl animated:YES];
        
    };
    
}

//初始化weibocell
- (void)_initWeiboCell{
    _headImage = [[WXImageView alloc] initWithFrame:CGRectZero];
    _headImage.layer.cornerRadius = 5;
    _headImage.backgroundColor = [UIColor clearColor];
    _headImage.layer.borderWidth = 0.5;
    _headImage.layer.borderColor = [[UIColor grayColor] CGColor];
    _headImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImage];
    
    
    //[_headImage sd_setImageWithURL:[NSURL URLWithString:_weiboModel.baseUser.profile_image_url]];
    _nickName.font = [UIFont systemFontOfSize:14.0f];
    _nickName.backgroundColor = [UIColor clearColor];
    _nickName = [[UILabel alloc] initWithFrame:CGRectZero];
    //_nickName.text = _weiboModel.baseUser.name;
    [self.contentView addSubview:_nickName];
    
    
    _createDate = [[UILabel alloc] initWithFrame:CGRectZero];
    _createDate.backgroundColor = [UIColor clearColor];
    _createDate.font = [UIFont systemFontOfSize:14.0f];
    _createDate.text = _weiboModel.createDate;
    [self.contentView addSubview:_createDate];
    
    _comment = [[UILabel alloc] initWithFrame:CGRectZero];
    _comment.backgroundColor = [UIColor clearColor];
    _comment.font = [UIFont systemFontOfSize:14.0f];
    //_comment.text = [NSString stringWithFormat:@"%@",_weiboModel.commentsCount];
    [self.contentView addSubview:_comment];
    
    _repostCount = [[UILabel alloc] initWithFrame:CGRectZero];
    _repostCount.backgroundColor = [UIColor clearColor];
    _repostCount.font = [UIFont systemFontOfSize:14.0f];
    //_repostCount.text = [NSString stringWithFormat:@"%@",_weiboModel.repostCount];
    [self.contentView addSubview:_repostCount];
    
    
    _source = [[UILabel alloc] initWithFrame:CGRectZero];
    _source.backgroundColor = [UIColor clearColor];
    _source.font = [UIFont systemFontOfSize:14.0f];
    //_source.text = _weiboModel.source;
    [self.contentView addSubview:_source];
    
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    
    //cell被选中的背景颜色
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height)];
    backGroundView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"statusdetail_cell_sepatator.png"]];
    self.selectedBackgroundView = backGroundView;
}




- (void)layoutSubviews{
    [super layoutSubviews];
    
    _headImage.frame = CGRectMake(5, 5, 35, 35);
    [_headImage sd_setImageWithURL:[NSURL URLWithString:_weiboModel.baseUser.profile_image_url]];
    /*
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserView)];
    gesture.numberOfTapsRequired = 1;
    _headImage.userInteractionEnabled = YES;
    [_headImage addGestureRecognizer:gesture];
    */
    
    _nickName.frame = CGRectMake(50, 5, 200, 20);
    _nickName.text = _weiboModel.baseUser.name;
    
    _createDate.frame = CGRectMake(50, _nickName.bottom, 100, 20);
    NSString *createDate = _weiboModel.createDate;
    if((createDate!=nil)&&(createDate.length>0)){
        _createDate.hidden = NO;
        NSString *format = @"EEE MMM d HH:mm:ss Z yyyy";
        NSDate *date = [UIUtils dateFromFomate:createDate formate:format];
        NSString *dateStr = [UIUtils stringFromFomate:date formate:@"HH:mm yyyy-MM-dd"];
        _createDate.text = dateStr;
        [_createDate sizeToFit];
    }else{
        _createDate.hidden = YES;
    }
    
    if((createDate!=nil)&&(createDate.length>0)){
        _source.hidden = NO;
        _source.frame = CGRectMake(_createDate.right+10, _nickName.bottom, 100, 20);
        //NSLog(@"SOURCE:%@",_weiboModel.source);
        NSString *tmp = [NSString stringWithFormat:@"%@%@",@"来源",[self _parseSource:_weiboModel.source]];
        _source.text = tmp;
        [_source sizeToFit];
    }else{
        _source.hidden = YES;
    }
    
    _weiboView.weiboModel = _weiboModel;
    float height = [WeiboView getWeiboViewHeight:_weiboModel isPost:NO isDetail:NO];
    _weiboView.frame = CGRectMake(50, _createDate.bottom, kScreenWidth-60, height);
    
    
}

- (void)gotoUserView{
    UserViewController *viewCtrl = [[UserViewController alloc] init];
    viewCtrl.nickName = _weiboModel.baseUser.screen_name;
    [self.viewController.navigationController pushViewController:viewCtrl animated:YES];

}

//正则匹配解析来源字符串
- (NSString *)_parseSource:(NSString *)source{
    NSString *regex = @">\\w+<";
    NSArray *array = [source componentsMatchedByRegex:regex];
    if(array.count>0){
        NSString *tmp = [array objectAtIndex:0];
        NSRange range = NSMakeRange(1, tmp.length-2);
        source = [tmp substringWithRange:range];
    }
    return source;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
