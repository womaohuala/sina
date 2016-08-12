//
//  FriendshipdViewController.m
//  tracywb
//
//  Created by wangjl on 16/7/19.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "FriendshipdViewController.h"
#import "DataService.h"
#import "WeiboBaseUser.h"
#import "SVProgressHUD.h"

@interface FriendshipdViewController ()

@end

@implementation FriendshipdViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initViews];
}


#pragma mark - TableViewRefreshDeleage
- (void)pullDown:(UITableView *)object{
    
    NSLog(@"pullDown");
    [self _loadData:nil withNewCursor:_upCursor];
}

- (void)pullUp:(UITableView *)object{
    
    NSLog(@"pullUp");
    [self _loadData:_moreCursor withNewCursor:nil];
}


//加载数据以及初始化
- (void)_initViews{
    self.data = [[NSMutableArray alloc] init];
    self.tableView.eventDelegate = self;
    [self _loadData:nil withNewCursor:nil];
}



//加载数据
- (void)_loadData:(NSString *)moreCursor withNewCursor:(NSString *)newCursor{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        [dic setObject:userToken forKey:@"access_token"];
    }
    [dic setValue:@"14" forKey:@"count"];
    [dic setValue:self.screenName forKey:@"uid"];
    if(moreCursor!=nil){
        [dic setValue:moreCursor forKey:@"cursor"];
    }
    if(newCursor!=nil){
        [dic setValue:newCursor forKey:@"cursor"];
    }
    __block FriendshipdViewController *this = self;
    [DataService requestWithUrl:kGetFocusFriends withParams:dic withMethod:kGetMethod finishBlock:^(NSDictionary *dic){
        NSMutableArray *newData = [[NSMutableArray alloc] init];
        NSMutableArray *users = [dic valueForKey:@"users"];
        self.moreCursor = [dic valueForKey:@"next_cursor"];
     
        self.upCursor = [dic valueForKey:@"previous_cursor"];
        for (NSDictionary *tmp in users) {
            WeiboBaseUser *model = [[WeiboBaseUser alloc] initWithDataDic:tmp];
            [newData addObject:model];
        }
        
        //首次加载
        if((moreCursor==nil)&&(newCursor==nil)){
            this.allData = newData;
            //上拉加载
        }else if((moreCursor!=nil)&&(newCursor==nil)){
            [this.allData addObjectsFromArray:newData];
            //下拉加载
        }else{
            [newData addObjectsFromArray:this.allData];
            this.allData = newData;
            [self.tableView doneLoadingTableViewData];
        }
        /*每三个分为一个数组
         [a,b,c],
         [d,e,f],
        */
        //NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *tdArray ;
        [this.data removeAllObjects];
        for(int i=0;i<this.allData.count;i++){
            if(i%3==0){
                tdArray = [[NSMutableArray alloc] init];
                [this.data addObject:tdArray];
            }
            [tdArray addObject:[this.allData objectAtIndex:i]];
        }
        this.tableView.data = this.data;
        [this.tableView reloadData];
        
        //SVProgressHUD.SVProgressHUDStyle = SVProgressHUDStyleLight;
    }];


}






@end
