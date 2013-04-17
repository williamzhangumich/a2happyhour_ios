//
//  MapViewTabController.h
//  a2happyhour
//
//  Created by William Zhang on 4/12/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "GeoPointAnnotation.h"
#import "DetailViewController.h"

@interface MapViewTabController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *BarsMapView;
@property (strong, nonatomic) CLLocationManager *MyLocationManager;
@end
