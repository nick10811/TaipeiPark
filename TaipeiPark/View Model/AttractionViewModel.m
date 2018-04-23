//
//  AttractionViewModel.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/22.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "AttractionViewModel.h"
#import "ParkService.h"
#import "ParkModel.h"

@implementation AttractionViewModel
ParkService *webService;

- (instancetype)init
{
    self = [super init];
    if (self) {
        webService = [[ParkService alloc] init];
    }
    return self;
}

- (void)loadData {
    [webService loadData:^(NSMutableArray<AttractionModel *> *parkArray) {
        self.status = loadDone;
        [self dataConvert:parkArray];
        
    } error:^(long code, NSString *message) {
        self.status = loadFail;
        [self.loadingDelegate WebServiceLoadingFail:code Message:message];
        
    }];
}

- (void)loadMoreData {
    [webService loadData:^(NSMutableArray<AttractionModel *> *parkArray) {
        self.status = loadMoreDone;
        [self dataConvert:parkArray];
        
    } error:^(long code, NSString *message) {
        self.status = loadMoreFail;
        [self.loadingDelegate WebServiceLoadingFail:code Message:message];
        
    } offset:webService.nextOffset];
}

- (void)dataConvert:(NSMutableArray<AttractionModel *> *) parkArray {
    // classify
    for (int i = 0; i < parkArray.count; i++) {
        AttractionModel *attraction = parkArray[i];
        ParkModel *park = [self containParkModel:attraction];
        if (park != nil) {
            [park.attractionArray addObject:attraction];
            
        } else {
            ParkModel *newPark = [[ParkModel alloc] init];
            newPark.parkName = attraction.ParkName;
            [newPark.attractionArray addObject:attraction];
            
            [self.modelArray addObject:newPark];
        }
            
    }
    [self.loadingDelegate WebServiceLoadingDone];
}

- (ParkModel *)containParkModel:(AttractionModel *)object {
    ParkModel *park = nil;
    for (int i = 0; i < self.modelArray.count; i++) {
        ParkModel *find = self.modelArray[i];
        if ([object.ParkName isEqualToString:find.parkName]) {
            park = find;
            break;
        }
    }
    
    return park;
}

#pragma mark - DataProtocol
- (NSUInteger)numberOfSection {
    return [self.modelArray count];
}

- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return ((ParkModel *)[self.modelArray objectAtIndex:section]).attractionArray.count;
}

- (ParkModel *)modelAtSection:(NSUInteger)section {
    return (ParkModel *)[self.modelArray objectAtIndex:section];
}

- (AttractionModel *)modelAtIndex:(NSIndexPath *)indexPath {
    return (AttractionModel *)[((ParkModel *)[self.modelArray objectAtIndex:indexPath.section]).attractionArray objectAtIndex:indexPath.row];
}

- (BOOL)isLastModel:(NSIndexPath *)indexPath {
    return indexPath.section+1 == self.modelArray.count && indexPath.row+1 == [self numberOfItemsInSection:indexPath.section];
}

@end
