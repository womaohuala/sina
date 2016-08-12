//
//  SendViewController.m
//  tracywb
//
//  Created by wangjl on 16/7/11.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "SendViewController.h"
#import "UIFactory.h"
#import "UIViewExt.h"
#import "NSString+URLEncoding.h"
#import "JSONKit.h"
#import "WeiboUser.h"
#import "SVProgressHUD.h"
#import "NearbyViewController.h"
#import "BaseNavigationController.h"
#import "SVProgressHUD.h"
#import "WBFaceScrollView.h"
#import "DataService.h"
#import "ASIFormDataRequest.h"

@interface SendViewController ()

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"发送微博";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    ThemeButton *button = [[UIFactory alloc] createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(goBackHome)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
    ThemeButton *sendButton = [[UIFactory alloc] createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"发布" target:self action:@selector(sendAction)];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendItem;
    
    
    [self _initButtons];
    
}


- (void)_initButtons{
    
    [self.textView becomeFirstResponder];
   
    self.placeView.hidden = YES;
    self.buttons = [[NSMutableArray alloc] initWithCapacity:6];
    NSArray *imageNames = [NSArray arrayWithObjects:@"compose_locatebutton_background.png",
                           @"compose_camerabutton_background.png",
                           @"compose_trendbutton_background.png",
                           @"compose_mentionbutton_background.png",
                           @"compose_emoticonbutton_background.png",
                           @"compose_keyboardbutton_background.png",
                           nil];
    
    NSArray *imageHighted = [NSArray arrayWithObjects:@"compose_locatebutton_background_highlighted.png",
                             @"compose_camerabutton_background_highlighted.png",
                             @"compose_trendbutton_background_highlighted.png",
                             @"compose_mentionbutton_background_highlighted.png",
                             @"compose_emoticonbutton_background_highlighted.png",
                             @"compose_keyboardbutton_background_highlighted.png",
                             nil];
    for(int i=0;i<imageNames.count;i++){
        NSString *imageName = [imageNames objectAtIndex:i];
        NSString *highImageName = [imageHighted objectAtIndex:i];
        
        UIButton *button = [[UIFactory alloc]createButtonWithImageName:imageName withHighlightImageName:highImageName];
        [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        double tmp = kScreenWidth/5;
        button.frame = CGRectMake(20+tmp*i,25, 23, 19);
        button.tag = 10+i;
        if(i==5){
            button.hidden = YES;
            button.left -= tmp;
        }
        UIImage *image = [self.locationBackgroundImage.image stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        self.locationBackgroundImage.image = image;
        self.locationBackgroundImage.width = 200;
        self.locationText.width = 150;
        
        [_buttons addObject:button];
        [self.barView addSubview:button];
        _textView.delegate = self;
    }
    

}

#pragma mark - action 返回home主页
- (void)goBackHome{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchAction:(UIButton *)button{
    if(button.tag == 10){
        [self _touchLocation];
        
    
    }else if(button.tag == 11){
        [self _selectImage];
    
    }else if(button.tag == 12){
    
        
    }else if(button.tag == 13){
        
        
    }else if(button.tag == 14){
        [self _showFaceView];
        
    
    }else if(button.tag == 15){
        [self _showKeyBoard];
    
    }
    NSLog(@"button'tag is :%ld",button.tag);

}

//显示图像视图
- (void)_showFaceView{
    
    [_textView resignFirstResponder];
    
    if(_faceView == nil){
        //_faceView = [[WBFaceScrollView alloc] initWithFrame:CGRectZero];
        __block SendViewController *this = self;
        _faceView = [[WBFaceScrollView alloc] initWithSelectBlock:^(NSString *name) {
            NSLog(@"name:%@",name);
            NSString *text = this.textView.text;
            this.textView.text = [text stringByAppendingString:name];
            
        }];
        _faceView.left = 0;
        _faceView.top = kScreenHeight - 20 - 44 - _faceView.height;
        _faceView.transform = CGAffineTransformTranslate(_faceView.transform, 0, kScreenHeight - 20 - 44);
        [self.view addSubview:_faceView];
    }
    UIButton *button5 = [self.buttons objectAtIndex:4];
    button5.alpha = 1;
    UIButton *button6 = [self.buttons objectAtIndex:5];
    button6.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        _faceView.transform = CGAffineTransformIdentity;
        button5.alpha = 0;
        self.barView.bottom = kScreenHeight - 20 - 44 -_faceView.height;
        //_textView.bottom = self.barView.top;
        self.textView.height = self.barView.top;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            button6.hidden = NO;
            button6.alpha = 1;
        }];
        
    }];
    
}

