//
//  DBHelp.h
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attraction.h"

@interface DBHelp : NSObject

- (NSInteger)getCount;
- (void)batchInsertAttraction:(NSArray *)atts;
- (void)cleanAttractions;
- (NSMutableDictionary *)getAttractionsByPark;
- (NSMutableDictionary *)getAttractionsByKeyword:(NSString *)keyword;

@end
