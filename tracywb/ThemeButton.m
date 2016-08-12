//
//  ThemeButton.m
//  tracywb
//
//  Created by jimmy on 16/6/25.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton


- (id) initWithImageName:(NSString *) imageName withHighlightImageName:(NSString *)highlightImageName{
    self = [self init];
    if(self){
        self.imageName = imageName;
        self.highlightImageName = highlightImageName;
    
    }
    return self;

}

- (void)setLeftTapWidth:(NSInteger)leftTapWidth{

    _leftTapWidth = leftTapWidth;
    [self loadImage];
    
}

- (void)setTopTapWidth:(NSInteger)topTapWidth{

    _topTapWidth = topTapWidth;
    [self loadImage];
}


- (id) initWithBackgroundImageName:(NSString *) backgroundImageName withBackgroundHighlightImageName:(NSString *)backgroundHighlightImageName{
    self = [self init];
    if(self){
        self.backgroundImageName = backgroundImageName;
        self.backgroundHighlightImageName = backgroundHighlightImageName;
    }
    return self;
}


- (void) loadImage{
    ThemeManager *themeManager = [ThemeManager shareThemeManager];
    UIImage *image1 = [themeManager getThemeImage:_imageName];
    [image1 stretchableImageWithLeftCapWidth:_leftTapWidth topCapHeight:_topTapWidth];
    [self setImage:image1 forState:UIControlStateNormal];
    UIImage *image2 = [themeManager getThemeImage:_highlightImageName];
    [image2 stretchableImageWithLeftCapWidth:_leftTapWidth topCapHeight:_topTapWidth];
    [self setImage:image2 forState:UIControlStateHighlighted];
    UIImage *view3 = [themeManager getThemeImage:_backgroundImageName];
    [self setBackgroundImage:view3 forState:UIControlStateNormal];
    UIImage *view4 = [themeManager getThemeImage:_backgroundImageName];
    [self setBackgroundImage:view4 forState:UIControlStateHighlighted];
    
}

//override
- (void) setImageName:(NSString *)imageName{
    if(_imageName != imageName){
        _imageName = [imageName copy];
    }
    [self loadImage];
}

- (void) setHighlightImageName:(NSString *)highlightImageName{
    if(_highlightImageName != nil){
        _highlightImageName = [highlightImageName copy];
    }
    [self  loadImage];
    
}

- (void) setBackgroundImageName:(NSString *)backgroundImageName{
    if(_backgroundImageName != backgroundImageName){
        _backgroundImageName = [backgroundImageName copy];
    }
    [self loadImage];
}

- (void) setBackgroundHighlightImageName:(NSString *)backgroundHighlightImageName{
    if(_backgroundHighlightImageName != backgroundHighlightImageName){
        _backgroundHighlightImageName = [backgroundHighlightImageName copy];
    }
    [self loadImage];
}
//override
- (id) init{
    self = [super init];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeNotification object:nil];
    }
    return self;
}

//主题修改时修改图片
- (void) themeNotification:(NSNotification *)notification{
    [self loadImage];
}

//override,在此只有dealloc可以不用super dealloc
- (void) dealloc{
    //去除所有的监听器
    [[NSNotificationCenter defaultCenter ] removeObserver:self];
}


@end
