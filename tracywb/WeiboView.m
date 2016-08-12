//
//  WeiboView.m
//  tracywb
//
//  Created by jimmy on 16/6/28.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WeiboView.h"
#import "UIFactory.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"
#import "RTLabel.h"
#import "NSString+URLEncoding.h"
#import "UIView+Addition.h"
#import "UserViewController.h"
#import "WebViewController.h"


#define kListFontSize  14.0f
#define kListPostFontSize 13.0f
#define kDetailFontSize 18.0f
#define kDetailPostFontSize 17.0f

#define kTextLabelWidthList kScreenWidth-60  //微博列表正文宽度
#define kTextLabelWidthDetail kScreenWidth-10  //微博详情正文宽度


@implementation WeiboView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self _initWeiboView];
    
    }
    return self;
}

//初始化微博视图
- (void)_initWeiboView{
    _weiboLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    _weiboLabel.font = [UIFont systemFontOfSize:14.0f];
    _weiboLabel.delegate = self;
    //设置链接的颜色
    _weiboLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    //设置点击链接的高亮显示
    _weiboLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    
    [self addSubview:_weiboLabel];
    
    _loadImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _loadImage.backgroundColor = [UIColor clearColor];
    _loadImage.image = [UIImage imageNamed:@"page_image_loading.png"];
    //等比缩放
    _loadImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_loadImage];
    
    _backgroundImage = [[UIFactory alloc] createImageView:@"timeline_retweet_background.png"];
    _backgroundImage.leftCapLength = 25;
    _backgroundImage.topCapLength = 10;
    //从水平方向的25和竖直的10开始拉伸
    UIImage *image = [_backgroundImage.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _backgroundImage.image = image;
    _backgroundImage.backgroundColor = [UIColor clearColor];
    [self insertSubview:_backgroundImage atIndex:0];
    //[self addSubview:_backgroundImage];
    
}

//override,如果把_weiboModel放在_initWeiboView初始化则导致死循环
- (void)setWeiboModel:(WeiboModel *)weiboModel{
    if(_weiboModel != weiboModel){
        _weiboModel = weiboModel;
    }
    if(_postWeibo == nil){
        _postWeibo = [[WeiboView alloc] initWithFrame:CGRectZero];
        _postWeibo.isPost = YES;
        [self addSubview:_postWeibo];
    }
    
    [self _convertPattern];
}

//转换字符串中的http,@,#字符串
- (void)_convertPattern{
    _convertStr = nil;
    NSString *parseStr = [NSMutableString  string];
    NSString *tmp = _weiboModel.text;
    NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    NSArray *array = [tmp componentsMatchedByRegex:regex];
    for (NSString *str in array) {
        if([str hasPrefix:@"@"]){
            NSString *encodeStr = [str URLEncodedString];
            parseStr = [NSString stringWithFormat:@"<a href='user://%@'>%@</a>",encodeStr,str];
        }else if([str hasPrefix:@"http"]){
            parseStr = [NSString stringWithFormat:@"<a href='%@'>%@</a>",str,str];
        }else if([str hasPrefix:@"#"]){
            NSString *encodeStr = [str URLEncodedString];
            parseStr = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",encodeStr,str];
        }
        tmp = [tmp stringByReplacingOccurrencesOfString:str withString:parseStr];
    }
    _convertStr = tmp;
    
    //如果是转发微博，则在正文前加作者名字
    if(_isPost){
        NSString *nickName = _weiboModel.baseUser.screen_name;
        NSString *encodeName = [nickName URLEncodedString];
        nickName = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>:",encodeName,nickName];
        _convertStr = [nickName stringByAppendingString:_convertStr];
        
    }

}

#pragma mark - RTLabelDelegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    NSString *host = [url absoluteString];
    if([host hasPrefix:@"topic"]){
        NSString *tmp = [url host];
        
        
        NSLog(@"host:%@",tmp);
    }else if([host hasPrefix:@"user"]){
        NSString *tmp = [url host];
        tmp = [tmp URLDecodedString];
        NSLog(@"user:%@",tmp);
        
        
        tmp = [tmp URLDecodedString];
        UserViewController *viewCtrl = [[UserViewController alloc] init];
        if([tmp hasPrefix:@"@"]){
            tmp = [tmp substringFromIndex:1];
        }
        viewCtrl.nickName = tmp;
        [self.viewController.navigationController pushViewController:viewCtrl animated:YES];
        
    }else if([host hasPrefix:@"http"]){
        NSLog(@"http:%@",host);
        
        WebViewController *webView = [[WebViewController alloc] initWithUrl:host];
        [self.viewController.navigationController pushViewController:webView animated:YES];
        
    }
    
    
}

