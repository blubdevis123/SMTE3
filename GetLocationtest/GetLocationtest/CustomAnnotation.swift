//
//  CustomMapView.swift
//  GetLocationtest
//
//  Created by Fhict on 15/10/15.
//  Copyright © 2015 Fhict. All rights reserved.
//

import MapKit
import UIKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var distance: Double?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
    }
    
    func calculateDistance(sourceCoordinate: CLLocationCoordinate2D){
        let source = CLLocation(latitude: sourceCoordinate.latitude, longitude: sourceCoordinate.longitude)
        let destination = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        self.distance = destination.distanceFromLocation(source)
    }
    
    func getDistance()-> Double{
        return self.distance!
    }
}