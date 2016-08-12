//
//  ThemeLabel.m
//  tracywb
//
//  Created by jimmy on 16/6/26.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"
#import "Contants.h"

@implementation ThemeLabel

//override
- (void)setColorName:(NSString *)colorName{
    if(_colorName != colorName){
        _colorName = [colorName copy];
    }
    [self setThemeColor];
    
}

//override
- (id)init{
    self = [super init];
    if(self){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeNotification object:nil];
        
    }
    return self;
    
    
}

//注销时将通知销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeNotification object:nil];
}

- (void) setThemeColor {
    UIColor *color = [[ThemeManager shareThemeManager] getThemeColor:_colorName];
    self.textColor = color;
    
}

//通知
- (void)themeNotification:(NSNotification *)notification{
    [self setThemeColor];

}

- (id)initWithColorName:(NSString *)colorName{
    self = [self init];
    if(self){
        self.colorName = colorName;
    }
    return self;
}



@end
