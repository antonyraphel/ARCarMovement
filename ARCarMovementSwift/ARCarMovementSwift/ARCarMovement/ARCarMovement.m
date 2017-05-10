//
//  ARCarMovement.m
//  ARCarMovement
//
//  Created by Mac05 on 04/05/17.
//  Copyright © 2017 Antony Raphel. All rights reserved.
//

#import "ARCarMovement.h"

@implementation ARCarMovement

-(void)ARCarMovement:(GMSMarker *)marker withOldCoordinate:(CLLocationCoordinate2D)oldCoordinate andNewCoordinate:(CLLocationCoordinate2D)newCoordinate inMapview:(GMSMapView *)mapView withBearing:(float)newBearing {
    
    //calculate the bearing value from old and new coordinates
    //
    float calBearing = [self getHeadingForDirectionFromCoordinate:oldCoordinate toCoordinate:newCoordinate]; //found bearing value by calculation
    marker.groundAnchor = CGPointMake(0.5, 0.5);
    marker.rotation = calBearing; //found bearing value by calculation when marker add
    marker.position = oldCoordinate; //this can be old position to make car movement to new position
    
    //marker movement animation
    //
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    [CATransaction setCompletionBlock:^{
        
        if (newBearing != 0) {
            marker.rotation = newBearing; //New bearing value from backend after car movement is done
        }
        else {
            marker.rotation = calBearing; //found bearing value by calculation old and new Coordinates
        }
        
        // delegate method pass value
        //
        if (self.delegate && [self.delegate respondsToSelector:@selector(ARCarMovement:)]) {
            [self.delegate ARCarMovement:marker];
        }
    }];
    
    marker.position = newCoordinate; //this can be new position after car moved from old position to new position with animation
    marker.map = mapView;
    marker.rotation = calBearing;
    [CATransaction commit];
}

- (float)getHeadingForDirectionFromCoordinate:(CLLocationCoordinate2D)fromLoc toCoordinate:(CLLocationCoordinate2D)toLoc
{
    float fLat = degreesToRadians(fromLoc.latitude);
    float fLng = degreesToRadians(fromLoc.longitude);
    float tLat = degreesToRadians(toLoc.latitude);
    float tLng = degreesToRadians(toLoc.longitude);
    
    float degree = radiansToDegrees(atan2(sin(tLng-fLng)*cos(tLat), cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(tLng-fLng)));
    
    if (degree >= 0) {
        return degree;
    }
    else {
        return 360+degree;
    }
}

@end
