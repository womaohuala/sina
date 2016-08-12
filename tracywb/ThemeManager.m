//
//  ThemeManager.m
//  tracywb
//
//  Created by jimmy on 16/6/25.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "ThemeManager.h"
#import "Contants.h"
static ThemeManager *singleton;

@implementation ThemeManager

//override
- (instancetype)init{
   self = [super init];
    if(self){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themePlist = [[NSDictionary alloc] initWithContentsOfFile:path];
        //初始化主题名称
        self.themeName = nil;
    }
    return self;
}

+ (ThemeManager *)shareThemeManager{
    if(singleton == nil){
        @synchronized (self) {
            singleton = [[ThemeManager alloc] init];
        }
    }
    return singleton;
}

- (void) setThemeName:(NSString *)themeName{
    if(_themeName != themeName){
        _themeName = [themeName copy];
    }
    //根据themename获取fontcolorplist
    NSString *path = [self getThemePath];
    NSString *plistPath = [path stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlist = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

//获取主题颜色
- (UIColor *)getThemeColor:(NSString *)colorName{
    if(colorName.length == 0){
        return nil;
    }
    NSString *colorStr = [_fontColorPlist objectForKey:colorName];
    NSArray *colors = [colorStr componentsSeparatedByString:@","];
    float r = [colors[0] floatValue];
    float g = [colors[1] floatValue];
    float b = [colors[2] floatValue];
    UIColor *color = Color(r, g, b, 1);
    return color;
    
}

//获取主题路径
- (NSString *) getThemePath{
    //如果主题名称为空，则取根路径下的图片
    if(self.themeName.length == 0){
        NSString *basePath = [[NSBundle mainBundle ] resourcePath];
        return basePath;
    }
    NSString *basePath = [[NSBundle mainBundle ] resourcePath];
    NSString *themePath = [self.themePlist valueForKey:_themeName];
    basePath = [basePath stringByAppendingPathComponent:themePath];
    return basePath;
}

- (UIImage *) getThemeImage:(NSString *)imageName{
    //如果图片名称为空则返回空
    if(imageName.length == 0){
        return nil;
    }
    NSString *themePath = [self getThemePath];
    themePath = [themePath stringByAppendingPathComponent:imageName];
    //imageNamed是从根路径下取，而imageWithContentsOfFile是在文件夹下面取
    UIImage *image = [UIImage imageWithContentsOfFile:themePath];
    return image;

}


//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (singleton == nil) {
            singleton = [super allocWithZone:zone];
        }
    }
    return singleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}



/*
- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;
}
*/


@end
