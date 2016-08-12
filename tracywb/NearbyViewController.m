//
//  NearbyViewController.m
//  tracywb
//
//  Created by wangjl on 16/7/12.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "NearbyViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "JSONKit.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "ThemeButton.h"
#import "UIFactory.h"
#import "DataService.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
    
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.hidden = YES;
    [SVProgressHUD setStatus:@"加载数据中"];
    self.title = @"我在这里";
    self.manager = [[CLLocationManager alloc] init];
    self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.manager.delegate = self;
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startMonitoringSignificantLocationChanges];
    [self.manager startUpdatingLocation];
    
    ThemeButton *button = [[UIFactory alloc] createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(goBackHome)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationItem.leftBarButtonItem = item;
    
    
}

#pragma mark - actions
- (void)goBackHome{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    [manager stopUpdatingLocation];
    if(self.data == nil){
        float longitude = newLocation.coordinate.longitude;
        float latitude = newLocation.coordinate.latitude;
        NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
        NSString *latitudeStr = [NSString stringWithFormat:@"%f",latitude];
        [self _getNearbyLocation:longitudeStr latitude:latitudeStr];
        
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [manager stopUpdatingLocation];
    
    if (self.data == nil) {
        CLLocation *newLocation = [locations objectAtIndex:0];
        float longitude = newLocation.coordinate.longitude;
        float latitude = newLocation.coordinate.latitude;
        NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
        NSString *latitudeStr = [NSString stringWithFormat:@"%f",latitude];
        [self _getNearbyLocation:longitudeStr latitude:latitudeStr];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager            didFinishDeferredUpdatesWithError:(NSError *)error{
    NSLog(@"didFinishDeferredUpdatesWithError");

}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}


//获取周边区域
- (void)_getNearbyLocation:(NSString *)longitude latitude:(NSString *)latitude{
    if((longitude == nil)||(longitude == nil)){
        return ;
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    if(data!=nil){
        NSString *userToken = [data objectForKey:kUserToken];
        NSLog(@"userToken:%@",userToken);
        [param setObject:userToken forKey:@"access_token"];
        [param setValue:latitude forKey:@"lat"];
        [param setValue:longitude forKey:@"long"];
        /*
        self.wbHttprequest = [WBHttpRequest requestWithURL:kGetNearByLocation
                                                httpMethod:kGetMethod
                                                    params:param
                                                  delegate:self withTag:@"1"];
        */
        [DataService requestWithUrl:kGetNearByLocation withParams:param withMethod:kGetMethod finishBlock:^(NSDictionary *dic) {
            NSArray *array = [dic objectForKey:@"pois"];
            self.tableView.hidden = NO;
            self.data = array;
            [self.tableView reloadData];
            
        }];
    }
    
}

#pragma mark - WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)erro{
    NSLog(@"failerror");
}


- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result:%@",result);
    NSString *tag = request.tag;
    [SVProgressHUD dismiss];
    NSDictionary *dic = [result objectFromJSONString];
    if(tag != nil){
        NSArray *array = [dic objectForKey:@"pois"];
        self.tableView.hidden = NO;
        self.data = array;
        [self.tableView reloadData];
        
    }
    
    
    
}



#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"locationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic valueForKey:@"title"];
    cell.detailTextLabel.text = [dic valueForKey:@"address"];
    [cell.imageView  sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"icon"]]];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
    self.selectBlock(dic);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
