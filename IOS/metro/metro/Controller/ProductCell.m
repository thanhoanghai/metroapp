//
//  SGNMenuCell.m
//  custom_navigation
//
//  Created by TPL2806 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductCell.h"


#define COLOR_MENU_CELL_SELECTED [UIColor colorWithRed:0.15 green:0.17 blue:0.23 alpha:1]
@implementation ProductCell

@synthesize contentLabel = _contentLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil] lastObject];
    
    if (self) 
    {
    }
    return self;
}

@end