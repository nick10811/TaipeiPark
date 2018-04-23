//
//  DetailViewModel.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/23.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "ParkModel.h"
#import "AttractionModel.h"

@interface DetailViewModel : BaseViewModel

- (instancetype)initWithPark:(ParkModel *)park attraction:(AttractionModel *)attraction;
- (AttractionModel *)selectedModel;
- (NSMutableArray<AttractionModel> *)relationModel;

@end
