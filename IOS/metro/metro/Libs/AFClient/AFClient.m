//
//  AFClient.m
//  metro
//
//  Created by Than Hoang Hai on 5/10/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import "AFClient.h"
#import "AFHTTPRequestOperationManager.h"

@implementation AFClient

+(NSString*)getLinkBranchMetro
{
    return [NSString stringWithFormat:@"%s%s", PROVIDER, BRANCH];
}
+(NSString*)getLinkNganh
{
    return [NSString stringWithFormat:@"%s%s", PROVIDER, NGANH];
}



+(void)getLink:(NSString *)link
        success:(void (^)(id))successBlock
        failure:(void (^)(NSString *))failureBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(successBlock){
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failureBlock){
            failureBlock(@"Error with Search");
        }
    }];
    
}


@end
