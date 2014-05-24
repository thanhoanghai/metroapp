//
//  MTViewController.m
//  metro
//
//  Created by Than Hoang Hai on 5/7/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import "MTViewController.h"
#import "MTMainController.h"
#import "AFClient.h"
#import "DCKeyValueObjectMapping.h"
#import "DCParserConfiguration.h"
#import "DCArrayMapping.h"
#import "NganhObject.h"
#import "NganhListObject.h"
#import "BranchObject.h"
#import "NganhCell.h"
#import "LogDebug.h"

@interface MTViewController ()

@end

@implementation MTViewController

@synthesize imgLogo;
@synthesize viewContent;
@synthesize lbBranchMetro;
@synthesize lbNganh;
@synthesize loading;
@synthesize viewDisconect;
@synthesize bntChon;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Dialog Branch Metro
    indexDialog = 0;
    indexBranchMetro = 0;
    indexNganh = 0;
    
    viewContent.hidden = YES;
    
    if(dialogView==nil)
    {
        dialogView = [[DialogController alloc] initWithNibName:@"DialogController" bundle:nil];
        [dialogView setDelegate:self];
    }
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

#pragma mark DELEGATE_DIALOG
-(void)delegateDongDialog:(NSString *)idItem withName:(NSString *)name withIndex:(int)index
{
    if(idItem!=nil && idItem.length>0)
    {
        if(indexDialog==0)
        {
            [lbBranchMetro setTitle:name forState:UIControlStateNormal];
            indexBranchMetro = index;
        }else{
            [lbNganh setTitle:name forState:UIControlStateNormal];
            indexNganh = index;
        }
    }    
    [dialogView hideDialogWithAnimation];
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
                             [self getDataBranchMetro];
                         }];
    }
}

#pragma mark SHOW_HIDE_CONTENT

-(void)showContent
{
    loading.hidden = YES;
    [loading stopAnimating];
    viewContent.hidden = NO;
}

-(void)showDisconectView
{
    loading.hidden = YES;
    [self.view addSubview:viewDisconect];
    viewDisconect.center = self.view.center;
}


#pragma mark GET_API_LOAD_DATA_FROM_SERVER
-(void)getDataBranchMetro
{
    NSString *link = [AFClient getLinkBranchMetro];
    [AFClient getLink:link success:^(id result)
    {
        [LogDebug logError:@"Debug data Branch Metro load = " withContent:@"Succedd"];
        DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:[BranchObject class] forAttribute:@"data" onClass:[NganhListObject class]] ;
        
        DCParserConfiguration *config = [DCParserConfiguration configuration];
        [config addArrayMapper:mapper];
        
        DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[NganhListObject class] andConfiguration:config];
         metroListObject = [parser parseDictionary:result];
        
        [self setNameLabelBranchMetro];
        ///continous get data nganh
        [self getDataNganh];
    } failure:^(NSString *err){
        [self showDisconectView];
        [LogDebug logError:@"Debug data Branch Metro load = " withContent:@"faith"];
    }];
}

-(void)setNameLabelBranchMetro
{
    if(metroListObject!=NULL && [metroListObject.data count] > indexBranchMetro)
    {
        BranchObject *item = [metroListObject.data objectAtIndex:indexBranchMetro];
        [lbBranchMetro setTitle:item.name forState:UIControlStateNormal];
    }
}

-(void)getDataNganh
{
    NSString *link = [AFClient getLinkNganh];
    [AFClient getLink:link success:^(id result)
     {
        [LogDebug logError:@"Debug data Nganh Metro load = " withContent:@"Succedd"];
        DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:[NganhObject class] forAttribute:@"data" onClass:[NganhListObject class]] ;
         
         DCParserConfiguration *config = [DCParserConfiguration configuration];
         [config addArrayMapper:mapper];
         
         DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[NganhListObject class] andConfiguration:config];
         nganhListObject = [parser parseDictionary:result];
         
         if(dialogView!=NULL)
         {
             [dialogView setDataBranchMetro:metroListObject withNganhlist:nganhListObject];
         }
         
         [self setNameLabelNganh];
         
         [self showContent];
     } failure:^(NSString *err){
         [self showDisconectView];
         [LogDebug logError:@"Debug data Nganh Metro load = " withContent:@"faith"];
     }];
}
-(void)setNameLabelNganh
{
    if(nganhListObject!=NULL && [nganhListObject.data count] > indexNganh)
    {
        NganhObject *item = [nganhListObject.data objectAtIndex:indexNganh];
        [lbNganh setTitle:item.name forState:UIControlStateNormal];
    }
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
        MTMainController *vc = [segue destinationViewController];
        [vc setIndexBranchMetro:indexBranchMetro withIndexNganh:indexNganh];
        [vc setDataBranchMetro:metroListObject withNganhlist:nganhListObject];

    }
}

- (IBAction)doActionBntChon:(id)sender {
    [self gotoMainController];
}

- (IBAction)doActionBntBranchMetro:(id)sender {
    indexDialog = 0;
    [dialogView setIndexDialog:indexDialog];
    [dialogView showDialogWithAnimation:self.view];
}

- (IBAction)doActionBntNganh:(id)sender {
    indexDialog= 1;
    [dialogView setIndexDialog:indexDialog];
    [dialogView showDialogWithAnimation:self.view];
}

- (IBAction)doActionBntDisconnet:(id)sender {
    [viewDisconect removeFromSuperview];
    loading.hidden = NO;
    [loading startAnimating];
    [self getDataBranchMetro];
}

@end
