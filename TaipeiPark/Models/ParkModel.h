//
//  ParkModel.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/22.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "AttractionModel.h"

@interface ParkModel : JSONModel

@property (nonatomic) NSString *parkName;
@property (nonatomic) NSMutableArray<AttractionModel> *attractionArray;

@end
