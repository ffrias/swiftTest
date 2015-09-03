//
//  Catalog.swift
//  swiftTest
//
//  Created by Federico Frias on 8/25/15.
//  Copyright (c) 2015 Bminds. All rights reserved.
//

import Foundation

class Song {
    var image: String!
    var name: String!
    var track: String!
    var price: String!
    
    init(image: String, name: String, track: String, price: String){
        self.image = image
        self.name = name
        self.track = track
        self.price = price
    }
   
    func getImage()->String{
        return self.image
    }
    
    func getName()->String{
        return self.name
    }
    
    func getPrice()->String{
        return self.price
    }
    
    func getTrack()->String{
        return self.track
    }
}