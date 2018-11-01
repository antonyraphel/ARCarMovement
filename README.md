# ARCarMovement

[![CI Status](https://img.shields.io/travis/antonyraphel/ARCarMovement.svg?style=flat)](https://travis-ci.org/antonyraphel/ARCarMovement)
[![Version](https://img.shields.io/cocoapods/v/ARCarMovement.svg?style=flat)](https://cocoapods.org/pods/ARCarMovement)
[![License](https://img.shields.io/cocoapods/l/ARCarMovement.svg?style=flat)](https://cocoapods.org/pods/ARCarMovement)
[![Platform](https://img.shields.io/cocoapods/p/ARCarMovement.svg?style=flat)](https://cocoapods.org/pods/ARCarMovement)

This is navigation example on google map. Here Marker move as vehicles moves with turns as uber does in their app. Using old and new coordinates animating bearing value the markers are moving.

<img src="https://raw.githubusercontent.com/antonyraphel/ARCarMovement/30b4fa26fc4f14abaef5da147544db8d558b1c18/screenshot/image-1.png" width = "60%" align="middle">


## Getting Started

To run the project, clone the repo, and run `pod install`  from the ARCarMovement directory first.

## Installation

ARCarMovement is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ARCarMovement'
```

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
- In App delegate or where you want to import, add the following : **#import "ARCarMovement-Swift.h"**  **NOTE:** #import "< Defined Module Name >-Swift.h"

Add the following import statement to your ViewController.h as follows:

```
#import "ARCarMovement-Swift.h" // NOTE: #import "<Your Defined Module Name>-Swift.h"
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

ARCarMovement is available under the MIT license. See the LICENSE file for more info.



