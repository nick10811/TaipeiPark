//
//  UpdateManager.h
//  TaipeiPark
//
//  Created by Nick Yang on 10/08/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DataProgressBlock)(float stored, float total);
@interface UpdateManager : NSObject

- (UpdateManager *_Nullable)parseData;
- (UpdateManager *_Nullable)setProgressBlock:(_Nonnull DataProgressBlock)progressBlock;

@end
