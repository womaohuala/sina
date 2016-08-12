//
//  ThemeLabel.h
//  tracywb
//
//  Created by jimmy on 16/6/26.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy)NSString *colorName;

- (id)initWithColorName:(NSString *)colorName;

@end
