//
//  HttpConnection.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/19.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "HttpConnection.h"
#import <AFNetworking.h>

@implementation HttpConnection
AFHTTPSessionManager *sessionManager = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        sessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}

-(void)requestGet:(NSString *)urlString response:(void(^)(JSONModel *))responseBlock error:(void(^)(long, NSString *))errorBlock {
    [sessionManager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error.code, error.localizedDescription);
    }];
}

@end
