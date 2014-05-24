//
//  DialogController.m
//  metro
//
//  Created by Than Hoang Hai on 5/22/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import "DialogController.h"
#import "NganhCell.h"
#import "BranchObject.h"
#import "NganhObject.h"
#import "MetroCell.h"

#define CELL_METRO_HEIGHT 60
#define CELL_NGANH_HEIGHT 45

@interface DialogController ()

@end

@implementation DialogController

@synthesize labelTitle;
@synthesize tableViewData;

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
    // Do any additional setup after loading the view from its nib.
    self.view.alpha = 0.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNameTitleDialog:indexDialog];
    [tableViewData reloadData];
}

-(void)setIndexDialog:(int)index
{
    indexDialog = index;
}

-(void)setNameTitleDialog:(int)index
{
    if(index == 0)
    {
        [labelTitle setText:TRUNG_TAM_METRO];
    }else
        [labelTitle setText:NGANH_HANG_KINH_DOANH];
    
}

-(void)setDataBranchMetro:(NganhListObject*)metrolist withNganhlist:(NganhListObject*)nganhList
{
    nganhListObject = nganhList;
    metroListObject = metrolist;
}

- (IBAction)doActionDongLai:(id)sender {
    if (self.delegate ) {
        [self.delegate delegateDongDialog:@"" withName:@"" withIndex:-1];
    }
}

-(void)showDialogWithAnimation:(UIView*)viewSuper;
{
    [viewSuper addSubview:self.view];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
}

-(void)hideDialogWithAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

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
    static NSString *CellMetro = @"MetroCell";
   
    
    if(indexDialog == 0 && metroListObject!=NULL)
    {
        MetroCell *cell = (MetroCell*)[tableviewDialog dequeueReusableCellWithIdentifier:CellMetro];
        if(cell==nil){
            cell = [[MetroCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MetroCell"];
        }
        BranchObject *item = [metroListObject.data objectAtIndex:indexPath.row];
        [cell.lbTitle setText:item.name];
        [cell.lbDescription setText:item.address];
        return cell;
    }else
    {
        NganhCell *cell = (NganhCell*)[tableviewDialog dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell==nil){
            cell = [[NganhCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"NganhCell"];
        }
        NganhObject *item = [nganhListObject.data objectAtIndex:indexPath.row];
        [cell.contentLabel setText:item.name];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableviewDialog didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexDialog == 0 && metroListObject!=NULL)
    {
        BranchObject *item = [metroListObject.data objectAtIndex:indexPath.row];
        [self.delegate delegateDongDialog:item.id withName:item.name withIndex:indexPath.row];
    }else if(nganhListObject!=NULL)
    {
        NganhObject *item = [nganhListObject.data objectAtIndex:indexPath.row];
        [self.delegate delegateDongDialog:item.id withName:item.name withIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexDialog==0)
        return CELL_METRO_HEIGHT;
    else
        return CELL_NGANH_HEIGHT;
}


@end
