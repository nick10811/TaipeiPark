//
//  Server.m
//  TaipeiPark
//
//  Created by Nick Yang on 30/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "Server.h"
#import "DBHelp.h"
#import "Attraction.h"

@implementation Server

NSString *serverURL = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812&limit=100";
int offset = 0;

- (void)postQuery {
    DBHelp *db = [[DBHelp alloc] init];
    [db cleanAttractions];
    
    // get json and store to sqlite
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&offset=0", serverURL]];
    
    [self getAttractions:url];
    
}

- (void)getAttractions:(NSURL *)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        RtnData *json = [[RtnData alloc] initWithData:data error:nil];
        
        // store data to sqlite
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            DBHelp *db = [[DBHelp alloc] init];
            [db batchInsertAttraction:json.result.results];
            
            if (offset >= (int)json.result.count) {
                // notify
                [[NSNotificationCenter defaultCenter] postNotificationName:@"DataUpdate" object:nil userInfo:nil];
            }
        });
        
        // get more data
        offset = (int)json.result.offset + 100;
        if (offset < (int)json.result.count) {
            [self getAttractions:[NSURL URLWithString:[NSString stringWithFormat:@"%@&offset=%d",serverURL, offset]]];
            
        }
    }];
    
    [dataTask resume];
    
}

@end
