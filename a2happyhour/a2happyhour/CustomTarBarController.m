//
//  CustomTarBarController.m
//  a2happyhour
//
//  Created by Holysoul on 4/12/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import "CustomTarBarController.h"

@interface CustomTarBarController ()

@end

@implementation CustomTarBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addCustomElements];
    
    
	// Do any additional setup after loading the view.
}



-(void)addCustomElements
{
    // Background
    UIImageView* bgView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"tabbar.png"]];
    bgView.frame = CGRectMake(0, 420, 320, 60);
    [self.view addSubview:bgView];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
