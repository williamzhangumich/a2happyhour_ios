//
//  ListViewTabController.h
//  a2happyhour
//
//  Created by William Zhang on 3/21/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewTabController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *locationText;

@property (weak, nonatomic) IBOutlet UIView *TableViewContainer;

@property (weak, nonatomic) IBOutlet UIButton *DayFilterBtn;
@property (weak, nonatomic) IBOutlet UIButton *AreaFilterBtn;
@property (weak, nonatomic) IBOutlet UIButton *TypeFilterBtn;

@property (weak, nonatomic) IBOutlet UIView *DayFilter;
@property (weak, nonatomic) IBOutlet UIView *AreaFilter;
@property (weak, nonatomic) IBOutlet UIView *TypeFilter;



@end
