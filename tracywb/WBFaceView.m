//
//  WBFaceView.m
//  tracywb
//
//  Created by wangjl on 16/7/14.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WBFaceView.h"
#import "UIViewExt.h"


@implementation WBFaceView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self _initData];
    }
    return self;
}

//初始化数据
- (void)_initData{
    self.backgroundColor = [UIColor clearColor];
    self.data = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tmp;
    for(int i=0;i<array.count;i++){
        NSDictionary *dic = [array objectAtIndex:i];
        if(i%28 == 0){
            tmp = [[NSMutableArray alloc] init];
            [self.data addObject:tmp];
        }
        [tmp addObject:dic];
        
    }
    self.width = self.data.count*kScreenWidth;
    self.height = 220;
    self.pageNumber = self.data.count;
    _magnifierView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 70, 64, 92)];
    _magnifierView.hidden = YES;
    _magnifierView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier.png"];
    _magnifierView.backgroundColor = [UIColor clearColor];
    [self addSubview:_magnifierView];
    
    
    
}

//override
- (void)drawRect:(CGRect)rect{
    for(int i=0;i<self.data.count;i++){
        NSMutableArray *tmp = [self.data objectAtIndex:i];
        for(int j=0;j<tmp.count;j++){
            NSDictionary *dic = [tmp objectAtIndex:j];
            NSString *name = [dic valueForKey:@"png"];
            UIImage *image = [UIImage imageNamed:name];
            int row = j/7;
            int col = j%7;
            CGRect rect = CGRectMake(i*kScreenWidth+col*kWBFaceViewWidth+20, row*kWBFaceViewHeight+30, 30, 30);
            [image drawInRect:rect];
            
        }
        
    }
    

}

//计算触摸点在数组中的数值
- (void)_calculateIndex:(CGPoint)point{
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    int page = x/kScreenWidth;
    int row = (y-10)/kWBFaceViewHeight;
    int column = (x-page*kScreenWidth-20)/kWBFaceViewWidth;
    if(row>3){
        row = 3;
    }
    if(row<0){
        row = 0;
    }
    if(column>6){
        column = 6;
    }
    if(column<0){
        column = 0;
    }
    
    NSArray *array = [self.data objectAtIndex:page];
    int index = row*7+column;
    //判断是否超出数组范围，存在视图上图像没有排满的情况
    if((index+1)<=array.count){
        NSDictionary *dic = [array objectAtIndex:index];
        NSString *png = [dic valueForKey:@"png"];
        NSString *name = [dic valueForKey:@"chs"];
        NSLog(@"name:%@,png:%@",name,png);
        
        //图片名称不相等时才替换图片
        if(![name isEqualToString:self.imageName]){
            UIImage *image = [UIImage imageNamed:png];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
            imageView.backgroundColor = [UIColor clearColor];
            imageView.image = image;
            self.imageName = name;
            
            [_magnifierView addSubview:imageView];
            
            _magnifierView.left = page*kScreenWidth + column*kWBFaceViewWidth;
            _magnifierView.bottom = (row+1)*kWBFaceViewHeight;
            _magnifierView.hidden = NO;
        }
        
        
    }
    
}


//override
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    //获取点击该视图的点
    CGPoint point = [touch locationInView:self];//开始触摸
    [self _calculateIndex:point];

}

//override
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    //获取点击该视图的点
    CGPoint point = [touch locationInView:self];//开始触摸
    [self _calculateIndex:point];
    if([[self superview] isKindOfClass:[UIScrollView class]]){
        UIScrollView *scroll = (UIScrollView *)[self superview];
        scroll.scrollEnabled = NO;
    }
    

}

//override
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _magnifierView.hidden = YES;
    if([[self superview] isKindOfClass:[UIScrollView class]]){
        UIScrollView *scroll = (UIScrollView *)[self superview];
        scroll.scrollEnabled = YES;
    }
    if(self.block != nil){
        _block(self.imageName);
    }

}


@end
