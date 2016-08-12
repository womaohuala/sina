//
//  DataService.m
//  tracywb
//
//  Created by wangjl on 16/7/17.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "DataService.h"
#import "JSONKit.h"

@implementation DataService

+ (ASIFormDataRequest *)requestWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params withMethod:(NSString *)method finishBlock:(RequestFinishBlock)block{
    NSMutableDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:kWBData];
    if(data != nil){
        NSString *userToken = [data objectForKey:kUserToken];
        urlStr = [urlStr stringByAppendingFormat:@"?access_token=%@",userToken,nil];
    }
    NSComparisonResult result = [method caseInsensitiveCompare:@"get"];
    //get方式
    NSArray *array = [params allKeys];
    if(result == NSOrderedSame){
        NSMutableString *tmp = [[NSMutableString alloc] init];
        for(int i=0;i<array.count;i++){
            id key = [array objectAtIndex:i];
            id data = [params valueForKey:key];
            [tmp appendFormat:@"%@=%@",key,data];
            if(i != (array.count-1)){
                [tmp appendFormat:@"%@",@"&"];
            }
        }
        urlStr = [urlStr stringByAppendingFormat:@"&%@",tmp];
    }
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [request setRequestMethod:method];
    [request setTimeOutSeconds:60];
    result = [method caseInsensitiveCompare:@"post"];
    //post方式
    if(result == NSOrderedSame){
        for(int i=0;i<array.count;i++){
            id key = [array objectAtIndex:i];
            id data = [params valueForKey:key];
            if([data isKindOfClass:[NSData class]]){
                [request addData:data forKey:key];
            }else {
                [request addPostValue:data forKey:key];
            }
        }
        
    }
    __block ASIFormDataRequest *this = request;
    [request setValidatesSecureCertificate:NO];
    [request setCompletionBlock:^{
        NSData *responseData = [this responseData];
        NSString *str = [this responseString];
        NSLog(@"str:%@",str);
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        id result;
        if(version>5.0){
            result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        }else{
            result = [responseData objectFromJSONData];
        }
        if(result != nil){
            block(result);
        }
        
    }];
    [request setFailedBlock:^{
        NSError *error= this.error;
        NSLog(@"error:%@",error);
    }];
    [request startAsynchronous];
    return request;

}

@end
