//
//  DetailViewController.m
//  tracywb
//
//  Created by wangjl on 16/7/6.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "CommentCell.h"
#import "CommentTableView.h"
#import "JSONKit.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}


- (void)viewDidLoad {

    [super viewDidLoad];

    [self _initView];
    [self _loadData];
}

//加载数据
- (void)_loadData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        NSLog(@"userToken:%@",userToken);
        [param setObject:userToken forKey:@"access_token"];
        [param setObject:[NSString stringWithFormat:@"%@",self.weiboModel.wbId]  forKey:@"id"];
        self.wbHttprequest = [WBHttpRequest requestWithURL:kGetCommentList
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
        NSArray *array = [dic objectForKey:@"comments"];
        for (NSDictionary *tmp in array) {
            CommentModel *model = [[CommentModel alloc] initWithDataDic:tmp];
            [newData addObject:model];
        }
        self.tableView.data = newData;
        self.tableView.dic = dic;
        [self.tableView reloadData];
    }
    
}


//初始化视图
- (void)_initView{
    
    self.tableView = [[CommentTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:self.tableView];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    self.userHeadImage.layer.cornerRadius = 5;
    self.userHeadImage.layer.masksToBounds = YES;
    [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:self.weiboModel.baseUser.avatar_large]];
    self.nickName.text = self.weiboModel.baseUser.screen_name;
    [headView addSubview:self.userHeaderView];
    headView.height += self.userHeaderView.height;
   
    
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(0, self.userHeaderView.bottom+10, kScreenWidth, 0)];
    _weiboView.weiboModel = _weiboModel;
    _weiboView.height = [WeiboView getWeiboViewHeight:_weiboModel isPost:NO isDetail:YES];
    _weiboView.isDetail = YES;
    headView.height += _weiboView.height + 10;
    [headView addSubview:_weiboView];
    self.tableView.tableHeaderView = headView;
    
}


#pragma mark - UITableViewDelegate
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
}
*/



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
