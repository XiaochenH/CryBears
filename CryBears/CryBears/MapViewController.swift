//
//  MapViewController.swift
//  CryBears
//
//  Created by Yunfang Xiao on 11/28/18.
//  Copyright © 2018 韩笑尘. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    var ref: DatabaseReference?
    var Handle: DatabaseHandle?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        ref = Database.database().reference()
        
        ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var array = [[String: Any?]]()
            
            guard let children = snapshot.children.allObjects as? [DataSnapshot]
                else { return }
            
            for child in children {
                guard let dict = child.value as? [String: Any] else { continue }
                array.append(["content": dict["content"], "lat": dict["lat"], "lon": dict["lon"]])
            }
            
            print(array)
            
            array.forEach { item in
                print(item)
                let userpin = MKPointAnnotation()
                let coord = CLLocationCoordinate2DMake(item["lat"] as! CLLocationDegrees, item["lon"] as! CLLocationDegrees)
                userpin.coordinate = coord
                userpin.title = item["content"] as? String
                self.map.addAnnotation(userpin)
                
            }
        })
        
        
    }
    
    //2
    func setupLocationManager() {
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //4
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            map.setRegion(region, animated: true)
            
            
        }
    }
    
    //1
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    //3
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            map.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.startUpdatingLocation()
        let myLocation = location.coordinate
        
        let region = MKCoordinateRegion(center: myLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        map.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
