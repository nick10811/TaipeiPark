//
//  WebServiceLoading.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/22.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _LoadingStatus {
    initialize,
    loadStart,
    loadDone,
    loadFail,
    loadMoreStart,
    loadMoreDone,
    loadMoreFail,
    refreshLoading
    
} LoadingStatus;

@protocol WebServiceLoadingDelegate <NSObject>

- (void) WebServiceLoadingDone;
- (void) WebServiceLoadingFail:(long)code Message:(NSString *)msg;

@end
