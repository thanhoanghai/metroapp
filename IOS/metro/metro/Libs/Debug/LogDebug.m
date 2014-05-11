//
//  LogDebug.m
//  MFSideMenuDemoStoryboard
//
//  Created by Than Hoang Hai on 3/9/14.
//  Copyright (c) 2014 Michael Frederick. All rights reserved.
//

#import "LogDebug.h"

#define DEBUG_LOG TRUE

@implementation LogDebug


+(void)logError:(NSString*)tag withContent:(NSString*)content
{
    if(DEBUG_LOG)
        NSLog(@"Debug=%@--%@",tag,content);
}



@end
