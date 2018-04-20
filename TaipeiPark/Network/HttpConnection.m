//
//  HttpConnection.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/19.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "HttpConnection.h"
#import <AFNetworking.h>
#import "Attraction.h"

@implementation HttpConnection
AFHTTPSessionManager *sessionManager = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];


    }
    return self;
}

-(void)requestGet:(NSString *)urlString response:(void(^)(NSDictionary *))responseBlock error:(void(^)(long, NSString *))errorBlock {
    [sessionManager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        responseBlock([[JSONModel alloc] initWithDictionary:responseObject error:nil]);
//        JSONModel *json = [[JSONModel alloc] initWithDictionary:responseObject error:nil];
//        NSLog(@"%@", json);
//
//        RtnData *dataString = [[RtnData alloc] initWithDictionary:responseObject error:nil];
//        NSLog(@"%@", dataString);

//        [[NSDictionary alloc] initwith]
        responseBlock((NSDictionary *)responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error.code, error.localizedDescription);
    }];
}

@end
