//
//  UpdateManager.m
//  TaipeiPark
//
//  Created by Nick Yang on 10/08/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "UpdateManager.h"
#import "DBHelp.h"
#import "Attraction.h"

#define serverURL @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812"

@interface UpdateManager() {
    DataProgressBlock _progressBlock;
}

@end

@implementation UpdateManager

int offset = 0;

- (UpdateManager *)parseData {
    DBHelp *db = [[DBHelp alloc] init];
    [db cleanAttractions];
    
    NSString *urlString = [NSString stringWithFormat:@"%@&limit=100&offset=0", serverURL];
    
    // get json and store to sqlite
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self getAttractions:url];
    
    return self;
    
}

- (void)getAttractions:(NSURL *)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        RtnData *json = [[RtnData alloc] initWithData:data error:&jsonError];
        
        // store data to sqlite
        DBHelp *db = [[DBHelp alloc] init];
        [db batchInsertAttraction:json.result.results];
        
        // get more data
        offset = (int)json.result.offset + 100;
        _progressBlock((float)offset,(float)json.result.count); // return progress
        if (offset < (int)json.result.count) {
            [self getAttractions:[NSURL URLWithString:[NSString stringWithFormat:@"%@&limit=100&offset=%d",serverURL, offset]]];
            
        }
    }];
    
    [dataTask resume];
    
}

- (UpdateManager *)setProgressBlock:(_Nonnull DataProgressBlock)progressBlock {
    _progressBlock = progressBlock;
    return self;
}

@end
