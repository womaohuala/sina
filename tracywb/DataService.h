//
//  DataService.h
//  tracywb
//
//  Created by wangjl on 16/7/17.
//  Copyright © 2016年 yk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

typedef void(^RequestFinishBlock) (id);

@interface DataService : NSObject

+ (ASIFormDataRequest *)requestWithUrl:(NSString *)url withParams:(NSDictionary *)params withMethod:(NSString *)method finishBlock:(RequestFinishBlock)block;

@end
