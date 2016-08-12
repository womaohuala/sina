//
//  RectButton.h
//  tracywb
//
//  Created by wangjl on 16/7/9.
//  Copyright © 2016年 yk. All rights reserved.
//

@interface RectButton : UIButton
{
    UILabel *_rectTitleLabel;
    UILabel *_subtitleLabel;
}

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subtitle;
@end
