//
//  ProductObject.m
//  metro
//
//  Created by Than Hoang Hai on 5/17/14.
//  Copyright (c) 2014 Than Hoang Hai. All rights reserved.
//

#import "ProductObject.h"

@implementation ProductObject

#define JSon_id @"id"
#define JSon_description @"description"
#define JSon_photo @"photo"
#define JSon_price_1 @"price_1"
#define JSon_price_2 @"price_2"
#define JSon_price_vat @"price_vat"
#define JSon_sale_off @"sale_off"


@synthesize id;
@synthesize description;
@synthesize photo;
@synthesize price_1;
@synthesize price_2;
@synthesize price_vat;
@synthesize sale_off;

+ (id)itemWithDictionary:(NSDictionary*) dictionary
{
    return [[ProductObject alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary*) dictionary
{
    if(self = [super init])
    {
        self.id = nil;
        self.description = nil;
        self.photo = nil;
        self.price_1 = false;
        self.price_2 = false;
        self.price_vat = 0;
        self.sale_off = nil;
        // read from json value
        if([dictionary objectForKey:JSon_id] && [dictionary objectForKey:JSon_id]!= [NSNull null]){
            self.id = [dictionary objectForKey:JSon_id];
        }
        if([dictionary objectForKey:JSon_description] && [dictionary objectForKey:JSon_description]!= [NSNull null]){
            self.description = [dictionary objectForKey:JSon_description];
        }
        if([dictionary objectForKey:JSon_photo] && [dictionary objectForKey:JSon_photo]!= [NSNull null]){
            self.photo = [dictionary objectForKey:JSon_photo];
        }
        if([dictionary objectForKey:JSon_price_1] && [dictionary objectForKey:JSon_price_1]!= [NSNull null]){
            self.price_1 = [dictionary objectForKey:JSon_price_1];
        }
        if([dictionary objectForKey:JSon_price_2] && [dictionary objectForKey:JSon_price_2]!= [NSNull null]){
            self.price_2 = [dictionary objectForKey:JSon_price_2];
        }
        if([dictionary objectForKey:JSon_price_vat] && [dictionary objectForKey:JSon_price_vat]!= [NSNull null]){
            self.price_vat = [dictionary objectForKey:JSon_price_vat];
        }
        if([dictionary objectForKey:JSon_sale_off] && [dictionary objectForKey:JSon_sale_off]!= [NSNull null]){
            self.sale_off = [dictionary objectForKey:JSon_sale_off];
        }
    }
    
    return self;
}

@end
