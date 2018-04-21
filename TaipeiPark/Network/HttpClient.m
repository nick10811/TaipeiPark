//
//  HttpClient.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/21.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "HttpClient.h"
#import <AFNetworking.h>

@implementation HttpClient
static HttpClient *_sharedInstance = nil;
AFHTTPSessionManager *sessionManager = nil;

+ (HttpClient *)sharedInstance {
    if (_sharedInstance == nil) {
        _sharedInstance = [[HttpClient alloc] init];
    }
    return _sharedInstance;
}

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

- (void)request:(HTTPMethod)method
            url:(NSString *)urlString
       response:(void(^)(NSDictionary *))responseBlock
          error:(void(^)(long, NSString *))errorBlock {
    
    switch (method) {
        case HTTPMethod_GET:
        {
            [sessionManager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                responseBlock((NSDictionary *)responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                errorBlock(error.code, error.localizedDescription);
            }];
        }
            break;
            
        case HTTPMethod_POST:
        {
            [sessionManager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                responseBlock((NSDictionary *)responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                errorBlock(error.code, error.localizedDescription);
            }];
        }
            
        default:
            NSLog(@"Error type");
            break;
    }
}

@end
