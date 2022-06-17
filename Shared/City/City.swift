//
//  City.swift
//  Quick Map
//
//  Created by Chatsopon Deepateep on 11/6/2565 BE.
//

import Foundation

struct CityCoordinate: Codable {
    var lat: Double
    var lon: Double
}

struct City: Codable, Identifiable {
    var country: String
    var name: String
    var _id: Int
    var coord: CityCoordinate
    
    var id: Int {
        return _id
    }
}
