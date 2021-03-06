//
//  BarTableViewCell.h
//  a2happyhour
//
//  Created by William Zhang on 3/22/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *BarNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *AllTime;
@property (weak, nonatomic) IBOutlet UILabel *AllSpecial;

@property (weak, nonatomic) IBOutlet PFImageView *Image;


@end
