//
//  Location.swift
//  MapsAppSwiftUI
//
//  Created by Oksana on 25.10.2022.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imagesNames: [String]
    let link: String
    
    var id: String {
        name + cityName
    }
}