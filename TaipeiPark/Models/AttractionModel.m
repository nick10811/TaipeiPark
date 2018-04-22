//
//  AttractionModel.m
//  TaipeiPark
//
//  Created by Nick Yang on 27/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "AttractionModel.h"

@implementation AttractionModel

@synthesize _id;
@synthesize ParkName;
@synthesize Name;
@synthesize YearBuilt;
@synthesize OpenTime;
@synthesize Image;
@synthesize Introduction;

@end

@implementation Result

@synthesize limit;
@synthesize offset;
@synthesize count;
@synthesize sort;
@synthesize results;

@end

@implementation RtnData

@synthesize result;

@end
