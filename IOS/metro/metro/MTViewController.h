//
//  MTViewController.h
//  metro
//
//  Created by Than Hoang Hai on 5/7/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTViewController : UIViewController
{
    NSTimer *nsTimerUp;
    int countTime;
}


@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
