//
//  GlowAct.swift
//  HellGlow
//
//  Created by Fhict on 10/09/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import Foundation


class GlowAct{
    private var name = ""
    private var startTime = ""
    private var rating = 0
    
    init(name:String, startTime:String, rating:Int){
        self.name = name
        self.startTime = startTime
        self.rating = rating
    }
    func showInfo(){
        println("The act is called \(name) and starts at \(startTime). It is given an average rating of \(rating)")
    }
}
