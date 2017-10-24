//
//  ARCarMovement.swift
//  ARCarMovement
//
//  Created by Mac05 on 24/10/17.
//  Copyright © 2017 Antony Raphel. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

// MARK: - delegate protocol
@objc public protocol ARCarMovementDelegate {
    
    /**
     *  Tells the delegate that the specified marker will be move with animation.
     */
    func ARCarMovementMoved(_ Marker: GMSMarker)
}

public class ARCarMovement: NSObject {

    // MARK: Public properties
    public weak var delegate: ARCarMovementDelegate?
    public var duration: Float = 2.0
    
    public func ARCarMovement(marker: GMSMarker, oldCoordinate: CLLocationCoordinate2D, newCoordinate:CLLocationCoordinate2D, mapView: GMSMapView, bearing: Float) {
    
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
        delegate?.ARCarMovementMoved(marker)
    
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
