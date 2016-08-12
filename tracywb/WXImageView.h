//
//  WXImageView.h
//  tracywb
//
//  Created by wangjl on 16/7/11.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageBlock)(void);

@interface WXImageView : UIImageView


@property(nonatomic,copy)ImageBlock touchImage;

@end
