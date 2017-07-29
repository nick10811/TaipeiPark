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

- (void)batchInsertAttraction:(NSArray *)atts;
- (NSMutableArray *)getRelationAttractions:(Attraction *)selected;

@end
