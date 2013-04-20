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

@synthesize DayFilterBtn = _DayFilterBtn;
@synthesize AreaFilterBtn = _AreaFilterBtn;
@synthesize TypeFilterBtn = _TypeFilterBtn;

@synthesize DayFilter = _DayFilter;
@synthesize AreaFilter = _AreaFilter;
@synthesize TypeFilter = _TypeFilter;




- (IBAction)SelectDay:(id)sender {
    
    
    if (self.DayFilter.hidden) {
        [self.DayFilter setHidden:NO];
        [self.AreaFilter setHidden:YES];
        [self.TypeFilter setHidden:YES];
    }else{
        [self.DayFilter setHidden:YES];
    }
}

- (IBAction)SelectArea:(id)sender {
    if (self.AreaFilter.hidden) {
        [self.AreaFilter setHidden:NO];
        [self.DayFilter setHidden:YES];
        [self.TypeFilter setHidden:YES];
    }else{
        [self.AreaFilter setHidden:YES];
    }
    
}

- (IBAction)SelectType:(id)sender {
    if (self.TypeFilter.hidden) {
        [self.TypeFilter setHidden:NO];
        [self.DayFilter setHidden:YES];
        [self.AreaFilter setHidden:YES];
    }else{
        [self.TypeFilter setHidden:YES];
    }
}

- (IBAction)SetFilter:(UIButton*)sender {
    
    
    switch (sender.superview.tag) {
        case 1:
          
            [self.DayFilterBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            break;
        case 2:
           
            [self.AreaFilterBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            break;
        case 3:
           
            [self.TypeFilterBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    [self.DayFilter setHidden:YES];
    [self.AreaFilter setHidden:YES];
    [self.TypeFilter setHidden:YES];
}

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
    [self setNavigationBar];
    [self.view setBackgroundColor:[self getColor:@"222222"]];
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


-(void)setNavigationBar
{
    [self.navigationItem setTitle:@"A2HappyHour Club"];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[self getColor:@"F20081"] forKey:UITextAttributeTextColor];

    
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
