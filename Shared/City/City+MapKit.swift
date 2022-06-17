//
//  City+MapKit.swift
//  Quick Map
//
//  Created by Chatsopon Deepateep on 12/6/2565 BE.
//

import MapKit

extension City {
    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center:
                CLLocationCoordinate2D(latitude: coord.lat, longitude: coord.lon),
            span:
                MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    }
}
