//
//  ThemeImageView.h
//  tracywb
//
//  Created by jimmy on 16/6/26.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView{

    

}
@property(nonatomic,assign)float leftCapLength;

@property(nonatomic,assign)float topCapLength;

@property(nonatomic,copy)NSString *imageName;



- (id)initWithImageName:(NSString *)imageName;



@end
