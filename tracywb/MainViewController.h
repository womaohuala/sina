//
//  MainViewController.h
//  tracywb
//
//  Created by jimmy on 16/6/21.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBHttpRequest.h"
#import "ThemeImageView.h"

@interface MainViewController : UITabBarController<WBHttpRequestDelegate,UINavigationControllerDelegate>{

    UIView *_tabBarView;
    
    UIImageView *_sliderView;
    
    ThemeImageView *_badgeImage;
    
    
}

@property(nonatomic,retain) WBHttpRequest *wbHttprequest;

@property(nonatomic,assign)float buttonWidth;

- (void)showBadge:(BOOL)show;





@end
