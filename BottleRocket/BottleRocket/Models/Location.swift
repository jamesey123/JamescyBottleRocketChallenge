//
//  Location.swift
//  BottleRocket
//
//  Created by Jamescy on 3/6/22.
//

import Foundation
import CoreLocation

struct Location:Codable {
    let address:String
    let crossStreet:String?
    let lat:Double
    let lng:Double
    let postalCode:String?
    let cc:String
    let city:String
    let state:String
    let country:String
    let formattedAddress:[String]
    
}

