//
//  GeoPointAnnotation.m
//  Geolocations
//
//  Created by Héctor Ramos on 8/2/12.
//  Copyright (c) 2013 Parse, Inc. All rights reserved.
//

#import "GeoPointAnnotation.h"

@interface GeoPointAnnotation()

@end

@implementation GeoPointAnnotation


#pragma mark - Initialization

- (id)initWithObject:(PFObject *)aObject {
    self = [super init];
    if (self) {
        _object = aObject;
        
        PFGeoPoint *geoPoint = self.object[@"latlong_geo"];
        [self setGeoPoint:geoPoint];
    }
    return self;
}



#pragma mark - MKAnnotation

/*
// Called when the annotation is dragged and dropped. We update the geoPoint with the new coordinates.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:newCoordinate.latitude longitude:newCoordinate.longitude];
    [self setGeoPoint:geoPoint];
    [self.object setObject:geoPoint forKey:@"latlong"];
    [self.object saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Send a notification when this geopoint has been updated. MasterViewController will be listening for this notification, and will reload its data when this notification is received.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"geoPointAnnotiationUpdated" object:self.object];
        }
    }];
}
*/

#pragma mark - ()

- (void)setGeoPoint:(PFGeoPoint *)geoPoint {
    _coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    _title = [self.object objectForKey:@"name"];
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }
    
    static NSNumberFormatter *numberFormatter = nil;
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 3;
    }
    _subtitle = [self.object objectForKey:@"AllSpecial"];
    //_subtitle = [NSString stringWithFormat:@"%@, %@", [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.latitude]],
   //              [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.longitude]]];
    
}

@end
