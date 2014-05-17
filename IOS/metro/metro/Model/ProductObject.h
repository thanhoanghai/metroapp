//
//  ProductObject.h
//  metro
//
//  Created by Than Hoang Hai on 5/17/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductObject : NSObject

@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong) NSString *photo;
@property(nonatomic, strong) NSString *price_1;
@property(nonatomic, strong) NSString *price_2;
@property(nonatomic, strong) NSString *price_vat;
@property(nonatomic, strong) NSString *sale_off;

+ (id)itemWithDictionary:(NSDictionary*) dictionary;

@end
