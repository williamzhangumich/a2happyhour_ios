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
    
    
    self.BarsMapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(42.279206, -83.745421), MKCoordinateSpanMake(0.01f, 0.011f));
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"a2hh04012013"];
    [query whereKeyExists:@"latlong_geo"];
    
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

- (IBAction)ToMyLocation:(id)sender {
    
    CLLocationCoordinate2D Coordinates = [self.MyLocation coordinate];
    
    //NSLog(@"%f", Coordinates.latitude);
    //NSLog(@"%f", Coordinates.longitude);
    
    self.BarsMapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(Coordinates.latitude, Coordinates.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(GeoPointAnnotation<MKAnnotation>*)annotation
{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
        aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //aView.leftCalloutAccessoryView.frame = CGRectMake(0, 0, 100, 100);
        //aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        // could put a rightCalloutAccessoryView here
    }
    
    aView.annotation = annotation;
    //[(UIImageView *)aView.leftCalloutAccessoryView setImage:nil];
    
    
    
    return aView;
   
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView
{
    //(GeoPointAnnotation<MKAnnotation> *) GeoAnnotation = aView.annotation;
    
    //GeoPointAnnotation* GeoAnnotation =  aView.annotation;
    //NSLog(@"%@",[GeoAnnotation.object objectForKey:@"name"]);
    //UIImage *image = [self.BarsMapView.delegate mapViewController:self imageForAnnotation:aView.annotation];
    //[(UIImageView *)aView.leftCalloutAccessoryView setImage:image];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    GeoPointAnnotation* GeoAnnotation =  view.annotation;
    PFObject* bar = GeoAnnotation.object;
    
    [self performSegueWithIdentifier:@"detail" sender:bar];
    //NSLog(@"tapped for annotation %@", [GeoAnnotation.object objectForKey:@"name"]);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(PFObject*)sender{
    if ([segue.identifier isEqualToString:@"detail"]) {
        [(DetailViewController *)segue.destinationViewController setBar:sender];
    }
}

#pragma mark - Autorotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


@end
