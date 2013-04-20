//
//  DetailViewController.m
//  a2happyhour
//
//  Created by William Zhang on 3/21/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import "DetailViewController.h"

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



- (void) setBar:(PFObject *)bar{
    if (bar!=_bar) {
        _bar = bar;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ScrollView.delegate = self;

    
    // Set content size
    self.ScrollView.frame = CGRectMake(0, 44, 320, 455);

    self.ScrollView.contentSize = CGSizeMake(320, 780);
    //self.ScrollView.frame = self.view.frame;
    
    
	// Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@",[self.bar objectForKey:@"name"]);
    
    self.ScrollView.backgroundColor = [self getColor:@"222222"];
    self.name.text = [self.bar objectForKey:@"name"];
    self.name.textColor=[self getColor:@"cc3366"];

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
    self.AllTime.textColor=[self getColor:@"FF9900"];

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
