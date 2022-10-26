//
//  LocationsView.swift
//  MapsAppSwiftUI
//
//  Created by Oksana on 25.10.2022.
//

import SwiftUI

struct LocationsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    // MARK: - Body
    
    var body: some View {
        List {
            ForEach(viewModel.locations) {
                Text($0.name)
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
