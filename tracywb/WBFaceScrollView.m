//
//  WBFaceScrollView.m
//  tracywb
//
//  Created by wangjl on 16/7/16.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "WBFaceScrollView.h"
#import "UIViewExt.h"

@implementation WBFaceScrollView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self _initView];
    }
    return self;

}


- (id)initWithSelectBlock:(SelectBlock)selectBlock{
    self = [self initWithFrame:CGRectZero];
    if(self){
        _faceView.block = selectBlock;
    }
    return self;
}


//初始化视图
- (void)_initView{
    _faceView = [[WBFaceView alloc] initWithFrame:CGRectZero];
    _faceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _faceView.height)];
    _faceScrollView.clipsToBounds = NO;
    _faceScrollView.contentSize = CGSizeMake(_faceView.width, _faceView.height);
    _faceScrollView.backgroundColor = [UIColor clearColor];
    _faceScrollView.pagingEnabled = YES;
    _faceScrollView.showsHorizontalScrollIndicator = NO;
    _faceScrollView.showsVerticalScrollIndicator = NO;
    [_faceScrollView addSubview:_faceView];
    _faceScrollView.delegate = self;
    [self addSubview:_faceScrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _faceScrollView.bottom, 40,20)];
    _pageControl.numberOfPages = _faceView.pageNumber;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    self.width = _faceScrollView.width;
    self.height = _faceScrollView.height + _pageControl.height;
    
}


#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger pageNum = _faceScrollView.contentOffset.x/kScreenWidth;
    _pageControl.currentPage = pageNum;
    
}

- (void)drawRect:(CGRect)rect{
    
    [[UIImage imageNamed:@"emoticon_keyboard_background.png"] drawInRect:rect];
    
}

@end
