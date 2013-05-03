//
//  DetailViewController.m
//  a2happyhour
//
//  Created by William Zhang on 3/21/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import "DetailViewController.h"
#import "ListViewTabController.h"

@interface DetailViewController ()<UIScrollViewDelegate>

@end

@implementation DetailViewController

@synthesize bar =_bar;
@synthesize BarMapView = _BarMapView;
@synthesize ScrollView = _ScrollView;
@synthesize name = _name;
@synthesize deal = _deal;
@synthesize address = _address;
@synthesize contact = _contact;
@synthesize regular = _regular;
@synthesize AllTime = _AllTime;
@synthesize premiun = _premiun;
@synthesize discount = _discount;
@synthesize ContainerView = _ContainerView;
@synthesize BarImageView = _BarImageView;
@synthesize premiumLine = _premiumLine;
@synthesize titleback = _titleback;


- (void) setBar:(PFObject *)bar{
    if (bar!=_bar) {
        _bar = bar;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ScrollView.delegate = self;
    
    NSLog(@"%@",[self.bar objectForKey:@"name"]);
    
    self.ScrollView.backgroundColor = [self getColor:@"222222"];
    self.name.text = [self.bar objectForKey:@"name"];
    self.name.textColor=[self getColor:@"33CC66"];
    
    self.deal.text = [self.bar objectForKey:@"AllSpecial"];
    self.deal.textColor=[self getColor:@"FF9900"];
    
    self.address.text = [self.bar objectForKey:@"address"];
    self.address.textColor=[self getColor:@"DDDDDD"];
    
    
    self.contact.text = [self.bar objectForKey:@"Contact"];
    self.contact.textColor=[self getColor:@"DDDDDD"];
    
    self.regular.text = @"Regular Happy Hour";
    self.regular.textColor=[self getColor:@"0088CB"];
    
    self.AllTime.text = [self.bar objectForKey:@"AllTime"];
    self.AllTime.textColor=[self getColor:@"CC3300"];
    
    self.premiun.text = @"Premiun Member";
    self.premiun.textColor=[self getColor:@"0088CB"];
    
    self.discount.text = @"Premiun discount Member";
    self.discount.textColor=[self getColor:@"FF9900"];
    
    self.BarImageView.image = [UIImage imageNamed:@"Activity_indicator.png"]; // placeholder image
    
    self.BarImageView.file = (PFFile *)[self.bar objectForKey:@"image_file"]; // remote image
    
    

    
//    if (self.parentViewController) {
//        ListViewTabController *parent = (ListViewTabController *)self.parentViewController;
//        parent.TableViewContainer.frame=CGRectMake(0, 0, 320, 455);
//    }
    
    
    //NSLog(@"%f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.height,self.view.frame.size.width);
    
    //NSLog(@"%f,%f,%f,%f",self.ScrollView.frame.origin.x,self.ScrollView.frame.origin.y,self.ScrollView.frame.size.height,self.ScrollView.frame.size.width);
    //NSLog(@"%f,%f",self.ScrollView.contentSize.height,self.ScrollView.contentSize.width);
    
    
    // Set content size
    //self.ScrollView.frame = CGRectMake(0, 0, 320, 455);

    //self.ScrollView.contentSize = CGSizeMake(320, 280);
    
	// Do any additional setup after loading the view.
    
}

-(void) viewDidAppear:(BOOL)animated{

    NSLog(@"%@",self.ContainerView);
    
    //position setting
    CGSize SpecialSize = [[self.bar objectForKey:@"AllSpecial"] sizeWithFont:self.deal.font constrainedToSize:CGSizeMake(240, 1000) lineBreakMode:self.premiun.lineBreakMode];
    
    self.deal.frame= CGRectMake(self.deal.frame.origin.x, self.deal.frame.origin.y, self.deal.frame.size.width, SpecialSize.height);
    
    
    CGFloat premiumy = self.deal.frame.origin.y + SpecialSize.height +5;
    self.premiun.frame = CGRectMake(self.premiun.frame.origin.x, premiumy, self.premiun.frame.size.width, self.premiun.frame.size.height);
    
    
    self.premiumLine.frame = CGRectMake(self.premiumLine.frame.origin.x, premiumy+self.premiun.frame.size.height, self.premiumLine.frame.size.width, self.premiumLine.frame.size.height);
    
    CGFloat discounty = self.premiumLine.frame.origin.y+self.premiumLine.frame.size.height+5;
    
    
    CGSize DiscountSize = [self.discount.text sizeWithFont:self.discount.font forWidth:240 lineBreakMode:self.discount.lineBreakMode];
    
    self.discount.frame = CGRectMake(self.discount.frame.origin.x, discounty, self.discount.frame.size.width, DiscountSize.height);
    
    self.BarMapView.frame =CGRectMake(self.BarMapView.frame.origin.x, discounty+DiscountSize.height+10, self.BarMapView.frame.size.width, self.BarMapView.frame.size.height);
    
    
    self.ScrollView.frame = self.view.frame;
    // self.ScrollView.contentSize = self.ContainerView.frame.size;
    self.ScrollView.contentSize = CGSizeMake(320, self.BarMapView.frame.origin.y+240);
    
    NSLog(@"FRAME: %f,%f,%f,%f",self.ScrollView.frame.origin.x,self.ScrollView.frame.origin.y,self.ScrollView.frame.size.height,self.ScrollView.frame.size.width);
    NSLog(@"CONTENTSIZE: %f,%f",self.ScrollView.contentSize.height,self.ScrollView.contentSize.width);
    
    NSLog(@"1: %f,%f",self.deal.frame.size.width,self.deal.frame.size.height);


}

- (void)viewWillAppear:(BOOL)animated{
    
    

    NSLog(@"2: %f,%f",self.deal.frame.size.width,self.deal.frame.size.height);
    

}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    if (self.bar) {
        PFGeoPoint *geoPoint = self.bar[@"latlong_geo"];
        //NSLog(@"%f", geoPoint.latitude);
        //NSLog(@"%f", geoPoint.longitude);
        // center our map view around this geopoint
        self.BarMapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
        // add the annotation
        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.bar];
        [self.BarMapView addAnnotation:annotation];
        
    }
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
