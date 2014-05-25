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
#import "AsyncImageView.h"
#import "MarqueeLabel.h"
#import "HMSegmentedControl.h"
#import "DialogController.h"
#import "MBProgressHUD.h"
#import "SVPullToRefresh.h"

@interface MTMainController ()

@end


@implementation MTMainController

@synthesize viewProduct;
@synthesize viewHealthy;
@synthesize tableViewProduct;
@synthesize bntMetro;
@synthesize bntNganh;
@synthesize webViewHealthy;


#define HIGHT_TOP_IPHONE 50
#define HIGHT_TOP_IPAD 60
#define RUNNING_TEXT_HEIGHT_IPHONE 20
#define RUNNING_TEXT_HEIGHT_IPAD 30

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
    indexDialog = 0;
    
    [self setDefaultHightOfHealthy];
    
    [self addCustomeSegmentTop];
    [self addCustomeSegmentHealthy];
    
    //////init loadmore tableview
    __weak MTMainController *weakSelf = self;
    // setup infinite scrolling
    [self.tableViewProduct addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];

    
}

-(void)setDefaultHightOfHealthy
{
    int height = 0;
    if(IDIOM == IPAD)
        height = HIGHT_TOP_IPAD;
    else
        height = HIGHT_TOP_IPHONE;
    CGRect r = [viewHealthy frame];
    r.size.height = self.view.frame.size.height - height;;
    [viewHealthy setFrame:r];
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
    
    [self addRunningText];
    
    if(dialogView==nil)
    {
        UIStoryboard *storyboard ;
        if(IDIOM==IPAD)
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main-iPad" bundle:nil];
        }else
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        dialogView = [storyboard instantiateViewControllerWithIdentifier:@"DialogController"];
        //dialogView = [[DialogController alloc] initWithNibName:@"DialogController" bundle:nil];
        [dialogView setDelegate:self];                
        [dialogView setDataBranchMetro:metroListObject withNganhlist:nganhListObject];
    }
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

#pragma mark DelegateDialogCLose
-(void)delegateDongDialog:(NSString*)idItem withName:(NSString *)name withIndex:(int)index
{
    if(idItem!=nil && idItem.length > 0)
    {
        if(indexDialog==0)
        {
            sMetroID = idItem;
            [bntMetro setTitle:name forState:UIControlStateNormal];
        }else
        {    sNganhID = idItem;
            [bntNganh setTitle:name forState:UIControlStateNormal];
        }
        page = 0;
        [arrayListProduct removeAllObjects];
        [tableViewProduct reloadData];
        [self loadDataProduct];
    }
    [dialogView hideDialogWithAnimation];
}

#pragma mark ACTION_BUTTON_METRO_NGHANH

- (IBAction)doActionBntMetro:(id)sender {
        indexDialog = 0;
        page = 0;
        isLoadMore = YES;
        [dialogView setIndexDialog:0];
        [self.view addSubview:dialogView.view];
        [dialogView showDialogWithAnimation:self.view];
}


- (IBAction)doActionBntNganh:(id)sender {
    indexDialog = 1;
    page=0;
    isLoadMore = YES;
    [dialogView setIndexDialog:1];
    [dialogView showDialogWithAnimation:self.view];
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
    int height = 0;
    if(IDIOM == IPAD)
        height = HIGHT_TOP_IPAD;
    else
        height = HIGHT_TOP_IPHONE;
    [self.view addSubview:viewHealthy];
    CGRect r = [viewHealthy frame];
    r.origin.y = height;
    [viewHealthy setFrame:r];
}

