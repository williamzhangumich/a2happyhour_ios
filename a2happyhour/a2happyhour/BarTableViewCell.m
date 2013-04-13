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
@synthesize AllTime = _AllTime;
@synthesize Image = _Image;
@synthesize AllSpecial = _AllSpecial;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.AllTime.textColor=[self getColor:@"cc3300"];
    self.BarNameLabel.textColor=[self getColor:@"33cc66"];
    self.AllSpecial.textColor=[self getColor:@"ff9900"];
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




// HEX Color to RGB Color
- (UIColor *)getColor:(NSString *)hexColor
{
	unsigned int red,green,blue;
	NSRange range;
	range.length = 2;
	
	range.location = 0;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	
	range.location = 2;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	
	range.location = 4;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
	
	return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}


@end
