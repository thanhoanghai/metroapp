//
//  MTMainController.m
//  metro
//
//  Created by Than Hoang Hai on 5/10/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import "MTMainController.h"
#import "NganhListObject.h"
#import "BranchObject.h"
#import "NganhObject.h"
#import "AFClient.h"
#import "ProductObject.h"
#import "LogDebug.h"
#import "ProductCell.h"

@interface MTMainController ()

@end


@implementation MTMainController

@synthesize viewHealthy;
@synthesize tableViewProduct;
@synthesize bntMetro;
@synthesize bntNganh;
@synthesize webViewHealthy;
@synthesize scrollviewSegment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    page = 0;
    size = 10;
    isLoadMore = YES;
    
    arrayListProduct = [[NSMutableArray alloc] init ];
    
    listLinkHealthy = [NSArray arrayWithObjects:
             @"http://metro.qptek.com/healthy/info",
             @"http://metro.qptek.com/healthy/partners",
             @"http://metro.qptek.com/healthy/activity",
             @"http://metro.qptek.com/healthy/documents",
             @"http://metro.qptek.com/healthy/contact",
             nil];
    indexSegmentHealthy = 0;
    [scrollviewSegment setContentSize:CGSizeMake(550, 28)];
    [scrollviewSegment setScrollEnabled:YES];
    [scrollviewSegment setShowsHorizontalScrollIndicator:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BranchObject *item = nil;
    item = [metroListObject.data objectAtIndex:indexBranchMetro];
    [bntMetro setTitle:item.name forState:UIControlStateNormal];
    sMetroID = item.id;
    
    NganhObject *nganhItem = nil;
    nganhItem = [nganhListObject.data objectAtIndex:indexNganh];
    [bntNganh setTitle:nganhItem.name forState:UIControlStateNormal];
    sNganhID = nganhItem.id;
    
    [self loadDataProduct];
    [self loadLinkWebView:indexSegmentHealthy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setIndexBranchMetro:(int)indexM withIndexNganh:(int)indexN
{
    indexBranchMetro = indexM;
    indexNganh = indexN;
}
-(void)setDataBranchMetro:(NganhListObject*)metrolist withNganhlist:(NganhListObject*)nganhList
{
    nganhListObject = nganhList;
    metroListObject = metrolist;
}

#pragma mark SEAGMENT_CHANGE

- (IBAction)segmentTopChange:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        [viewHealthy removeFromSuperview];
    }
    else{
        [self showViewHealthy];
    }
}

-(void)showViewHealthy
{
    [self.view addSubview:viewHealthy];
    CGRect r = [viewHealthy frame];
    r.origin.y = 48;
    [viewHealthy setFrame:r];
}

- (IBAction)segmentHealthyChange:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    indexSegmentHealthy = segmentedControl.selectedSegmentIndex;
    [self loadLinkWebView:indexSegmentHealthy];
}

-(void)loadLinkWebView:(int)index
{
    NSString *fullURL = [listLinkHealthy objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webViewHealthy loadRequest:requestObj];
}

#pragma mark LOAD_DATA_PRODUCT

-(void)loadDataProduct
{
    NSString *link = [AFClient getLlinkProduct:page withPageSize:size withMetroID:sMetroID withNganhID:sNganhID];
    [AFClient getLink:link success:^(id result)
     {
         if(result)
         {
             id data = [result objectForKey:@"data"];
             if(data)
             {
                 int total_pages = [[data objectForKey:data] integerValue];
                 if(total_pages <= page+1)
                 {
                     isLoadMore = NO;
                 }
                 id listProduct = [data objectForKey:@"product"];
                 for (NSDictionary *item in listProduct)
                 {
                     [arrayListProduct addObject:[ProductObject itemWithDictionary:item]];
                 }
                 
                 [tableViewProduct reloadData];
                 [LogDebug logError:@"Debug data product = " withContent:@"succedd"];
             }
         }
     } failure:^(NSString *err){
         [LogDebug logError:@"Debug data Nganh Metro load = " withContent:@"faith"];
     }];
}

#pragma mark TABBLE_VIEW
- (NSInteger)tableView:(UITableView *)tableviewDialog numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [arrayListProduct count];
}

- (UITableViewCell *)tableView:(UITableView *)tableviewDialog cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //CUSTOME CELL
    static NSString *CellIdentifier = @"ProductCell";
    ProductCell *cell = (ProductCell*)[tableviewDialog dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ProductCell"];
    }
    
    ProductObject *item = [arrayListProduct objectAtIndex:indexPath.row];
    [cell.contentLabel setText:item.name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableviewDialog didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


@end
