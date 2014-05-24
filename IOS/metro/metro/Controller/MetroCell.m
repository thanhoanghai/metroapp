//
//  MetroCell.m
//  metro
//
//  Created by Than Hoang Hai on 5/24/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import "MetroCell.h"

@implementation MetroCell

@synthesize lbDescription;
@synthesize lbTitle;

- (void)awakeFromNib
{
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"MetroCell" owner:self options:nil] lastObject];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
