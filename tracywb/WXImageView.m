//
//  WXImageView.m
//  tracywb
//
//  Created by wangjl on 16/7/11.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WXImageView.h"

@implementation WXImageView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouch)];
        [self addGestureRecognizer:gesture];
        
    }
    return self;

}

- (void)imageTouch{
    if(self.touchImage){
        _touchImage();
    }
}




@end