//override,设置布局位置
- (void)layoutSubviews{
    [super layoutSubviews];
    float fontSize = [WeiboView getFontSizeWithIsDetail:self.isDetail andIsPost:self.isPost];
    _weiboLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    _weiboLabel.frame = CGRectMake(10, 10, self.width-10, 20);
    //_weiboLabel.text = self.weiboModel.text;
    _weiboLabel.text = _convertStr;
    CGSize size = _weiboLabel.optimumSize;
    _weiboLabel.height = size.height;
    if(_isDetail){
        NSString *bmiddleImage = self.weiboModel.bmiddleImage;
        if((bmiddleImage != nil)&&(bmiddleImage.length > 0)){
            _loadImage.hidden = NO;
            _loadImage.frame = CGRectMake(10, _weiboLabel.bottom+10, 120, 100);
            [_loadImage sd_setImageWithURL:[NSURL URLWithString:self.weiboModel.bmiddleImage]];
        }else{
            _loadImage.hidden = YES;
        }
    }else{
        NSString *imageUrl = self.weiboModel.thumbnailImage;
        if((imageUrl != nil)&&(imageUrl.length > 0)){
            _loadImage.hidden = NO;
            _loadImage.frame = CGRectMake(10, _weiboLabel.bottom+10, 70, 80);
            [_loadImage sd_setImageWithURL:[NSURL URLWithString:self.weiboModel.thumbnailImage]];
        }else{
            _loadImage.hidden = YES;
        }
    }
    
    
    WeiboModel *postModel = self.weiboModel.retweetedWB;
    if(postModel != nil){
        _postWeibo.weiboModel = postModel;
        _postWeibo.hidden = NO;
        float repostHeight = [WeiboView getWeiboViewHeight:postModel isPost:YES isDetail:self.isDetail];
        _postWeibo.frame = CGRectMake(0, _weiboLabel.bottom+10, self.width, repostHeight);
    }else{
        _postWeibo.hidden = YES;
    }
    if(_isPost){
        
        _backgroundImage.frame = CGRectMake(0, 0, self.width, self.height);
        _backgroundImage.hidden = NO;
    }else{
        _backgroundImage.hidden = YES;
    }
    
}

//根据是否为转发和是否为详情页面判断字体大小
+ (float)getFontSizeWithIsDetail:(BOOL)isDetail andIsPost:(BOOL)isPost{
    float size = 14.0f;
    if(!isPost && !isDetail){
        return kListFontSize;
    }else if(!isDetail && isPost){
        return kListPostFontSize;
    }else if(isDetail && !isPost){
        return kDetailFontSize;
    }else if(isPost && isDetail){
        return kDetailPostFontSize;
    }
    return size;
}

//获取微博视图高度
+ (float)getWeiboViewHeight:(WeiboModel *)weiboModel isPost:(BOOL)isPost isDetail:(BOOL)isDetail{
    float height = 0;
    float fontSize = [WeiboView getFontSizeWithIsDetail:isDetail andIsPost:isPost];
    RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    if(isDetail){
        label.width = kTextLabelWidthDetail;
    }else{
        label.width = kTextLabelWidthList;
    }
    if((weiboModel.text == nil)||(weiboModel.text.length<6)){
        weiboModel.text = [weiboModel.text stringByAppendingString:@"      "];
    }
    label.text = weiboModel.text;
    CGSize textSize = label.optimumSize;
    height += textSize.height+30;
    if(isDetail){
        NSString *bmiddleImage = weiboModel.bmiddleImage;
        if((bmiddleImage != nil)&&(bmiddleImage.length > 0)){
            height += 100 + 10;
        }
    }else{
        NSString *imageUrl = weiboModel.thumbnailImage;
        if((imageUrl != nil)&&(imageUrl.length > 0)){
            height += 80 + 10;
        }
    }
    
    
    WeiboModel *repostWeibo = weiboModel.retweetedWB;
    if(repostWeibo != nil){
        height += [WeiboView getWeiboViewHeight:repostWeibo isPost:YES isDetail:isDetail];
    }
    return height;
}


@end
