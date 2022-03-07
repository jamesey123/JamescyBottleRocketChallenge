//
//  Restaurant.swift
//  BottleRocket
//
//  Created by Jamescy on 3/6/22.
//

import Foundation

struct Restaurant:Codable {
    let name:String
    let backgroundImageURL:String
    let category: String
    let contact:Contact?
    let location:Location?
    
}
