//
//  DialogController.h
//  metro
//
//  Created by Than Hoang Hai on 5/22/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NganhListObject.h"

@protocol DialogDelegate <NSObject>
- (void) delegateDongDialog;
@end

@interface DialogController : UIViewController<UITableViewDataSource, UITabBarControllerDelegate>
{
    int indexDialog;
    NganhListObject *nganhListObject;
    NganhListObject *metroListObject;
}

@property (assign) id<DialogDelegate> delegate;

- (IBAction)doActionDongLai:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableViewData;
-(void)setIndexDialog:(int)index;
-(void)setDataBranchMetro:(NganhListObject*)metrolist withNganhlist:(NganhListObject*)nganhList;


@end