//显示输入键盘
- (void)_showKeyBoard{
    [self.textView becomeFirstResponder];
    
    
    UIButton *button5 = [self.buttons objectAtIndex:4];
    button5.alpha = 0;
    UIButton *button6 = [self.buttons objectAtIndex:5];
    button6.alpha = 1;
    [UIView animateWithDuration:0.4 animations:^{
        _faceView.transform = CGAffineTransformTranslate(_faceView.transform, 0, kScreenHeight - 20 - 44);
        button6.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
           button5.alpha = 1;
        }];
        
    }];

    

}

//显示输入键盘
- (void)_becomeFirstResponder{
    UIButton *button5 = [self.buttons objectAtIndex:4];
    button5.alpha = 0;
    UIButton *button6 = [self.buttons objectAtIndex:5];
    button6.alpha = 1;
    [UIView animateWithDuration:0.4 animations:^{
        _faceView.transform = CGAffineTransformTranslate(_faceView.transform, 0, kScreenHeight - 20 - 44);
        button6.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            button5.alpha = 1;
        }];
        
    }];
    
    
    
}


//选择附近位置
- (void)_touchLocation{
    NearbyViewController *near = [[NearbyViewController alloc] init];
    // 因为弹出的效果有导航控制器，所以需要加到导航控制器上面来
    BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:near];
    near.selectBlock = ^(NSDictionary *dic){
        self.longitude = [dic valueForKey:@"lon"];
        self.latitude = [dic valueForKey:@"lat"];
        
        NSString *address = [dic valueForKey:@"address"];
        self.placeView.hidden = NO;
        self.locationText.text = address;
        UIButton *button = [_buttons objectAtIndex:0];
        button.selected = YES;
    
    };
    
    [self presentViewController:base animated:YES completion:nil];
    

}

- (void)_selectImage{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"选择图片", nil];
    sheet.delegate = self;
    [sheet showInView:self.view];
}

#pragma mark - UITextView delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self _becomeFirstResponder];
    return YES;
}


