//
//  SGNMenuCell.h
//  custom_navigation
//
//  Created by TPL2806 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ProductCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *giam;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UILabel *vat;
@property (weak, nonatomic) IBOutlet UIImageView *imggiam;
@property (weak, nonatomic) IBOutlet AsyncImageView *imgProduct;

- (void) setlinkImage:(NSString *)url;

@end
