//
//  Functions.h
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/21.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Functions : NSObject

+ (UIViewController *)findViewControllerByIDFromStoryboard:(NSString *) storyboardName
                                          viewControllerID:(NSString *) viewControllerID;
+ (BOOL)isImage:(NSString *)path;

@end
