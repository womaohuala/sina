//
//  ThemeManager.h
//  tracywb
//
//  Created by jimmy on 16/6/25.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeNotification @"kThemeNotification"

@interface ThemeManager : NSObject

@property(nonatomic,copy)NSString *themeName;

@property(nonatomic,retain)NSDictionary *themePlist;

@property(nonatomic,retain)NSDictionary *fontColorPlist;
//获取单例themeManager
+ (ThemeManager *)shareThemeManager;

- (UIImage *) getThemeImage:(NSString *)imageName;

- (UIColor *) getThemeColor:(NSString *)colorName;



@end
