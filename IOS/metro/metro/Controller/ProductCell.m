//
//  SGNMenuCell.m
//  custom_navigation
//
//  Created by TPL2806 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductCell.h"
#import "AsyncImageView.h"


#define COLOR_MENU_CELL_SELECTED [UIColor colorWithRed:0.15 green:0.17 blue:0.23 alpha:1]
@implementation ProductCell

@synthesize contentLabel = _contentLabel;
@synthesize description;
@synthesize giam;
@synthesize price1;
@synthesize price2;
@synthesize vat;
@synthesize imgProduct;
@synthesize imggiam;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil] lastObject];
    
    if (self) 
    {
    }
    return self;
}

- (void) setlinkImage:(NSString *)url
{
    imgProduct.imageURL = [NSURL URLWithString:url];
}

@end
