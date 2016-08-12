//
//  WBFaceScrollView.h
//  tracywb
//
//  Created by wangjl on 16/7/16.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBFaceView.h"

@interface WBFaceScrollView : UIView<UIScrollViewDelegate>{
    
    WBFaceView *_faceView;
    UIScrollView *_faceScrollView;
    UIPageControl *_pageControl;
    

    

}

- (id)initWithSelectBlock:(SelectBlock)block;

@end
