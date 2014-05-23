//
//  MTMainController.h
//  metro
//
//  Created by Than Hoang Hai on 5/10/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NganhListObject.h"
#import "DialogController.h"

@interface MTMainController : UIViewController<UITableViewDataSource, UITabBarControllerDelegate,DialogDelegate>
{
    
    int page;
    int size;
    NSString *sMetroID;
    NSString *sNganhID;
    
    
    int indexDialog;
    int indexBranchMetro;
    int indexNganh;
    NganhListObject *nganhListObject;
    NganhListObject *metroListObject;
    
    BOOL isLoadMore;
    NSMutableArray *arrayListProduct;
    
    NSArray *listLinkHealthy;
    int indexSegmentHealthy;
    
    DialogController *dialogView;
}

@property (weak, nonatomic) IBOutlet UIView *viewHealthy;
@property (weak, nonatomic) IBOutlet UIView *viewProduct;
@property (weak, nonatomic) IBOutlet UITableView *tableViewProduct;
@property (weak, nonatomic) IBOutlet UIButton *bntMetro;
@property (weak, nonatomic) IBOutlet UIButton *bntNganh;
@property (weak, nonatomic) IBOutlet UIWebView *webViewHealthy;


-(void)setIndexBranchMetro:(int)indexM withIndexNganh:(int)indexN;
-(void)setDataBranchMetro:(NganhListObject*)metrolist withNganhlist:(NganhListObject*)nganhList;

- (IBAction)segmentTopChange:(id)sender;
- (IBAction)segmentHealthyChange:(id)sender;
- (IBAction)doActionBntMetro:(id)sender;
- (IBAction)doActionBntNganh:(id)sender;
@end
