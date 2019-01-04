//
//  ARCarMovement.swift
//  ARCarMovement
//
//  Created by Antony Raphel on 24/10/17.
//  Copyright © 2017 Antony Raphel. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import GoogleMaps

private extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

private extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

// MARK: - delegate protocol
@objc public protocol ARCarMovementDelegate {
    
    /**
     *  Tells the delegate that the specified marker will be move with animation.
     * - Parameters:
     *     - marker: The *marker* return updated marker with animation.
     */
    func arCarMovementMoved(_ marker: GMSMarker)
}

@objcMembers public class ARCarMovement: NSObject {
    
    // MARK: Public properties
    /** ARCarMovement delegate. */
    public weak var delegate: ARCarMovementDelegate?
    /**
     * Controls the animation duration.  Default value is 2.0.
     */
    public var duration: Float = 2.0
    
    /**
     * Convenience constructor marker animation properties as per
     * arCarMovementWithMarker:oldCoordinate:newCoordinate:mapView:bearing:.
     * - Parameters:
     *     - marker: The *marker* is given marker.
     *     - oldCoordinate: The *oldCoordinate* is old value of coordinate.
     *     - newCoordinate: The *newCoordinate* is new value of coordinate.
     *     - mapView: The *mapView* is represention of view.
     *     - bearing: The *bearing* is camera's position on an arc between directly over the map's center position and the surface of the Earth. Default value is 0.
     */
    public func arCarMovement(marker: GMSMarker, oldCoordinate: CLLocationCoordinate2D, newCoordinate:CLLocationCoordinate2D, mapView: GMSMapView, bearing: Float = 0) {
        
        //calculate the bearing value from old and new coordinates
        //
        let calBearing: Float = getHeadingForDirection(fromCoordinate: oldCoordinate, toCoordinate: newCoordinate)
        marker.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
        marker.rotation = CLLocationDegrees(calBearing); //found bearing value by calculation when marker add
        marker.position = oldCoordinate; //this can be old position to make car movement to new position
        
        //marker movement animation
        CATransaction.begin()
        CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock({() -> Void in
            marker.rotation = (Int(bearing) != 0) ? CLLocationDegrees(bearing) : CLLocationDegrees(calBearing)
        })
        
        // delegate method pass value
        //
        delegate?.arCarMovementMoved(marker)
        
        marker.position = newCoordinate; //this can be new position after car moved from old position to new position with animation
        marker.map = mapView;
        marker.rotation = CLLocationDegrees(calBearing);
        CATransaction.commit()
    }
    
    private func getHeadingForDirection(fromCoordinate fromLoc: CLLocationCoordinate2D, toCoordinate toLoc: CLLocationCoordinate2D) -> Float {
        
        let fLat: Float = Float((fromLoc.latitude).degreesToRadians)
        let fLng: Float = Float((fromLoc.longitude).degreesToRadians)
        let tLat: Float = Float((toLoc.latitude).degreesToRadians)
        let tLng: Float = Float((toLoc.longitude).degreesToRadians)
        let degree: Float = (atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng))).radiansToDegrees
        return (degree >= 0) ? degree : (360 + degree)
    }
}
