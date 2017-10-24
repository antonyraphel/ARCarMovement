# ARCarMovement

This is navigation example on google map. Here Marker move as vehicles moves with turns as uber does in their app. Using old and new coordinates animating bearing value the markers are moving.


![ARCarMovement Screenshot](https://raw.githubusercontent.com/antonyraphel/ARCarMovement/30b4fa26fc4f14abaef5da147544db8d558b1c18/screenshot/image-1.png) <!-- .element height="50%" width="50%" -->

## Getting Started

For running this demo project, you need to add latest Google Maps SDK with Key. You can download the Google Maps SDK and just drag and drop into this project.

* [Google Maps APIs](https://developers.google.com/maps/documentation/ios-sdk/start) - Get the Google Maps iOS SDK

### Prerequisites

To build a project using the ARCarMovement for iOS, you need version 8.0 or later of Xcode.

#### Usage

Add your Google Maps API key to your AppDelegate.m as follows:

```
[GMSServices provideAPIKey:@"YOUR_API_KEY"];
```

For Objective-C Project:
- Drag and drop the **ARCarMovement.swift** into your project.
- A popup window will appear and ask "Would You like to configure an Objective-C bridging Header".
- Choose Yes.
- Click on your Xcode Project file (optional)
- Click on Build Settings
- Find the Search bar and search for **Defines Module**.
- Change the value to **Yes**.
- In App delegate or where you want to import, add the following : **#import "YourProjectName-Swift.h"**

Add the following import statement to your ViewController.h as follows:

```
#import "ARCarMovement-Swift.h"
```

Create a ARCarMovement property in ViewController.m:

```
@property (strong, nonatomic) ARCarMovement *moveMent;

//alloc
//
self.moveMent = [[ARCarMovement alloc]init];
self.moveMent.delegate = self;
```

The required public method is

```
/**
*  assign the specified details to be work with animation for the Marker.
*/
public func ARCarMovement(marker: GMSMarker, oldCoordinate: CLLocationCoordinate2D, newCoordinate:CLLocationCoordinate2D, mapView: GMSMapView, bearing: Float) {
  //code here
}

```

The required delegate method is

```
/**
*  Tells the delegate that the specified marker will be work with animation.
*/
- (void)ARCarMovementMoved:(GMSMarker * _Nonnull)Marker;
```

For Swift project, just drag and drop the **ARCarMovement.swift** into your project.  

## Author

**Antony Raphel** - *Initial work* - [ARCarMovement](https://github.com/antonyraphel/ARCarMovement)

Created by Antony Raphel, [@antonypr717](https://twitter.com/antonypr717) on 06/05/17.

## Contact

Share feedbacks and ideas to improve this project, I would love to hear them out. You can also follow me on [@antonypr717](https://twitter.com/antonypr717).

## License

MIT License

Copyright (c) 2017 Antony Raphel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.



