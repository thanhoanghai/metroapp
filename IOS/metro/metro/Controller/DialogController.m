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

- (IBAction)doActionDongLai:(id)sender {    
    if (self.delegate ) {
        [self.delegate delegateDongDialog];
    }
}

-(void)setDataBranchMetro:(NganhListObject*)metrolist withNganhlist:(NganhListObject*)nganhList
{
    nganhListObject = nganhList;
    metroListObject = metrolist;
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
    NganhCell *cell = (NganhCell*)[tableviewDialog dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[NganhCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"NganhCell"];
    }
    
    if(indexDialog == 0 && metroListObject!=NULL)
    {
        BranchObject *item = [metroListObject.data objectAtIndex:indexPath.row];
        [cell.contentLabel setText:item.name];
    }else if(nganhListObject!=NULL)
    {
        NganhObject *item = [nganhListObject.data objectAtIndex:indexPath.row];
        [cell.contentLabel setText:item.name];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableviewDialog didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}




@end
