//
//  WBFaceView.h
//  tracywb
//
//  Created by wangjl on 16/7/14.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kWBFaceViewWidth 42
#define kWBFaceViewHeight 43

typedef  void(^SelectBlock) (NSString *);


@interface WBFaceView : UIView{

    UIImageView *_magnifierView;


}

@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,retain)NSMutableArray *data;

@property(nonatomic,assign)NSInteger pageNumber;

@property(nonatomic,copy)SelectBlock block;





@end
