//
//  Attraction.h
//  TaipeiPark
//
//  Created by Nick Yang on 27/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Attraction;

@interface Attraction : JSONModel

@property (nonatomic) NSString *_id;
@property (nonatomic) NSString *ParkName;
@property (nonatomic) NSString *Name;
@property (nonatomic) NSString *YearBuilt;
@property (nonatomic) NSString *OpenTime;
@property (nonatomic) NSString *Image;
@property (nonatomic) NSString *Introduction;

@end

@interface Result : JSONModel

@property (nonatomic) NSInteger limit;
@property (nonatomic) NSInteger offset;
@property (nonatomic) NSInteger count;
@property (nonatomic) NSString *sort;
@property (nonatomic) NSArray<Attraction> *results;

@end

@interface RtnData : JSONModel

@property (nonatomic) Result *result;

@end
