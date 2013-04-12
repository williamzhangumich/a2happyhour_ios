//
//  MapViewTabController.m
//  a2happyhour
//
//  Created by William Zhang on 4/12/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import "MapViewTabController.h"

@interface MapViewTabController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocation *MyLocation;
@property (strong, nonatomic) NSArray *BarObjects;

@end

@implementation MapViewTabController
@synthesize BarsMapView = _BarsMapView;
@synthesize MyLocationManager = _MyLocationManager;
@synthesize MyLocation = _MyLocation;


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
    [[self locationManager] startUpdatingLocation];
    CLLocation *location = self.MyLocationManager.location;
    
    if (self.MyLocation!=location) {
        NSLog(@"New Location: %@",location);
        self.MyLocation = location;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CLLocationManager *)locationManager {
    if (self.MyLocationManager != nil) {
        return self.MyLocationManager;
    }
    
    self.MyLocationManager = [[CLLocationManager alloc] init];
    [self.MyLocationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [self.MyLocationManager setDelegate:self];
    //[self.MyLocationManager setPurpose:@"Using your location to search for nearby happy hours!"];
    
    return self.MyLocationManager;
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    /*
    if (self.bar) {
        PFGeoPoint *geoPoint = self.bar[@"latlong"];
        NSLog(@"%f", geoPoint.latitude);
        NSLog(@"%f", geoPoint.longitude);
        // center our map view around this geopoint
        
        // add the annotation
        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.bar];
        [self.BarMapView addAnnotation:annotation];
        
    }
     */
    
}

-(void)viewDidAppear:(BOOL)animated{
    CLLocationCoordinate2D Coordinates = [self.MyLocation coordinate];
    
    //NSLog(@"%f", Coordinates.latitude);
    //NSLog(@"%f", Coordinates.longitude);
    self.BarsMapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(Coordinates.latitude, Coordinates.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
    
    PFQuery *query = [PFQuery queryWithClassName:@"a2hh"];
    [query whereKeyExists:@"latlong"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            if ([self.BarObjects isEqualToArray:objects] ){
                NSLog(@"no need to update");
            }else{
                self.BarObjects = objects;
                NSLog(@"Successfully retrieved %d bars with latlong.", objects.count);
            }
            
        for (PFObject* bar in self.BarObjects){
            //NSLog(@"%@", [bar objectForKey:@"name"]);
            GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:bar];
            [self.BarsMapView addAnnotation:annotation];
            
        }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
