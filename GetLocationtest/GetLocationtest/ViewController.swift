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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate{
    @IBOutlet weak var mkvLocations: MKMapView!
    
    private let regionRadius: CLLocationDistance = 50
    private var locationManager = CLLocationManager()
    private var initialLocation = CLLocation(
        latitude: 51.4365957,
        longitude: 5.4780014)
    
    override func viewDidLoad() {
        mkvLocations.showsUserLocation = true
        super.viewDidLoad()
        initLocationManager()
        
        let lpgr = UILongPressGestureRecognizer(target: self, action:"handleLongPress:")
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.mkvLocations.addGestureRecognizer(lpgr)
        mkvLocations.delegate = self
    }
    
    func initLocationManager(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            if(locationManager.location != nil){
                initialLocation = CLLocation(
                    latitude: locationManager.location!.coordinate.latitude,
                    longitude: locationManager.location!.coordinate.longitude
                )
            }
            
        }
        centerMapOnLocation(initialLocation)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        initialLocation = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
    }
    
    
    func getCurrentTime() -> String{
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        return DateInFormat
    }
    
    func addAnnotation(title: String, subtitle: String, location: CLLocationCoordinate2D){
        /*let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        mkvLocations.addAnnotation(annotation)*/
        if(title != ""){
        let annotation = CustomAnnotation(coordinate: location, title: title, subtitle: subtitle)
        mkvLocations.addAnnotation(annotation)
        }else{
            let alertController = UIAlertController(title: "Error", message:
                "Please enter a name!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btResetView(sender: AnyObject) {
        initLocationManager()
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
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        let touchLocation = gestureReconizer.locationInView(self.mkvLocations)
        let locationCoordinate = self.mkvLocations.convertPoint(touchLocation,toCoordinateFromView: self.mkvLocations)
        
        if gestureReconizer.state != UIGestureRecognizerState.Ended {

            let alert = UIAlertController(title: "Spot a friend", message: "", preferredStyle: .Alert)
            
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.attributedPlaceholder = NSAttributedString(string:"Name")
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
            }))
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as UITextField
                let annotationsToRemove = self.mkvLocations.annotations.filter { $0.title! == textField.text }
                self.mkvLocations.removeAnnotations( annotationsToRemove )
                self.addAnnotation(textField.text!, subtitle: self.getCurrentTime(), location: locationCoordinate)

            }))
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        if gestureReconizer.state != UIGestureRecognizerState.Began {
            return
        }
    }
    
    func mapView(MapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "CustomAnnotation"
        
        if annotation.isKindOfClass(CustomAnnotation.self) {
            var annotationView = MapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView!.canShowCallout = true

                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
                
            } else {
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        return nil
    }
    
    
    func mapView(MapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let ca = view.annotation as! CustomAnnotation
        let placeName = ca.title
        let distance = getDistance(self.mkvLocations.userLocation.coordinate, destinationCoordinate: ca.coordinate)
        let placeInfo: String
        if(distance >= 1000){
             placeInfo = "Time spotted: " + ca.subtitle! + "\r\nDistance: " + String(format:"%1.1f", (distance / 1000)) + " KM"
        }else{
             placeInfo = "Time spotted: " + ca.subtitle! + "\r\nDistance: " + String(format:"%1.f", distance) + " Meter"
        }
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        ac.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: {(alert: UIAlertAction) in
            if let annotation = view.annotation as? CustomAnnotation {
                self.mkvLocations.removeAnnotation(annotation)
            }
        }))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func getDistance(sourceCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) -> Double{
        let source = CLLocation(latitude: sourceCoordinate.latitude, longitude: sourceCoordinate.longitude)
        let destination = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        
        return destination.distanceFromLocation(source)
        
    }
}

