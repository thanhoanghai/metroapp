//
//  AFClient.h
//  metro
//
//  Created by Than Hoang Hai on 5/10/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFClient : NSObject

+(NSString*)getLlinkProduct:(int)page withPageSize:(int)size withMetroID:(NSString *)metroId withNganhID:(NSString*)nganhID;
+(NSString*)getLinkBranchMetro;
+(NSString*)getLinkNganh;


+(void)getLink:(NSString *)link
        success:(void (^)(id))successBlock
        failure:(void (^)(NSString *))failureBlock;

@end
