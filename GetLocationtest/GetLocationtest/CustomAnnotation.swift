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
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
    }
}