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


class map : UIViewController{
    
    @IBOutlet weak var navBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        GMSServices.provideAPIKey("AIzaSyCLSjfE7qMM37xcO6hC_4iCNzTXIf2wVCg")
        let camera = GMSCameraPosition.camera(withLatitude: 53.89 , longitude: 27.56, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
       
        mapView.isMyLocationEnabled = true
        view = mapView
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 53.89, longitude: 27.56)
        marker.title = "Minsk"
        marker.snippet = "Belarus"
        marker.map = mapView 
        
        navBtn.target = self.revealViewController();
        navBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
