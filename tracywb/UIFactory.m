//
//  UIFactory.m
//  tracywb
//
//  Created by jimmy on 16/6/26.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

- (ThemeButton *) createButtonWithImageName:(NSString *) imageName withHighlightImageName:(NSString *)highlightImageName{
    ThemeButton *button = [[ThemeButton alloc] initWithImageName:imageName withHighlightImageName:highlightImageName];
    return button;
}

- (ThemeButton *) createButtonWithBackgroundImageName:(NSString *) backgroundImageName withBackgroundHighlightImageName:(NSString *)backgroundHighlightImageName{
    ThemeButton *button = [[ThemeButton alloc] initWithBackgroundImageName:backgroundImageName withBackgroundHighlightImageName:backgroundHighlightImageName];
    return button;
}

//创建主题imageview
- (ThemeImageView *) createImageView:(NSString *)imageName{
    ThemeImageView *view = [[ThemeImageView alloc] initWithImageName:imageName];
    return view;
}

- (ThemeButton *) createNavigationButton:(CGRect)rect title:(NSString *)title target:(id) target action:(SEL)action{

    ThemeButton *button = [[ThemeButton alloc] initWithBackgroundImageName:@"navigationbar_button_background.png" withBackgroundHighlightImageName:@"navigationbar_button_delete_background.png"];
    button.frame = rect;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.leftTapWidth = 3;
    return button;

}

//创建主题uilabel
- (ThemeLabel *) createThemeLable:(NSString *)colorName{
    if(colorName.length == 0){
        return nil;
    }
    ThemeLabel *label = [[ThemeLabel alloc] initWithColorName:colorName];
    return label;
    
}


@end
