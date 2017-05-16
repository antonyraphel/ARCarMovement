# ARCarMovement

This is navigation example on google map. Here Marker move as vehicles moves with turns as uber does in their app. Using old and new coordinates animating bearing value the markers are moving.


![ARCarMovement Screenshot](https://raw.githubusercontent.com/antonyraphel/ARCarMovement/30b4fa26fc4f14abaef5da147544db8d558b1c18/screenshot/image-1.png) {:height="30%" width="30%"}

## Getting Started

For running this demo project, you need to add latest Google Maps SDK with Key. You can download the Google Maps SDK and just drag and drop into this project.

* [Google Maps APIs](https://developers.google.com/maps/documentation/ios-sdk/start) - Get the Google Maps iOS SDK

### Prerequisites

To build a project using the ARCarMovement for iOS, you need version 7.3 or later of Xcode.

#### Usage

Add your Google Maps API key to your AppDelegate.m as follows:

```
[GMSServices provideAPIKey:@"YOUR_API_KEY"];
```

Add the following import statement to your ViewController.h as follows:


```
#import "ARCarMovement.h"
```

Create a ARCarMovement property in ViewController.h:

```
@property (strong, nonatomic) ARCarMovement *moveMent;

//alloc
//
self.moveMent = [[ARCarMovement alloc]init];
self.moveMent.delegate = self;
```

The required datasource method is

```
/**
*  assign the specified details to be work with animation for the Marker.
*/
- (void)ARCarMovement:(GMSMarker *)marker withOldCoordinate:(CLLocationCoordinate2D)oldCoordinate andNewCoordinate:(CLLocationCoordinate2D)newCoordinate inMapview:(GMSMapView *)mapView withBearing:(float)newBearing;

```

The required datasource method is

```
/**
*  Tells the delegate that the specified marker will be work with animation.
*/
- (void)ARCarMovement:(GMSMarker *)movedMarker;
```

## Author

**Antony Raphel** - *Initial work* - [ARCarMovement](https://github.com/antonyraphel/ARCarMovement)

Created by Antony Raphel, [@antonypr717](https://twitter.com/antonypr717) on 06/05/17.

## Contact

Share feedbacks and ideas to improve this project, I would love to hear them out. You can also follow me on [@antonypr717](https://twitter.com/antonypr717).

## License

The MIT License (MIT)

Copyright (c) 2017 Antony Raphel

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



