//
//  ThemeButton.h
//  tracywb
//
//  Created by jimmy on 16/6/25.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,copy)NSString *highlightImageName;

@property(nonatomic,copy)NSString *backgroundImageName;

@property(nonatomic,copy)NSString *backgroundHighlightImageName;

@property(nonatomic,assign)NSInteger leftTapWidth;

@property(nonatomic,assign)NSInteger topTapWidth;


- (id) initWithImageName:(NSString *) imageName withHighlightImageName:(NSString *)highlightImageName;

- (id) initWithBackgroundImageName:(NSString *) backgroundImageName withBackgroundHighlightImageName:(NSString *)backgroundHighlightImageName;


@end
