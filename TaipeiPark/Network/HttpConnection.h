//
//  HttpConnection.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/19.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface HttpConnection : NSObject

@property (nonatomic, strong) NSString *urlname;

-(void)requestGet:(NSString *)urlString
         response:(void(^)(NSDictionary *))responseBlock
            error:(void(^)(long, NSString *))errorBlock;

@end
