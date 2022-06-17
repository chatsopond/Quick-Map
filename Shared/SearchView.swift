//
//  SearchView.swift
//  Quick Map
//
//  Created by Chatsopon Deepateep on 11/6/2565 BE.
//

import SwiftUI
import MapKit

class SearchViewModel: ObservableObject {
    let citySession = CitySession()
    
    @Published var searchResult: [City] = []
    @Published var isFocusSearchText: Bool = false
    @Published var searchText = ""
    
    @MainActor
    func search(_ string: String) {
        searchResult = citySession.search(with: string) ?? []
    }
}

struct SearchView: View {
    @Binding var isPresented: Bool
    @Binding var mapTitle: String
    @Binding var mapRegion: MKCoordinateRegion
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            content
                .frame(maxWidth: .infinity)
        }
        .onAppear {
            viewModel.isFocusSearchText = true
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            searchField
            RoundedRectangle(cornerRadius: 1)
                .foregroundColor(.secondary)
                .frame(height: 0.33)
                .shadow(color: .black, radius: 4, x: 0, y: 4)
                .padding(.top, 6)
            searchContent
        }
    }
    
    var searchField: some View {
        CardRectangle(color: .textField)
            .overlay(
                HStack {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary.opacity(0.65))
                    }
                    LegacyTextField(
                        isFirstResponder: $viewModel.isFocusSearchText,
                        text: $viewModel.searchText,
                        placeholder: "Search…")
                    .onChange(of: viewModel.searchText) { newValue in
                        viewModel.search(newValue)
                    }
                    Button {
                        viewModel.searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.primary.opacity(0.65))
                    }
                }.padding()
            )
            .padding()
    }
    
    var searchContent: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                Color.clear
                ForEach(viewModel.searchResult) { city in
                    CityCell(city: city)
                        .onTapGesture {
                            mapTitle = "\(city.name), \(city.country)"
                            mapRegion = city.region
                            isPresented = false
                        }
                    Divider()
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            isPresented: .constant(true),
            mapTitle: .constant("Bangkok, TH"),
            mapRegion: .constant(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 13.7468665, longitude: 100.5368355),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
        )
    }
}
