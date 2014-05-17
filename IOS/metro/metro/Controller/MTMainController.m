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

@interface MTMainController ()

@end


@implementation MTMainController

@synthesize bntMetro;
@synthesize bntNganh;

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
                 [LogDebug logError:@"Debug data product = " withContent:@"succedd"];
             }
         }
     } failure:^(NSString *err){
         [LogDebug logError:@"Debug data Nganh Metro load = " withContent:@"faith"];
     }];
}

@end
