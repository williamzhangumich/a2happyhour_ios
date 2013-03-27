//
//  ListViewTabController.m
//  a2happyhour
//
//  Created by William Zhang on 3/21/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import "ListViewTabController.h"
#import "MainTableViewController.h"

@interface ListViewTabController ()

@end

@implementation ListViewTabController

@synthesize TableViewContainer = _TableViewContainer;
@synthesize locationText = _locationText;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSLog(@"%@", [self.childViewControllers objectAtIndex:0]);
    [(MainTableViewController *)[self.childViewControllers objectAtIndex:0] loadObjects];
    return NO;
}
     

@end
