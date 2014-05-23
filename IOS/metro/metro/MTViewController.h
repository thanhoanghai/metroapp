//
//  MTViewController.h
//  metro
//
//  Created by Than Hoang Hai on 5/7/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NganhListObject.h"
#import "DialogController.h"

@interface MTViewController : UIViewController<DialogDelegate>
{
    NSTimer *nsTimerUp;
    
    int countTime;
    int indexDialog;
    int indexBranchMetro;
    int indexNganh;

    NganhListObject *nganhListObject;
    NganhListObject *metroListObject;
    
    DialogController *dialogView;
}



@property (weak, nonatomic) IBOutlet UIButton *bntChon;
@property (weak, nonatomic) IBOutlet UIView *viewDisconect;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIButton *lbBranchMetro;
@property (weak, nonatomic) IBOutlet UIButton *lbNganh;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;


- (IBAction)doActionBntChon:(id)sender;
- (IBAction)doActionBntBranchMetro:(id)sender;
- (IBAction)doActionBntNganh:(id)sender;
- (IBAction)doActionBntDisconnet:(id)sender;

@end
