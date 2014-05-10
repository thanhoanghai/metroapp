//
//  SGNMenuCell.m
//  custom_navigation
//
//  Created by TPL2806 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuCell.h"


#define COLOR_MENU_CELL_SELECTED [UIColor colorWithRed:0.15 green:0.17 blue:0.23 alpha:1]
@implementation MenuCell

@synthesize contentLabel = _contentLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil] lastObject];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
