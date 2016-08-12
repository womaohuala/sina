//
//  UIView+Addition.m
//  tracywb
//
//  Created by wangjl on 16/7/9.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (UIViewController *)viewController{
    UIResponder *responder = [self nextResponder];
    do{
        if([responder isKindOfClass:[UIViewController class]]){
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
        
    }while(responder != nil);
    
    return nil;
}


@end
