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
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel(locations: LocationsDataService.locations))
    }
}
