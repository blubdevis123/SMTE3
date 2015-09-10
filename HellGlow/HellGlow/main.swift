//
//  main.swift
//  HellGlow
//
//  Created by Fhict on 10/09/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import Foundation

println("Helloglow, World!")


var glow = GlowAct(name: "The Bluelight act", startTime: "22:20", rating: 8)
glow.showInfo()

var city = City(name: "Eindhoven", population: 220000)
city.showInfo()

city.addAct(glow)
city.addAct(GlowAct(name: "Redlight", startTime: "23:00", rating: 7))
city.addAct(GlowAct(name: "Greenlight", startTime: "15:40", rating: 9))

city.showActs()



