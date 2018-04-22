//
//  MyCollectionCell.m
//  TaipeiPark
//
//  Created by Nick Yang on 09/08/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "MyCollectionCell.h"
#import "Functions.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MyCollectionCell

@synthesize rImage_ImageView;
@synthesize rName_Label;

- (void)setupUI:(AttractionModel *)model {
    if ([Functions isImage:model.Image]) {
        [self.rImage_ImageView sd_setImageWithURL:[NSURL URLWithString:model.Image]
                                 placeholderImage:[UIImage imageNamed:@"Load.png"]];
        
    } else {
        self.rImage_ImageView.image = [UIImage imageNamed:@"noImage.png"];
    }
    
    self.rName_Label.text = model.Name;
    self.rName_Label.adjustsFontSizeToFitWidth = YES;

}

@end
