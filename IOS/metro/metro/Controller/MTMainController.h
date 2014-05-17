//
//  MTMainController.h
//  metro
//
//  Created by Than Hoang Hai on 5/10/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NganhListObject.h"

@interface MTMainController : UIViewController
{
    
    int page;
    int size;
    NSString *sMetroID;
    NSString *sNganhID;
    
    int indexBranchMetro;
    int indexNganh;
    NganhListObject *nganhListObject;
    NganhListObject *metroListObject;
    
    BOOL isLoadMore;
    NSMutableArray *arrayListProduct;
}

@property (weak, nonatomic) IBOutlet UIButton *bntMetro;
@property (weak, nonatomic) IBOutlet UIButton *bntNganh;

-(void)setIndexBranchMetro:(int)indexM withIndexNganh:(int)indexN;
-(void)setDataBranchMetro:(NganhListObject*)metrolist withNganhlist:(NganhListObject*)nganhList;

@end
