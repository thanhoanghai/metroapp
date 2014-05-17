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
@synthesize viewTable;
@synthesize tableView;
@synthesize lbTitleListTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Dialog Branch Metro
    indexDialog = 0;
    indexBranchMetro = 0;
    indexNganh = 0;
    
    viewContent.hidden = YES;
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

-(void)showViewTable:(int)index
{
    indexDialog = index;
    [self.view addSubview:viewTable];
    CGRect r = [viewTable frame];
    r.origin.y = self.view.frame.size.height - r.size.height;
    [viewTable setFrame:r];
    if(index == 0)
    {
        [lbTitleListTable setText:TRUNG_TAM_METRO];
    }else
        [lbTitleListTable setText:NGANH_HANG_KINH_DOANH];
    [tableView reloadData];
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

- (IBAction)doActionBntCloseTable:(id)sender {
    [viewTable removeFromSuperview];
}

- (IBAction)doActionBntBranchMetro:(id)sender {
    [self showViewTable:0];
}

- (IBAction)doActionBntNganh:(id)sender {
    [self showViewTable:1];
}

- (IBAction)doActionBntDisconnet:(id)sender {
    [viewDisconect removeFromSuperview];
    loading.hidden = NO;
    [loading startAnimating];
    [self getDataBranchMetro];
}

#pragma mark TABLE_VIEW_LIST_METRO
#pragma mark TABBLE_VIEW
- (NSInteger)tableView:(UITableView *)tableviewDialog numberOfRowsInSection:(NSInteger)sectionIndex
{
    if(indexDialog == 1)
    {
        if(nganhListObject!=NULL)
        { return [nganhListObject.data count];}
        else {return 0;}
    }else
    {
        if(metroListObject!=NULL)
        {   return [metroListObject.data count];}
        else{ return 0;}
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableviewDialog cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //CUSTOME CELL
    static NSString *CellIdentifier = @"NganhCell";
    NganhCell *cell = (NganhCell*)[tableviewDialog dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[NganhCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"NganhCell"];
    }
    
    if(indexDialog == 0)
    {
        BranchObject *item = [metroListObject.data objectAtIndex:indexPath.row];
        [cell.contentLabel setText:item.name];
    }else
    {
        NganhObject *item = [nganhListObject.data objectAtIndex:indexPath.row];
        [cell.contentLabel setText:item.name];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableviewDialog didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexDialog == 0)
    {
        indexBranchMetro = indexPath.row;
        [self setNameLabelBranchMetro];
    }else
    {
        indexNganh = indexPath.row;
        [self setNameLabelNganh];
    }
    [viewTable removeFromSuperview];
}


@end
