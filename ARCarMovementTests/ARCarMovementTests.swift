//
//  ARCarMovementTests.swift
//  ARCarMovementTests
//
//  Created by Antony Raphel on 01/11/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//

import XCTest
@testable import ARCarMovement
@testable import GoogleMaps

class ARCarMovementTests: XCTestCase {

    var movement: ARCarMovement!
    var mView: GMSMapView!
    var m: GMSMarker!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        movement = ARCarMovement.init()
        let camera = GMSCameraPosition.camera(withLatitude: 40.7416627, longitude: -74.0049708, zoom: 14)
        mView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let coodinate = CLLocationCoordinate2DMake(40.7416627, -74.0049708)
        m = GMSMarker.init(position: coodinate)
        m.map = mView
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movement = nil
        m = nil
        mView = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        movement.delegate = self
        movement.arCarMovement(marker: m,
                               oldCoordinate: CLLocationCoordinate2DMake(12.0000, 17.000),
                               newCoordinate: CLLocationCoordinate2DMake(22.000, 22.000),
                               mapView: mView)
        
    }
}

extension ARCarMovementTests: ARCarMovementDelegate {
    func arCarMovementMoved(_ marker: GMSMarker) {
        // TEST it
        XCTAssertFalse(m != marker)
    }
}
