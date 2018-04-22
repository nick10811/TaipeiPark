//
//  DetailViewModel.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/23.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel
AttractionModel *_selectedModel;
NSMutableArray<AttractionModel> *relationModelArray;

- (instancetype)initWithPark:(ParkModel *)park attraction:(AttractionModel *)attraction {
    self = [super init];
    if (self) {
        _selectedModel = attraction;
        relationModelArray = [[NSMutableArray<AttractionModel> alloc] init];
        [self dataConvert:park.attractionArray];
    }
    return self;
}

- (void)dataConvert:(NSMutableArray<AttractionModel> *)array {
    for (AttractionModel *currentModel in array) {
        if (![currentModel.Name isEqualToString:_selectedModel.Name]) {
            [relationModelArray addObject:currentModel];
        }
    }
}

- (AttractionModel *)selectedModel {
    return _selectedModel;
}

- (NSMutableArray<AttractionModel> *)relationModel {
    return relationModelArray;
}

#pragma mark - DataProtocol
- (NSUInteger)numberOfSection {
    return 1;
}

- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return relationModelArray.count;
}

- (JSONModel *)modelAtSection:(NSUInteger)section {
    return nil;
}

- (AttractionModel *)modelAtIndex:(NSIndexPath *)indexPath {
    return (AttractionModel *)[relationModelArray objectAtIndex:indexPath.item];
}

- (BOOL)isLastModel:(NSIndexPath *)indexPath {
    return indexPath.item+1 == relationModelArray.count;
}

@end
