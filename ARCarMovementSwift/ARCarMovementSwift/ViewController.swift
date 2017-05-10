//
//  ViewController.swift
//  ARCarMovementSwift
//
//  Created by Mac05 on 04/05/17.
//  Copyright © 2017 Antony Raphel. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate, ARCarMovementDelegate {

    
    var driverMarker: GMSMarker!
    var mapView: GMSMapView! = nil
    var moveMent: ARCarMovement!
    var coordinateArr = NSArray()
    var oldCoordinate: CLLocationCoordinate2D!
    var timer: Timer! = nil
    var counter: NSInteger!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //alloc
        //
        moveMent = ARCarMovement()
        moveMent.delegate = self
        
        //alloc array and load coordinate from json file
        //
        do {
            if let file = Bundle.main.url(forResource: "coordinates", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                    coordinateArr = NSArray(array: object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
        //set old coordinate
        //
        oldCoordinate = CLLocationCoordinate2DMake(40.7416627, -74.0049708)
        
        // Create a GMSCameraPosition that tells the map to display the marker
        //
        let camera = GMSCameraPosition.camera(withLatitude: 40.7416627, longitude: -74.0049708, zoom: 14)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        view = mapView
        
        // Creates a marker in the center of the map.
        //
        driverMarker = GMSMarker()
        driverMarker.position = oldCoordinate
        driverMarker.icon = UIImage(named: "car")
        driverMarker.map = mapView
        
        //set counter value 0
        //
        counter = 0
        
        //start the timer, change the interval based on your requirement
        //
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.timerTriggered), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - scheduledTimerWithTimeInterval Action
    func timerTriggered() {
        if counter < coordinateArr.count {
            
            let dict = coordinateArr[counter] as? Dictionary<String,AnyObject>
            
            let newCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(dict!["lat"] as! Float), CLLocationDegrees(dict!["long"] as! Float))
            /**
             *  You need to pass the created/updating marker, old & new coordinate, mapView and bearing value from driver
             *  device/backend to turn properly. Here coordinates json files is used without new bearing value. So that
             *  bearing won't work as expected.
             */
            moveMent.arCarMovement(driverMarker, withOldCoordinate: oldCoordinate, andNewCoordinate: newCoordinate, inMapview: mapView, withBearing: 0)
            oldCoordinate = newCoordinate
            counter = counter + 1
            //increase the value to get all index position from array
        }
        else {
            timer.invalidate()
            timer = nil
        }
    }

    // MARK: - ARCarMovementDelegate
    func arCarMovement(_ movedMarker: GMSMarker) {
        driverMarker = movedMarker
        driverMarker.map = mapView
        
        //animation to make car icon in center of the mapview
        //
        let updatedCamera = GMSCameraUpdate.setTarget(driverMarker.position, zoom: 15.0)
        mapView.animate(with: updatedCamera)
    }


}

