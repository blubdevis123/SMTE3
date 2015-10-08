//
//  ViewController.swift
//  GetLocationtest
//
//  Created by JN Schouten on 08/10/15.
//  Copyright © 2015 JN Schouten. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var mkvLocations: MKMapView!
    
    private let locationManager = CLLocationManager()
    private let regionRadius: CLLocationDistance = 5000
    private var persons = [MKPointAnnotation]()
    var initialLocation = CLLocation(
        latitude: 51.4365957,
        longitude: 5.4780014)
    
    
    override func viewDidLoad() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        //temporary when no locationdevices enabled
        addAnnotation("Me", location: CLLocationCoordinate2D(
            latitude: 51.4365957,
            longitude: 5.4780014
            )
        )
        centerMapOnLocation(initialLocation)
        super.viewDidLoad()
        
                // Do any additional setup after loading the view, typically from a nib.
    }
    func locationManager(manager: CLLocationManager!, idUpdateLocations locations: [AnyObject]!) {
        initialLocation = CLLocation(
            latitude: manager.location!.coordinate.latitude,
            longitude: manager.location!.coordinate.longitude
        )
        print("locations = \(initialLocation)")
    }
    
    
    
    func addAnnotation(title: String, subtitle: String,location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        mkvLocations.addAnnotation(annotation)
    }
    
    func addAnnotation(title: String,location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        mkvLocations.addAnnotation(annotation)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mkvLocations.setRegion(coordinateRegion, animated: true)
    }
}

