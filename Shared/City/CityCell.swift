//
//  CityCell.swift
//  Quick Map
//
//  Created by Chatsopon Deepateep on 12/6/2565 BE.
//

import SwiftUI

struct CityCell: View {
    let city: City
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(city.name), \(city.country)")
                Text("\(city.coord.lat, specifier: "%.6f"), \(city.coord.lon, specifier: "%.6f")")
                    .font(.subheadline)
                    .foregroundColor(.primary.opacity(0.85))
            }
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

struct CityCell_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            CityCell(
                city: City(
                    country: "Thailand",
                    name: "Bangkok",
                    _id: 137449612,
                    coord: CityCoordinate(lat: 13.7449612, lon: 100.5376454))
            )
            .padding()
        }
    }
}
