//
//  Person.swift
//  GetLocationtest
//
//  Created by Fhict on 08/10/15.
//  Copyright © 2015 Fhict. All rights reserved.
//

import Foundation
import MapKit

class Person: NSObject, MKAnnotation {
    let title: String
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String {
        return locationName
    }
}