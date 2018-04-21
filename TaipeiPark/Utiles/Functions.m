//
//  Functions.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/21.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "Functions.h"

@implementation Functions

+ (UIViewController *)findViewControllerByIDFromStoryboard:(NSString *) storyboardName
                                          viewControllerID:(NSString *) viewControllerID {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:viewControllerID];
}

+ (BOOL)isImage:(NSString *)path {
    NSString *extension = [path pathExtension];
    
    if ([[extension uppercaseString] isEqualToString:@"JPG"] ||
        [[extension uppercaseString] isEqualToString:@"PNG"]) {
        return YES;
    }
    return NO;
}


@end
