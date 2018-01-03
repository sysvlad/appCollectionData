//
//  Map.swift
//  balinaSoft
//
//  Created by Vlad Sys on 12/13/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation


class map : UIViewController,CLLocationManagerDelegate{
    
    @IBOutlet weak var navBtn: UIBarButtonItem!
    
    var locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    
    
   
    
    override func viewDidLoad() {
        GMSServices.provideAPIKey("AIzaSyCLSjfE7qMM37xcO6hC_4iCNzTXIf2wVCg")
       
        let camera = GMSCameraPosition.camera(withLatitude: 53.875788, longitude: 27.451869, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 53.875788, longitude: 27.451869)
        marker.title = "Home"
        marker.snippet = "Sweet Home"
        marker.map = mapView
        
       
        
        // User Location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        navBtn.target = self.revealViewController();
        navBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        self.view = mapView
        
        locationManager.stopUpdatingLocation()
    }
  
}
