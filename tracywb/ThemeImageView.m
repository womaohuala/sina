//
//  ThemeImageView.m
//  tracywb
//
//  Created by jimmy on 16/6/26.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

@synthesize leftCapLength;
@synthesize topCapLength;

//override从xib初始化
- (void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeNotification object:nil];
}

//override
- (id)init{
    self = [super init];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeNotification object:nil];
    }
    return self;
}



//override，去除监听器
- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeNotification object:nil];
}

- (void)themeNotification:(NSNotification *)notification {
    [self loadThemeImageView];

}
- (id) initWithImageName:(NSString *)imageName{
    self = [self init];
    if(self){
        self.imageName = imageName;
        
    }
    return self;
}

- (void) setImageName:(NSString *)imageName{
    if(_imageName != imageName){
        _imageName = [imageName copy];
    }
    [self loadThemeImageView];
}

- (void)loadThemeImageView{
    UIImage *image = [[ThemeManager shareThemeManager] getThemeImage:_imageName];
    image = [image stretchableImageWithLeftCapWidth:leftCapLength topCapHeight:topCapLength];
    [self setImage:image];
    
}

@end