- (IBAction)segmentHealthyChange:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    indexSegmentHealthy = [segmentedControl selectedSegmentIndex];
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
    if(page==0)
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
                 [tableViewProduct.infiniteScrollingView stopAnimating];
                 [LogDebug logError:@"Debug data product = " withContent:@"succedd"];
             }
         }
         if(page==0)
             [MBProgressHUD hideHUDForView:self.view animated:YES];
     } failure:^(NSString *err){
         [LogDebug logError:@"Debug data Nganh Metro load = " withContent:@"faith"];
         if(page==0)
             [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
}

#pragma mark - LOAD MORE TABLEVIEW
- (void)insertRowAtBottom {
    __weak MTMainController *weakSelf = self;
    if(isLoadMore)
    {
        page = page + 1;
        [self loadDataProduct];
    }else
    {
        [weakSelf.tableViewProduct.infiniteScrollingView stopAnimating];
    }
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
    [cell.description setText:item.description];
    if(item.price_1 !=NULL && item.price_1.length > 3)
    {
        [cell.giam setText:[NSString stringWithFormat:@"GIẢM %@",item.sale_off]];
        [cell.price1 setText:item.price_1];
        cell.imggiam.hidden = NO;
    }else
    {
        [cell.giam setText:@""];
        [cell.price1 setText:@""];
        cell.imggiam.hidden = YES;
    }
   
    [cell.price2 setText:item.price_2];
    [cell.vat setText:[NSString stringWithFormat:@"-GTGT %@",item.price_vat]];
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.imgProduct];
    [cell setlinkImage:item.photo];
    
    return cell;
}

- (void)tableView:(UITableView *)tableviewDialog didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark ADD_RUNNING_TEXT
-(void)addRunningText
{
    int height = 0;
    int fontsize = 0;
    if(IDIOM == IPAD)
    {    height = RUNNING_TEXT_HEIGHT_IPAD;
        fontsize = 17;
    }else
    {   height = RUNNING_TEXT_HEIGHT_IPHONE;
        fontsize = 14;
    }
    //Second continuous label example
    MarqueeLabel *continuousLabel2 = [[MarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,height) rate:100.0f andFadeLength:10.0f];
    continuousLabel2.marqueeType = MLContinuous;
    continuousLabel2.animationCurve = UIViewAnimationOptionCurveLinear;
    continuousLabel2.continuousMarqueeExtraBuffer = 50.0f;
    continuousLabel2.numberOfLines = 1;
    continuousLabel2.opaque = NO;
    continuousLabel2.enabled = YES;
    continuousLabel2.shadowOffset = CGSizeMake(0.0, -1.0);
    continuousLabel2.textAlignment = NSTextAlignmentLeft;
    continuousLabel2.textColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:1.000];
    continuousLabel2.backgroundColor = [UIColor clearColor];
    continuousLabel2.font = [UIFont fontWithName:@"Helvetica" size:fontsize];
    continuousLabel2.text = @"This is another long label that scrolls continuously with a custom space between labels! You can also tap it to pause and unpause it!";

    [self.viewProduct addSubview:continuousLabel2];
}

#pragma mark ADD_CUSTOM_SEGMENT_TOP
-(void)addCustomeSegmentTop
{
    int height = 0;
    int fontsize = 0;
    if(IDIOM == IPAD)
    {
        fontsize = 18;
        height = 38;
        
    }else
    {    height = 28;
         fontsize = 13;
    }
    
    HMSegmentedControl *segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, height)];
    //[segmentedControl4 setStatusBorder:NO];
    segmentedControl4.sectionTitles = @[@"METRO", @"HEALTHY"];
    segmentedControl4.selectedSegmentIndex = 0;

    [segmentedControl4 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:fontsize]];
    segmentedControl4.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    segmentedControl4.textColor = [UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1];
    segmentedControl4.selectedTextColor = [UIColor colorWithRed:250.0f/255.0f green:235.0f/255.0f blue:55.0f/255.0f alpha:1];
    segmentedControl4.selectionIndicatorColor = [UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1];
    segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp;
    [segmentedControl4 addTarget:self action:@selector(segmentTopChange:) forControlEvents:UIControlEventValueChanged];

    
    [self.view addSubview:segmentedControl4];
}

-(void)addCustomeSegmentHealthy
{
    int height = 0;
    int fontsize = 0;
    if(IDIOM == IPAD)
    {
        fontsize = 18;
        height = 38;
        
    }else
    {    height = 28;
        fontsize = 13;
    }

    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Thông tin dự án", @"Đối tác", @"Hoạt động", @"Tài liệu", @"Liên hệ"]];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [segmentedControl1 addLineGrey:YES];
    segmentedControl1.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl1.scrollEnabled = YES;
    [segmentedControl1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:fontsize]];
    [segmentedControl1 addTarget:self action:@selector(segmentHealthyChange:) forControlEvents:UIControlEventValueChanged];
    [self.viewHealthy addSubview:segmentedControl1];
}


@end



//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        dialogView = [storyboard instantiateViewControllerWithIdentifier:@"DialogViewController"];

