//
//  CustomNaviBarController.m
//  a2happyhour
//
//  Created by zhuchengqi on 13-4-12.
//  Copyright (c) 2013年 William Zhang. All rights reserved.
//

#import "CustomNaviBarController.h"

@interface CustomNaviBarController ()

@end

@implementation CustomNaviBarController

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
	// Do any additional setup after loading the view.
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar-black"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
