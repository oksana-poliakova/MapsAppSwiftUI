//
//  MapsAppSwiftUIApp.swift
//  MapsAppSwiftUI
//
//  Created by Oksana on 25.10.2022.
//

import SwiftUI

@main
struct MapsAppSwiftUIApp: App {
    
    @StateObject private var viewModel = LocationsViewModel(locations: LocationsDataService.locations)
    
    var body: some Scene {
        WindowGroup {
            LocationsView(viewModel: _viewModel)
        }
    }
}
