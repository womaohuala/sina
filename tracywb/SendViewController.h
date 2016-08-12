//
//  SendViewController.h
//  tracywb
//
//  Created by wangjl on 16/7/11.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "BaseViewController.h"


@interface SendViewController : BaseViewController<WBHttpRequestDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>{

    
    UIButton *_imageButton;  //添加的图片按钮
    
    UIImageView *_imageView;  //缩放图
    
    
    UIView *_faceView;

}

@property (retain,nonatomic) UIImage *sendImage;

@property (assign,nonatomic)BOOL isFirstResponder;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIView *barView;

@property (nonatomic,retain)NSMutableArray *buttons;

@property (nonatomic,retain)WBHttpRequest *wbHttprequest;

@property (strong, nonatomic) IBOutlet UIImageView *locationBackgroundImage;

@property (strong, nonatomic) IBOutlet UILabel *locationText;

@property (strong, nonatomic) IBOutlet UIView *placeView;

@property (nonatomic,copy) NSString *longitude;

@property (nonatomic,copy) NSString *latitude;

@end
