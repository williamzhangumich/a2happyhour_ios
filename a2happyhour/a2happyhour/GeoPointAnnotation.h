//
//  GeoPointAnnotation.h
//  Geolocations
//
//  Created by Héctor Ramos on 8/2/12.
//  Copyright (c) 2013 Parse, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface GeoPointAnnotation : NSObject <MKAnnotation>

- (id)initWithObject:(PFObject *)aObject;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, strong) PFObject *object;

@end