#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //照相
    if(buttonIndex == 0){
        if(![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
            [SVProgressHUD showWithStatus:@"没有摄像头"];
            return;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 1){
        
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    }
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

//发布微博
- (void)sendAction{
    [super showStatusTip:YES withTitle:@"发送中..."];
    [self _publishWeibo];

}

//发布微博
- (void)_publishWeibo{
    NSString *text = self.textView.text;
    if((text == nil)||(text.length<=0)){
        return;
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        [param setObject:userToken forKey:@"access_token"];
        
        [param setValue:text forKey:@"status"];
        [param setValue:self.latitude  forKey:@"lat"];
        [param setValue:self.longitude  forKey:@"long"];
        if(self.sendImage == nil){
            self.wbHttprequest = [WBHttpRequest requestWithURL:kSendMessage
                                                    httpMethod: kPostMethod
                                                        params:param
                                                      delegate:self withTag:@"1"];
            
        }else{
            NSData *data = UIImageJPEGRepresentation(self.sendImage, 0.3);
            [param setValue:data  forKey:@"pic"];
            /*
            self.wbHttprequest = [WBHttpRequest requestWithURL:kUploadMessage
                                                    httpMethod: kPostMethod
                                                        params:param
                                                      delegate:self withTag:@"1"];
            */
            ASIFormDataRequest *asiRequest = [DataService requestWithUrl:kUploadMessage withParams:param withMethod:kPostMethod finishBlock:^(NSDictionary *dic) {
                NSDictionary *tmp = [dic valueForKey:@"user"];
                WeiboUser *user = [[WeiboUser alloc] initWithDictionary:tmp];
                NSLog(@"user:%@",user);
                [super showStatusTip:NO withTitle:@"发送成功"];
                
            }];
        }
    }
    

}

#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.sendImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    if(_imageButton == nil){
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 30, 30)];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        _imageButton = button;
        [self.barView addSubview:_imageButton];
        [_imageButton addTarget:self action:@selector(_imageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_imageButton setImage:self.sendImage forState:UIControlStateNormal];
    
    UIButton *button1 = [self.buttons objectAtIndex:0];
    UIButton *button2 = [self.buttons objectAtIndex:1];
    [UIView animateWithDuration:2 animations:^{
        button1.transform = CGAffineTransformTranslate(button1.transform, 30, 0);
        button2.transform = CGAffineTransformTranslate(button2.transform, 10, 0);
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - actions 
- (void)_imageAction:(UIButton *)button{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        _imageView.image = self.sendImage;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_scaleImage)];
        [_imageView addGestureRecognizer:gesture];
    
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.tag = 2016102;
        deleteButton.frame = CGRectMake(kScreenWidth - 40, 30, 20, 30);
        [deleteButton setImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(_deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:deleteButton];
        deleteButton.hidden = YES;
    }
    
    [self.textView resignFirstResponder];
    
    //没有视图则添加
    if(![_imageView superview]){
        _imageView.frame = CGRectMake(5, kScreenHeight-240, 30, 30);
        [self.view.window addSubview:_imageView];
        [UIView animateWithDuration:0.4 animations:^{
            _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        } completion:^(BOOL finished) {
            UIButton *deleteButton = [_imageView viewWithTag:2016102];
            deleteButton.hidden = NO;
            [UIApplication sharedApplication].statusBarHidden = YES;
        }];
    }

}

//actions 缩小图片
- (void)_scaleImage{
    UIButton *deleteButton = [_imageView viewWithTag:2016102];
    deleteButton.hidden = YES;
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIView animateWithDuration:0.4 animations:^{
        _imageView.frame = CGRectMake(5, kScreenHeight-240, 30, 30);
        [_imageView removeFromSuperview];
    } completion:^(BOOL finished) {
        [self.textView becomeFirstResponder];
        
    }];

}


//删除图片
- (void)_deleteAction:(UIButton *)button{
    
    UIButton *deleteButton = [_imageView viewWithTag:2016102];
    deleteButton.hidden = YES;
    //[deleteButton removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        _imageView.frame = CGRectMake(5, kScreenHeight-240, 30, 30);
        [_imageView removeFromSuperview];
    } completion:^(BOOL finished) {
        self.sendImage = nil;
        [_imageButton removeFromSuperview];
        UIButton *button1 = [self.buttons objectAtIndex:0];
        UIButton *button2 = [self.buttons objectAtIndex:1];
        button1.transform = CGAffineTransformIdentity;
        button2.transform = CGAffineTransformIdentity;
        
    }];
    
}


#pragma mark - WBHttpRequest delegate
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)erro{
    NSLog(@"failerror");
}


- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result:%@",result);
    NSString *tag = request.tag;
    NSDictionary *dic = [result objectFromJSONString];
    if(tag != nil){
        NSDictionary *tmp = [dic valueForKey:@"user"];
        WeiboUser *user = [[WeiboUser alloc] initWithDictionary:tmp];
        NSLog(@"user:%@",user);
        [super showStatusTip:NO withTitle:@"发送成功"];
        
    }
}


- (void)showKeyBoard:(NSNotification *)notification{
    NSValue *value = [notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    float height = rect.size.height;
    self.barView.bottom = kScreenHeight - height - 20 - 49;
    self.textView.height = self.barView.top;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
