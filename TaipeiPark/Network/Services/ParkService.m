//
//  ParkService.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/19.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "ParkService.h"
#import "AppInfoManager.h"
#import "Attraction.h"

@implementation ParkService

- (NSString *)urlname {
    return @"?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812";
}

- (void)loadData:(void(^)(NSMutableArray<Attraction*>*))responseBlock
           error:(void(^)(long, NSString *))errorBlock {
    [self loadData:responseBlock error:errorBlock offset:0];
}

- (void)loadData:(void(^)(NSMutableArray<Attraction*>*))responseBlock
           error:(void(^)(long, NSString *))errorBlock
          offset:(int)offset {
    [self requestGet:[NSString stringWithFormat:@"%@%@&limit=100&offset=%d", serverIP, self.urlname, offset] response:^(NSDictionary *response) {
        RtnData *json = [[RtnData alloc] initWithDictionary:response error:nil];
        _nextOffset = (int)json.result.offset+100;
        responseBlock([NSMutableArray arrayWithArray:json.result.results]);
        
    } error:^(long code, NSString *message) {
        errorBlock(code, message);
    }];
}

@end
