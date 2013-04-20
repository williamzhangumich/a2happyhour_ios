//
//  DetailViewController.h
//  a2happyhour
//
//  Created by William Zhang on 3/21/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "GeoPointAnnotation.h"

@interface DetailViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) PFObject *bar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *deal;
@property (weak, nonatomic) IBOutlet MKMapView *BarMapView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;


//@property (weak, nonatomic) IBOutlet UIView *ContainerView;

@end
