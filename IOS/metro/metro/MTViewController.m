//
//  MTViewController.m
//  metro
//
//  Created by Than Hoang Hai on 5/7/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import "MTViewController.h"

@interface MTViewController ()

@end

@implementation MTViewController

@synthesize imgLogo;
@synthesize loading;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    countTime = 0;
    [super viewDidAppear:animated];
    [self runAnimation];
    [loading startAnimating];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)runAnimation
{
    if(nsTimerUp == nil){
        nsTimerUp = [NSTimer scheduledTimerWithTimeInterval: 1 target:self selector:@selector(countUpH) userInfo:nil repeats: YES];
    }
}
- (void) countUpH{
    if(countTime < 1)
    {
        countTime ++ ;
    }else
        [self stopTimer];
}
-(void)stopTimer
{
    if(nsTimerUp != nil)
    {
        [nsTimerUp invalidate];
        nsTimerUp = nil;
        [UIView animateWithDuration:0.35
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [imgLogo setFrame:CGRectMake(imgLogo.frame.origin.x, 30, imgLogo.frame.size.width, imgLogo.frame.size.height)];
                         }
                         completion:^(BOOL finished){
                             [loading stopAnimating];
                             loading.hidden = YES;
                         }];
    }
}

@end
