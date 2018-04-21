//
//  HttpClient.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/21.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

typedef enum _HTTPMethod {
    HTTPMethod_GET,
    HTTPMethod_POST
} HTTPMethod;

@interface HttpClient : NSObject

+ (HttpClient *)sharedInstance;

- (void)request:(HTTPMethod)method
            url:(NSString *)urlString
       response:(void(^)(NSDictionary *))responseBlock
          error:(void(^)(long, NSString *))errorBlock;

@end
