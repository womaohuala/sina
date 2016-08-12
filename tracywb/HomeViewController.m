//
//  HomeViewController.m
//  tracywb
//
//  Created by jimmy on 16/6/21.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboSDK.h"
#import "WeiboModel.h"
#import "JSONKit.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "WeiboModel.h"
#import "WeiboTableView.h"
#import "SVProgressHUD.h"
#import "UIViewExt.h"
#import "MainViewController.h"
#import "SVProgressHUD.h"
#import "WBFaceView.h"
#import "DetailViewController.h"
#import "WBFaceScrollView.h"
#import <AudioToolbox/AudioToolbox.h>


@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize wbHttprequest;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"首页";
    }
    return self;
}

/*
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [[NSMutableArray alloc] init];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"绑定" style:UIBarButtonItemStyleBordered target:self action:@selector(bindWB:)];
    rightButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"解绑" style:UIBarButtonItemStyleBordered target:self action:@selector(unbund:)];
    leftButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.tableView = [[WeiboTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-50);
    self.tableView.eventDelegate = self;
    self.tableView.hidden = YES;
    [self.view addSubview:self.tableView];
    
    [self _loadWBData];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
   
    
}





#pragma mark -
- (void)pullDown:(UITableView *)object{
    NSLog(@"pullDown");
    [self _loadMoreNewWBData];
    

}

- (void)pullUp:(UITableView *)object{

    NSLog(@"pullUp");
    [self _pullUploadMoreNewWBData];
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didSelectRowAtIndexPath:%ld",indexPath.row);
    WeiboModel *model = [self.data objectAtIndex:indexPath.row];
    DetailViewController *detailCtrl = [[DetailViewController alloc] init];
    detailCtrl.weiboModel = model;
    [self.navigationController pushViewController:detailCtrl animated:YES];
    

}

//下拉列表加载更多新的微博
- (void)_loadMoreNewWBData{
    if((self.data != nil)&&(self.data.count > 0)){
        WeiboModel *model = [self.data objectAtIndex:0];
        self.lastWeiboId = model.wbId;
    }else{
        self.lastWeiboId = @"0";
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    NSString *token = [data valueForKey:kUserToken];
    NSString *userId = [data valueForKey:kUserId];
    NSLog(@"token:%@,userId:%@",token,userId);
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        NSLog(@"userToken:%@",userToken);
        [param setObject:userToken forKey:@"access_token"];
        [param setValue:[NSString stringWithFormat:@"%@",self.lastWeiboId] forKey:@"since_id"];
        self.wbHttprequest = [WBHttpRequest requestWithURL:kGetFocusWBList
                                                httpMethod:kGetMethod
                                                    params:param
                                                  delegate:self withTag:@"2"];
    
    }else{
        [self.tableView doneLoadingTableViewData];
    }
    
}

//上拉列表加载更多新的微博
- (void)_pullUploadMoreNewWBData{
    if((self.data != nil)&&(self.data.count > 0)){
        WeiboModel *model = [self.data lastObject];
        self.firstWeiboId = model.wbId;
    }else{
        self.firstWeiboId = @"0";
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    NSString *token = [data valueForKey:kUserToken];
    NSString *userId = [data valueForKey:kUserId];
    NSLog(@"token:%@,userId:%@",token,userId);
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        NSLog(@"userToken:%@",userToken);
        [param setObject:userToken forKey:@"access_token"];
        [param setValue:[NSString stringWithFormat:@"%@",self.firstWeiboId] forKey:@"max_id"];
        self.wbHttprequest = [WBHttpRequest requestWithURL:kGetFocusWBList
                                                httpMethod:kGetMethod
                                                    params:param
                                                  delegate:self withTag:@"3"];
        
    }else{
        [self.tableView reloadData];
    }
    
    
    
}

//自动刷新列表
- (void)autorefreshWeibo{
    //下拉
    [self.tableView autoRefreshData];
    //取数据
    [self _loadMoreNewWBData];
}

//加载当前登陆用户关注的微博列表
- (void)_loadWBData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"20" forKey:@"count"];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    NSString *token = [data valueForKey:kUserToken];
    NSString *userId = [data valueForKey:kUserId];
    NSLog(@"token:%@,userId:%@",token,userId);
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        NSLog(@"userToken:%@",userToken);
        [param setObject:userToken forKey:@"access_token"];
        self.wbHttprequest = [WBHttpRequest requestWithURL:kGetFocusWBList
                                                httpMethod:kGetMethod
                                                    params:param
                                                  delegate:self withTag:@"1"];
    }
    
}

#pragma mark - WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)erro{
    [self.tableView doneLoadingTableViewData];
    NSLog(@"failerror");
   
}


- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result:%@",result);
    NSString *tag = request.tag;
    NSDictionary *dic = [result objectFromJSONString];
    if(tag != nil){
        NSMutableArray *newData = [[NSMutableArray alloc] init];
        NSArray *array = [dic objectForKey:@"statuses"];
        for (NSDictionary *tmp in array) {
            WeiboModel *model = [[WeiboModel alloc] initWithDataDic:tmp];
            [newData addObject:model];
        }
        //首次加载
        if([tag isEqualToString:@"1"]){
            self.tableView.data = newData;
            self.data = newData;
            [self.tableView reloadData];
            self.tableView.hidden = NO;
            [SVProgressHUD dismiss];
        //下拉刷新
        }else if([tag isEqualToString:@"2"]){
            long count = [newData count];
            if(count>0){
                [newData addObjectsFromArray:self.data];
                self.tableView.data = newData;
                self.data = newData;
                [self.tableView reloadData];
                //[SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"您有%ld条新微博",count]];
                [self _showNewWeiboNumber:[array count]];
                
            }
            [self.tableView doneLoadingTableViewData];
            
        }else if([tag isEqualToString:@"3"]){
            long count = [newData count];
            if(count>0){
                //[newData addObjectsFromArray:self.data];
                if(newData.count>0){
                    [newData removeObjectAtIndex:0];
                }
                [self.data addObjectsFromArray:newData];
                self.tableView.data = self.data;
                [self.tableView reloadData];
                
                
            }else {
                [self.tableView reloadData];
            }
        
        }
    }
    
    
    
}

//横条显示最新的微博数量
- (void)_showNewWeiboNumber:(long) count{
    if(_barView == nil){
        _barView = [[UIFactory alloc] createImageView:@"timeline_new_status_background.png"];
        UIImage *image = _barView.image;
        image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        _barView.image = image;
        _barView.topCapLength = 5;
        _barView.leftCapLength = 5;
        _barView.frame = CGRectMake(5, -40, kScreenWidth-10, 40);
        [self.view addSubview:_barView];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 201602;
        label.font = [UIFont systemFontOfSize:14.0f];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"您有%ld条新的微博",count];
        label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        
        label.origin = CGPointMake((_barView.width-label.width)/2, (_barView.height-label.height)/2);
        [_barView addSubview:label];
        
    }
    
    
    
    [UIView animateWithDuration:0.6 animations:^{
        _barView.top = 5;
        UILabel *label = [_barView viewWithTag:201602];
        label.text = [NSString stringWithFormat:@"您有%ld条新的微博",count];
    } completion:^(BOOL finished) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:0.6];
        [UIView setAnimationDuration:3];
        _barView.top = -40;
        [UIView commitAnimations];
        
    }];
    
    
    //加载提示音
    NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
    AudioServicesPlaySystemSound(soundId);
    
    MainViewController *mainCtrl = (MainViewController *)self.tabBarController;
    [mainCtrl showBadge:NO];
}



#pragma mark - actions
- (void)bindWB:(UIBarButtonItem *)item {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"HomeViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)unbund:(UIBarButtonItem *)item {
    
}

//home首页消失时显示时开启ddmenu的左滑和右滑
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.appDelegate.ddMenu setEnableGesture:YES];
}

//home首页消失时关闭ddmenu的左滑和右滑
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.appDelegate.ddMenu setEnableGesture:NO];
}
@end
