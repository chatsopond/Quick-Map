//
//  ExploreView.swift
//  Quick Map
//
//  Created by Chatsopon Deepateep on 11/6/2565 BE.
//

import SwiftUI
import MapKit
import Combine

class ExploreViewModel: ObservableObject {
    @Published var regionTitle = "Bangkok, TH"
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.7468665, longitude: 100.5368355),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    @Published var isPresentedSearchView = false
}

struct ExploreView: View {
    @StateObject var viewModel = ExploreViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region)
                .ignoresSafeArea()
            
            // Text Field
            CardRectangle(color: .background2)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                            .padding(6)
                        Spacer()
                    }.padding(.leading, 10)
                )
                .overlay(
                    Text(viewModel.regionTitle)
                        .lineLimit(1)
                        .background(Color.background2)
                        .padding(.horizontal)
                )
                .padding()
                .onTapGesture {
                    viewModel.isPresentedSearchView = true
                }
            
            // Search View
            if viewModel.isPresentedSearchView {
                SearchView(
                    isPresented: $viewModel.isPresentedSearchView.animation(),
                    mapTitle: $viewModel.regionTitle,
                    mapRegion: $viewModel.region
                )
                .zIndex(100)
            }
        }
        .animation(.default, value: viewModel.isPresentedSearchView)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
