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
    //self.ScrollView.contentSize = self.ContainerView.frame.size;
    //self.ScrollView.frame = self.view.frame;
    
    
	// Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@",[self.bar objectForKey:@"name"]);
    self.name.text = [self.bar objectForKey:@"name"];
    self.deal.text = [self.bar objectForKey:@"AllSpecial"];
    
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

@end
