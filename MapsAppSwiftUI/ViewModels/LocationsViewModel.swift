//
//  LocationsViewModel.swift
//  MapsAppSwiftUI
//
//  Created by Oksana on 26.10.2022.
//

import Foundation

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]

    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
