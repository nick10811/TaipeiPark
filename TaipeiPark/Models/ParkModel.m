//
//  ParkModel.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/22.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "ParkModel.h"

@implementation ParkModel

@synthesize parkName;
@synthesize attractionArray;

- (instancetype)init {
    self = [super init];
    if (self) {
        attractionArray = [[NSMutableArray<AttractionModel> alloc] init];
    }
    return self;
}

@end
