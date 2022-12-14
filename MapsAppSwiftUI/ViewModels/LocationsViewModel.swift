//
//  LocationsViewModel.swift
//  MapsAppSwiftUI
//
//  Created by Oksana on 26.10.2022.
//

import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    private var index: Int = 0
    
    @Published var locations: [Location]
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var showLocationsList: Bool = false
    @Published var sheetLocation: Location? = nil 
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // MARK: - Init
    
    init(locations: [Location]) {
        let mockLocation = Location(name: "", cityName: "", coordinates: CLLocationCoordinate2D(), description: "", imagesNames: [], link: "")
        self.locations = locations
        mapLocation = locations.first ?? mockLocation
        updateMapRegion(location: locations.first ?? mockLocation)
    }
    
    // MARK: - Functions
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        if index < locations.count - 1 {
            index = index + 1
            let nextLocation = locations[index]
            showNextLocation(location: nextLocation)
        } else {
            index = 0
            nextButtonPressed()
        }
    }
}
