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
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()

            }
            
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel(locations: LocationsDataService.locations))
    }
}

extension LocationsView {
    
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
                LocationsListView() 
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}
