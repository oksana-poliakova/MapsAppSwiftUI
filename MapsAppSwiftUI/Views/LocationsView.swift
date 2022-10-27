//
//  LocationsView.swift
//  MapsAppSwiftUI
//
//  Created by Oksana on 25.10.2022.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: LocationsViewModel
    
    init(viewModel: StateObject<LocationsViewModel>) {
        self._viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            viewModel.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(
                                latitude: 41.8902,
                                longitude: 12.4922),
                                span: MKCoordinateSpan(
                                    latitudeDelta: 0.1,
                                    longitudeDelta: 0.1))
                        }
                    }
                }
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
                
                ZStack {
                    LocationPreviewView(location: viewModel.mapLocation, viewModel: _viewModel)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
        .sheet(item: $viewModel.sheetLocation) { location in
            LocationDetailView(location: location, viewModel: _viewModel )
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView(viewModel: .init(wrappedValue: LocationsViewModel(locations: LocationsDataService.locations)))
    }
}

// MARK: - Extensions

extension LocationsView {
    
    // Header
    private var header: some View {
        VStack {
            Button(action: viewModel.toggleLocationsList) {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                    }
            }
            if viewModel.showLocationsList {
                LocationsListView(viewModel: _viewModel)
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    // Map layer
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotaionView(location: location, viewModel: _viewModel)
            }
        })
    }
}
