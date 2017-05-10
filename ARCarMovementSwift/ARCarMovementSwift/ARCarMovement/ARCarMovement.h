//
//  ARCarMovement.h
//  ARCarMovement
//
//  Created by Mac05 on 04/05/17.
//  Copyright © 2017 Antony Raphel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (x * 180.0 / M_PI)

#pragma mark - delegate protocol
@protocol ARCarMovementDelegate <NSObject>

@optional
/**
 *  Tells the delegate that the specified marker will be work with animation.
 */
- (void)ARCarMovement:(GMSMarker *)movedMarker;

@end


@interface ARCarMovement : NSObject

#pragma mark - Public properties
/**
 *  The object that acts as the delegate of the ARCarMovement.
 */
@property (nonatomic, weak) id <ARCarMovementDelegate> delegate;

/**
 *  assign the specified details to be work with animation for the Marker.
 */
- (void)ARCarMovement:(GMSMarker *)marker withOldCoordinate:(CLLocationCoordinate2D)oldCoordinate andNewCoordinate:(CLLocationCoordinate2D)newCoordinate inMapview:(GMSMapView *)mapView withBearing:(float)newBearing;

@end
