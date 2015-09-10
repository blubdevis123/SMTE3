//
//  City.swift
//  HellGlow
//
//  Created by Fhict on 10/09/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import Foundation

class City {
    private var name = ""
    private var population = 0
    private var glowActs = [GlowAct]()
    
    init(name:String, population:Int){
        self.name = name
        if population > 0{
            self.population = population
        }
    }
    func showInfo(){
        println("In the city of \(name) there are currently living \(population) people.")
    }
    func addAct(glowAct:GlowAct){
        glowActs.append(glowAct)
    }
    func showActs(){
        for glowact in glowActs{
            glowact.showInfo()
        }
        println("This city has \(glowActs.count) events")
    }
}