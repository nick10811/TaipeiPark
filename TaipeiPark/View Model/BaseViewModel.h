//
//  BaseViewModel.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/22.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceLoadingDelegate.h"
#import "DataProtocol.h"

@interface BaseViewModel : NSObject <DataProtocol>

@property (nonatomic, weak) id<WebServiceLoadingDelegate> loadingDelegate;
@property (nonatomic, assign) LoadingStatus status;
@property (nonatomic, strong) NSMutableArray *modelArray;

- (void)nextStatus;
- (void)refreshData;

@end
