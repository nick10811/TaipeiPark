//
//  BaseViewModel.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/22.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.status = initialize;
        self.modelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) nextStatus {
    switch (self.status) {
        case initialize:
        case loadFail:
        {
            self.status = loadStart;
            [self loadData];
        }
            break;
        case loadDone:
        case loadMoreDone:
        case loadMoreFail:
        {
            self.status = loadMoreStart;
            [self loadMoreData];
        }
            break;
        case refreshLoading:
        {
            [self.modelArray removeAllObjects];
            self.status = loadStart;
            [self loadData];
        }
            break;
        default:
            break;
    }
}

- (void)refreshData {
    if (self.status != loadStart) {
        self.status = refreshLoading;
        [self nextStatus];
    }
}

@end
