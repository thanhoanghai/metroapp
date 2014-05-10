//
//  MTViewController.m
//  metro
//
//  Created by Than Hoang Hai on 5/7/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import "MTViewController.h"
#import "MTMainController.h"

@interface MTViewController ()

@end

@implementation MTViewController

@synthesize imgLogo;
@synthesize viewContent;
@synthesize loading;
@synthesize viewDisconect;
@synthesize bntChon;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    viewContent.hidden = YES;
    viewDisconect.hidden = YES;
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

#pragma mark COUNT_TIME_RUN_LOGO
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
                             [self showContent];
                             //[self showDisconect];
                         }];
    }
}

#pragma mark SHOW_HIDE_CONTENT

-(void)showContent
{
    loading.hidden = YES;
    viewContent.hidden = NO;
}
-(void)showDisconect
{
    loading.hidden = YES;
    viewDisconect.hidden = NO;
}

#pragma mark PUSH_TO_NEW_CONTROLLER
-(void)gotoMainController
{
    [self performSegueWithIdentifier:@"goto-main-controller" sender:self.bntChon];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goto-main-controller"])
    {
        // Get reference to the destination view controller
        //MTMainController *vc = [segue destinationViewController];
        //vc.itemMovie = [arrayListMovie objectAtIndex:indexClickItem];
        // Pass any objects to the view controller here, like...
    }
}

- (IBAction)doActionBntChon:(id)sender {
    [self gotoMainController];
}
@end
