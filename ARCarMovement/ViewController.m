//
//  ViewController.m
//  ARCarMovement
//
//  Created by Mac05 on 04/05/17.
//  Copyright © 2017 Antony Raphel. All rights reserved.
//

#import "ViewController.h"

//@class ARCarMovement;

@interface ViewController () <ARCarMovementDelegate>

@property (strong, nonatomic) ARCarMovement *moveMent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //alloc
    //
    self.moveMent = [[ARCarMovement alloc]init];
    self.moveMent.delegate = self;
    
    //alloc array and load coordinate from json file
    //
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"coordinates" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    self.CoordinateArr = [[NSMutableArray alloc]initWithArray:[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil]];
    
    //set old coordinate
    //
    self.oldCoordinate = CLLocationCoordinate2DMake(40.7416627,-74.0049708);

    // Create a GMSCameraPosition that tells the map to display the marker
    //
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.7416627
                                                            longitude:-74.0049708
                                                                 zoom:14];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
    self.view = self.mapView;
    
    // Creates a marker in the center of the map.
    //
    driverMarker = [[GMSMarker alloc] init];
    driverMarker.position = self.oldCoordinate;
    driverMarker.icon = [UIImage imageNamed:@"car"];
    driverMarker.map = self.mapView;
    
    //set counter value 0
    //
    self.counter = 0;
    
    //start the timer, change the interval based on your requirement
    //
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerTriggered) userInfo:nil repeats:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scheduledTimerWithTimeInterval Action
-(void)timerTriggered {
    
    if (self.counter < self.CoordinateArr.count) {
        
        CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake([self.CoordinateArr[self.counter][@"lat"] floatValue],[self.CoordinateArr[self.counter][@"long"] floatValue]);
        
        /**
         *  You need to pass the created/updating marker, old & new coordinate, mapView and bearing value from backend
         *  to turn properly. Here coordinates json files is used without new bearing value. So that
         *  bearing won't work as expected.
         */
        [self.moveMent ARCarMovementWithMarker:driverMarker oldCoordinate:self.oldCoordinate newCoordinate:newCoordinate mapView:self.mapView bearing:0];  //instead value 0, pass latest bearing value from backend
        
        self.oldCoordinate = newCoordinate;
        self.counter = self.counter + 1; //increase the value to get all index position from array
    }
    else {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - ARCarMovementDelegate
- (void)ARCarMovementMoved:(GMSMarker * _Nonnull)Marker {
    driverMarker = Marker;
    driverMarker.map = self.mapView;
    
    //animation to make car icon in center of the mapview
    //
    GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:driverMarker.position zoom:15.0f];
    [self.mapView animateWithCameraUpdate:updatedCamera];
}

@end
