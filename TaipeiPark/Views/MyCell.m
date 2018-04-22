//
//  MyCell.m
//  TaipeiPark
//
//  Created by Nick Yang on 28/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "MyCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Functions.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupUI:(AttractionModel *)model {
    if ([Functions isImage:model.Image]) {
        [self.img sd_setImageWithURL:[NSURL URLWithString:model.Image]
                    placeholderImage:[UIImage imageNamed:@"Load.png"]];
    } else {
        self.img.image = [UIImage imageNamed:@"noImage.png"];
    }
    
    self.parkName.text = model.ParkName;
    self.name.text = model.Name;
    self.introduction.text = model.Introduction;

}

@end
