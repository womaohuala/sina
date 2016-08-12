//
//  UIFactory.h
//  tracywb
//
//  Created by jimmy on 16/6/26.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"


@interface UIFactory : NSObject


- (ThemeButton *) createButtonWithImageName:(NSString *) imageName withHighlightImageName:(NSString *)highlightImageName;

- (ThemeButton *) createButtonWithBackgroundImageName:(NSString *) backgroundImageName withBackgroundHighlightImageName:(NSString *)backgroundHighlightImageName;

- (ThemeButton *) createNavigationButton:(CGRect)rect title:(NSString *)title target:(id) target action:(SEL)action;

- (ThemeImageView *) createImageView:(NSString *)imageName;

- (ThemeLabel *) createThemeLable:(NSString *)colorName;

@end
