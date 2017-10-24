//
//  ViewController.h
//  ARCarMovement
//
//  Created by Mac05 on 04/05/17.
//  Copyright © 2017 Antony Raphel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ARCarMovement-Swift.h"

@interface ViewController : UIViewController <GMSMapViewDelegate> {
    GMSMarker *driverMarker;
}
@property (strong, nonatomic) NSMutableArray *CoordinateArr;
@property (strong, nonatomic) GMSMapView *mapView;
@property CLLocationCoordinate2D oldCoordinate;
@property (weak, nonatomic) NSTimer *timer;
@property NSInteger counter;

@end

