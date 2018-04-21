//
//  HttpConnection.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/19.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "HttpConnection.h"
#import <AFNetworking.h>
#import "HttpClient.h"

@implementation HttpConnection

- (void)requestGet:(NSString *)urlString
          response:(void(^)(NSDictionary *))responseBlock
             error:(void(^)(long, NSString *))errorBlock {
    [[HttpClient sharedInstance] request:HTTPMethod_GET url:urlString response:^(NSDictionary *responseObject) {
        responseBlock(responseObject);
    } error:^(long code, NSString *message) {
        errorBlock(code, message);
    }];
}

@end
