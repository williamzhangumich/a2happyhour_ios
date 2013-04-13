//
//  BarTableViewCell.m
//  a2happyhour
//
//  Created by William Zhang on 3/22/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import "BarTableViewCell.h"

@implementation BarTableViewCell

@synthesize BarNameLabel = _BarNameLabel;
@synthesize AreaLabel = _AreaLabel;
@synthesize Image = _Image;
@synthesize addressLabel = _addressLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
