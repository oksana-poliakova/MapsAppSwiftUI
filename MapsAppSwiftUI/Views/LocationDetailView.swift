//
//  LocationDetailView.swift
//  MapsAppSwiftUI
//
//  Created by Oksana Poliakova on 27.10.2022.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    // MARK: - Properties
    
    private let location: Location
    @StateObject private var viewModel: LocationsViewModel
    
    // MARK: - Init
    
    init(location: Location, viewModel: StateObject<LocationsViewModel>) {
        self.location = location
        self._viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!, viewModel: .init(wrappedValue: LocationsViewModel(locations: LocationsDataService.locations)))
    }
}

// MARK: - Extensions

extension LocationDetailView {
    // Image section
    private var imageSection: some View {
        TabView {
            ForEach(location.imagesNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 420)
        .tabViewStyle(PageTabViewStyle())
    }
    
    // Title section
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
             Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    // Description section
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue )
            }
        }
    }
    
    // Map layer
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01 ))),
            annotationItems: [location ]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotaionView(location: location, viewModel: _viewModel)
                    .shadow(radius: 10)
            }
        }
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(10)
            .allowsTightening(false)
    }
    
    // Back button
    private var backButton: some View {
        Button {
            viewModel.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}
