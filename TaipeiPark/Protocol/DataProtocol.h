//
//  DataProtocol.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/23.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@protocol DataProtocol <NSObject>

- (void)loadData;
- (void)loadMoreData;

- (NSUInteger)numberOfSection;
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;
- (JSONModel *)modelAtSection:(NSUInteger)section;
- (JSONModel *)modelAtIndex:(NSIndexPath *)indexPath;
- (BOOL)isLastModel:(NSIndexPath *)indexPath;

@end
