//
//  WebService.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/19.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConnection.h"
#import "Attraction.h"

@interface WebService : HttpConnection

-(void)loadData:(void(^)(NSMutableArray<Attraction*>*))responseBlock
          error:(void(^)(long, NSString *))errorBlock;

@end
