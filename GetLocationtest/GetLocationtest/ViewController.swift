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
    private let regionRadius: CLLocationDistance = 500
    private var persons = [MKPointAnnotation]()
    private var initialLocation = CLLocation(
        latitude: 51.4365957,
        longitude: 5.4780014)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locateMe()
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func locateMe(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            if(locationManager.location != nil){
                initialLocation = CLLocation(
                    latitude: locationManager.location!.coordinate.latitude,
                    longitude: locationManager.location!.coordinate.longitude
                )
                addAnnotation("Me",subtitle: getCurrentTime() ,location: locationManager.location!.coordinate)
            }
        }
        centerMapOnLocation(initialLocation)
    }
    
    func getCurrentTime() -> String{
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        return DateInFormat
    }
    
    func addAnnotation(title: String, subtitle: String,location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        mkvLocations.addAnnotation(annotation)
    }
    
    @IBAction func btResetView(sender: AnyObject) {
        locateMe()
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

