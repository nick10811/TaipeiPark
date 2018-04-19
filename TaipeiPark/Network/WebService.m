//
//  WebService.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/19.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "WebService.h"
#import "AppInfoManager.h"
#import "Attraction.h"

@implementation WebService

- (NSString *)urlname {
    return @"?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812";
}

-(void)loadData:(void(^)(NSMutableArray<Attraction*>*))responseBlock error:(void(^)(long, NSString *))errorBlock {
    [self requestGet:[NSString stringWithFormat:@"%@%@", serverIP, self.urlname] response:^(JSONModel *response) {
        NSLog(@"JSON:%@", response);
        RtnData *json = (RtnData *)response;
        responseBlock([NSMutableArray arrayWithArray:json.result.results]);
        
    } error:^(long code, NSString *message) {
        errorBlock(code, message);
    }];
}

@end
