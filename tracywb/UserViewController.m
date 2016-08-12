//
//  UserViewController.m
//  tracywb
//
//  Created by wangjl on 16/7/9.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoView.h"
#import "WBHttpRequest.h"
#import "JSONKit.h"
#import "WeiboModel.h"
#import "UIFactory.h"
#import "HomeViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
        
    }
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"用户信息";
    self.userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    
    
    UIButton *button = [[UIFactory alloc] createButtonWithBackgroundImageName:@"tabbar_home" withBackgroundHighlightImageName:@"tabbar_home_highlighted"];
    button.frame = CGRectMake(kScreenWidth-50, 10, 20, 15);
    [button addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    
    
    [self _loadUserData];
    
    [self _loadWeiboData];
}

//返回首页
- (void)goHome{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


//加载用户信息
- (void)_loadUserData{
    if((self.nickName == nil)||(self.nickName.length<=0)){
        return;
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        NSLog(@"userToken:%@",userToken);
        [param setObject:userToken forKey:@"access_token"];
        [param setValue:_nickName forKey:@"screen_name"];
        self.wbHttprequest = [WBHttpRequest requestWithURL:kShowUser
                                                httpMethod: kGetMethod
                                                    params:param
                                                  delegate:self withTag:@"1"];
        
    }
    
}


//加载微博数据
- (void)_loadWeiboData{
    if((self.nickName == nil)||(self.nickName.length<=0)){
        return;
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        NSLog(@"userToken:%@",userToken);
        [param setObject:userToken forKey:@"access_token"];
        [param setValue:_nickName forKey:@"screen_name"];
        self.wbHttprequest = [WBHttpRequest requestWithURL:kGetFocusWBList
                                                httpMethod: kGetMethod
                                                    params:param
                                                  delegate:self withTag:@"2"];
        
    }

    

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
        WeiboBaseUser *user = [[WeiboBaseUser alloc] initWithDataDic:dic];
        //首次加载
        if([tag isEqualToString:@"1"]){
            self.userInfoView.user = user;
            self.tableView.tableHeaderView = self.userInfoView;
            
        }else if([tag isEqualToString:@"2"]){
            NSMutableArray *weiboDics = [dic valueForKey:@"statuses"];
            NSMutableArray *weibos = [[NSMutableArray alloc] init];
            for(int i = 0;i<weiboDics.count;i++){
                WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:[weiboDics objectAtIndex:i]];
                [weibos addObject:weibo];
            }
            self.tableView.data = weibos;
            [self.tableView reloadData];
        }
    }
}

@end
